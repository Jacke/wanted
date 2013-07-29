class CommentsController < ApplicationController
  def create
    if user_signed_in?
      @item = Item.find_by_id(params[:id])
      @comments = @item.comments.order("created_at DESC")

      @comment = Comment.new(params[:comment])
      @comment.user_id = current_user.id
      @comment.item_id = @item.id

      if @comment.save
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
      count = item.comments.count
    else
      count = item.cached_comments + 1
    end
    item.update_attribute(:cached_comments, count)
  end
end
