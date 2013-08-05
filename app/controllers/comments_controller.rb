#encoding: utf-8
class CommentsController < ApplicationController
  def create
    if user_signed_in?
      @item = Item.find_by_id(params[:id])
      @comments = @item.comments.order("created_at DESC")

      @comment = Comment.new(params[:comment])
      @comment.user_id = current_user.id
      @comment.item_id = @item.id
      @comment.content = @comment.content.strip_tags

      if @comment.save
        mentions(@comment)
        update_cached_comments(@item)
        render partial: "shared/comments"
      else
        not_found
      end
    end
  end

  private

  def update_cached_comments(item)
    if item.cached_comments == 0
      item.cached_comments = item.comments.count
    else
      item.cached_comments = item.cached_comments + 1
    end

    item.update_attributes params[:cached_comments]
  end

  # упоминания
  def mentions(comment)
    mentions_arr = comment.content.split
    mentions_arr.each do |mention|
      if mention[0] == '@'
        mention.sub!(/^@/, '')
        user = User.where(nickname: mention).first

        unless user.blank?
          new_mention = Mention.new
          new_mention.user_id = user.id
          new_mention.comment_id = comment.id
          if new_mention.save
            linked_comment = comment.content.sub('@'+user.nickname,'<a href="'+user_show_path(user)+'">@'+user.nickname+'</a>')
            comment.update_attribute(:content, linked_comment)
          end
        end
      end
    end
  end
end
