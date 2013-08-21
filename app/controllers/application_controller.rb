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
  def mentions(comment,item,column)
    linked_comment = comment
    mentions_arr = comment.split
    mentions_arr.each do |mention|
      if mention[0] == '@'
        mention.sub!(/^@/, '').sub!(/,$/, '')

        user = User.where(nickname: mention).first

        unless user.blank?
          new_mention = Mention.new
          new_mention.user_id = user.id
          new_mention.comment_id = item.id
          if new_mention.save
            linked_comment = linked_comment.gsub('@'+user.nickname,'<a href="'+user_show_path(user)+'">@'+user.nickname+'</a>')
            item.update_attribute(column, linked_comment)
          end
        end
      end
    end
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
  headers['Access-Control-Allow-Origin'] = 'http://192.241.189.137/' 
  headers['Access-Control-Request-Method'] = '*' 
end

end
