#encoding: utf-8
class ItemsController < ApplicationController
  def new
    @items = Item.order("created_at DESC")
  end

  def create
    @item = Item.new(params[:item])
    @collection_name = params[:collection_name]

    unless @collection_name.empty?
      @collection = Collection.new

      @collection.user = current_user
      @collection.title = @collection_name
      if @collection.save
        @item.collection = @collection
      end
    end

    @item.user = current_user
    if @item.save
      return render :json => {:success => true}
    else
      return render :json => {:success => false, :errors => @item.errors.full_messages}
    end
  end

  def popular
    @items = Item.order('cached_votes_total DESC').order('cached_comments DESC')
  end

  def show
    @item = Item.find_by_id(params[:id])
    @user = @item.user
    @comment = Comment.new
    @comments = @item.comments.order("created_at DESC")
    @collections = current_user.collections
  end

  def up
    @item = Item.find_by_id(params[:id])
    @item.liked_by current_user
    @respond = {item:{rating: @item.cached_votes_total}}

    respond_to do |format|
      format.json {render json:  @respond, status:  :ok}
      format.any(:html,:xml) {render status:  404}
    end
  end

  def add
    item_id = params[:id]
    collection_id = params[:collection_id]

    @respond = {ans: 'Товар успешно добавлен в коллекцию'}

    respond_to do |format|
      format.json {render json:  @respond, status:  :ok}
      format.any(:html,:xml) {render status:  404}
    end
  end

end
