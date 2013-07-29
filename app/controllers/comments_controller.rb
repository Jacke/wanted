class CommentsController < ApplicationController
  def create
    if user_signed_in?
      @item = Item.find_by_id(params[:id])
      @comments = @item.comments.order("created_at DESC")

      @comment = Comment.new(params[:comment])
      @comment.user_id = current_user.id
      @comment.item_id = @item.id

      if @comment.save
        render partial: "shared/comments"
      else
        not_found
      end
    end
  end
end
