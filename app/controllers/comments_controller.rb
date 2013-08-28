#encoding: utf-8
class CommentsController < ApplicationController
  def create
    if user_signed_in?
      @item = Item.find(params[:id])
      @comments = @item.comments.order("created_at DESC")

      @comment = Comment.new(params[:comment])
      @comment.user_id = current_user.id
      @comment.item_id = @item.id
      repl_comm = item_comment(@comment.content.strip_tags, @item)
      tag_comm  = comment_tag(@comment.content)
        if repl_comm.nil? then repl_comm = "" end
        if tag_comm.nil? then tag_comm = "" end
      @comment.content = repl_comm + ' ' + tag_comm

      if @comment.save
        apply_tags(params[:comment][:content], @comment, @item)
        update_cached_comments(@item)
        update_raiting(@item)
        render partial: "shared/comments"
      else
        not_found
      end
    end
  end
  
  def remove
    comment_id = params[:id]
    if Comment.find(comment_id).destroy
      @respond = {ans: "Комментарий удален"}
    end

    respond_to do |format|
      format.json {render json:  @respond, status:  :ok}
      format.any(:html,:xml) {render status:  404}
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
end
