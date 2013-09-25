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


  def apply_tags(comment, item, taggable)
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
    end
  end

  def update_raiting(item)
    item.update_attribute(:raiting, (item.followers_count_cache + 1)*2 + item.cached_comments + item.impressionist_count(:filter=>:all))
  end

  def set_access_control_headers 
    headers['Access-Control-Allow-Origin'] = 'http://hochuli.ru/' 
    headers['Access-Control-Request-Method'] = '*' 
  end

end
