class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :pop_tags, :collections_list

#  after_filter :set_access_control_headers
  def pop_tags
    @pop_tags = Item.tag_counts.order("count desc").limit(5)
  end

  def collections_list
    if user_signed_in?
      @collections = current_user.collections
      @collection = Collection.new
    end
  end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

  # упоминания
  def new_item_comment(comment,item)
    linked_comment = comment
    item_comment = comment.split
    comment_arr = []
    item_comment.each do |comment_pars|
      if comment_pars.match(/^#/).blank?
        if comment_pars.match(/^@/).present?
          user = User.find_by(name: comment_pars.gsub('@', ''))
          if user.present?
            Mention.new(user_id: user.id, comment_id: item.id).save
            lkd_comment = comment_pars.gsub('@'+user.name,'<a href="'+user_show_path(user)+'">@'+user.name+'</a>')
            comment_arr << lkd_comment
          else 
          comment_arr << comment_pars 
          end  
        else
          comment_arr << comment_pars   
        end
      end
    end
   Comment.new(content: comment_arr.join(' '), user_id: item.user_id, item_id: item.id).save unless comment_arr.blank?
  end

  # тэги
  def apply_tags(comment , item , taggable)
    @tag_list = []
    @linked_comment = comment
    comment.gsub!(',', ', ')
    words_arr = comment.split
    words_arr.each do |word|
      if word[0] == '#'
        word.sub!(/^#/, '').sub!(/,$/, '')
        @linked_comment = @linked_comment.gsub('#'+word,'<a href="/tag/'+word+'">#'+word+'</a>')
        @tag_list << word
      end
    end

    unless @tag_list.empty?
      @tag_list << taggable.tag_list
      taggable.update_attribute(:tag_list, @tag_list)
      # item.update_attribute(:content, @linked_comment)
    end
  end

  def update_raiting(item)
    item.update_attribute(:raiting, (item.followers_count_cache + 1)*3 + item.cached_comments)
  end


def set_access_control_headers 
  headers['Access-Control-Allow-Origin'] = 'http://88.198.200.85/' 
  headers['Access-Control-Request-Method'] = '*' 
end

end
