#encoding: utf-8
class ItemsController < ApplicationController
  def new
    
  end

  def create
    @item = Item.new(params[:item])
    @collection = Collection.new(params[:collection_name])

    @item.user = current_user
    if @item.save
      return render :json => {:success => true}
    else
      return render :json => {:success => false, :errors => @item.errors.full_messages}
      #render 'search/index'
    end

    #@post = Post.new(params[:post])
    #@post.user = current_user
    #if @post.save
    #  respond_to do |format|
    #    flash[:notice] = t("msg.saved")
    #    format.html {redirect_to edit_admin_post_url(@post)}
    #  end
    #else
    #  @errors = @post.errors.full_messages
    #  flash[:error] = t("msg.save_error")
    #  render :new
    #end
  end

  def popular
    
  end
end
