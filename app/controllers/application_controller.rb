class ApplicationController < ActionController::Base

  protect_from_forgery

  @pop_tags = Item.tag_counts(:limit => 5, :order => "count desc")

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

  # упоминания
  def mentions(comment,item,column)
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
            linked_comment = comment.sub('@'+user.nickname,'<a href="'+user_show_path(user)+'">@'+user.nickname+'</a>')
            item.update_attribute(column, linked_comment)
          end
        end
      end
    end
  end

  # тэги
  def tags(comment, item)
    tag_list = []
    comment.gsub!(',', ', ')
    words_arr = comment.split
    words_arr.each do |word|
      if word[0] == '#'
        word.sub!(/^#/, '').sub!(/,$/, '')
        tag_list << word
      end

      unless tag_list.empty?
        tag_list << item.tag_list
        item.update_attribute(:tag_list, tag_list)
      end
    end
  end
end
