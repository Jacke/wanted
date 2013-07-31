#encoding: utf-8
class ItemsController < ApplicationController
  def new
    @items = Item.order("created_at DESC")
  end

  def male
    @items = Item.where(sex: params[:sex]).order("created_at DESC")
    render :popular
  end

  def popular
    @items = Item.order('cached_votes_total DESC').order('cached_comments DESC')
  end

  def create
    @item = Item.new(params[:item])
    @collection_id = params[:collection_id]
    @url = clean_url(params[:item][:url])

    # привязываем к магазину
    if not @url.empty?
      @shop_url = @url.split("/").first
      @shop = Shop.where(url: @shop_url).first

      if @shop.nil?
        @shop = Shop.create(url: @shop_url)
      end
      @item.shop_id = @shop.id
    end

    @item.user = current_user
    if @item.save
      current_user.follow(@item)
      if @collection_id.to_i != -1
        @collection = Collection.find_by_id(@collection_id)
        @collection.follow(@item)
      end

      return render :json => {:success => true}
    else
      return render :json => {:success => false, :errors => @item.errors.full_messages}
    end
  end

  def show
    @item = Item.find_by_id(params[:id])
    @shop = @item.shop
    @user = @item.user
    @followers = @item.followers_by_type('User').limit(8)
    @followers_count = @followers.length
    @comment = Comment.new
    @comments = @item.comments.order("created_at DESC")

    if user_signed_in?
      @collections = current_user.collections
      @collection = Collection.new
    end
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
    @item = Item.find_by_id(item_id)

    current_user.follow(@item)

    if collection_id.to_i != -1
      @collection = Collection.find_by_id(collection_id)
      @collection.follow(@item)
      @respond = {ans: "Товар успешно добавлен в коллекцию #{@collection.title}"}
    else
      @respond = {ans: "Товар успешно добавлен"}
    end

    respond_to do |format|
      format.json {render json:  @respond, status:  :ok}
      format.any(:html,:xml) {render status:  404}
    end
  end

  private

  def clean_url(url)
    s = url.sub(/^https?\:\/\//, '').sub(/^www./,'')
  end
end
