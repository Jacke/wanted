#encoding: utf-8
class ItemsController < ApplicationController
  def new
    # товары
    if params[:position]
      #@items = Item.where("id < #{params[:position].to_i}").order("created_at DESC").limit(6)
      @items = Item.paginate(:page => params[:position], :per_page => Setting.items_per_page).order('id DESC')
      if @items.empty?
        return render :json => {:status => 0}
      else
        render partial: "users/items_grid"
      end
    else
      @items = Item.order("created_at DESC").limit(Setting.items_per_page)
    end

    # комментарии
    if params[:get_comments]
      @comments = Comment.paginate(:page => params[:get_comments], :per_page => Setting.comments_per_page).order('id DESC')
      if @comments.empty?
        return render :json => {:status => 0}
      else
        render partial: "comments"
      end
    else
      @comments = Comment.order("created_at DESC").limit(Setting.comments_per_page)
    end
  end

  def male
    if params[:position]
      @items = Item.where(sex: params[:sex]).paginate(:page => params[:position], :per_page => Setting.items_per_page).order('created_at DESC')
      if @items.empty?
        return render :json => {:status => 0}
      else
        render partial: "users/items_grid"
      end
    else
      @items = Item.where(sex: params[:sex]).order('created_at DESC').limit(Setting.items_per_page)
    end
  end

  def popular
    if params[:position]
      @items = Item.paginate(:page => params[:position], :per_page => Setting.items_per_page).order('raiting DESC')
      if @items.empty?
        return render :json => {:status => 0}
      else
        render partial: "users/items_grid"
      end
    else
      @items = Item.order('raiting DESC').limit(Setting.items_per_page)
    end
  end

  def tags
    if params[:tag]
      @items = Item.tagged_with(params[:tag])
    else
      @items = Item.all
    end
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

      apply_tags(@item.comment,@item, @item) if not @item.comment.empty?
      #mentions(@item.comment, @item, 'comment')

      return render :json => {:success => true, :message => 'Товар успешно добавлен'}
    else
      return render :json => {:success => false, :errors => @item.errors.full_messages}
    end
  end

  def show
    @item = Item.find_by_id(params[:id])
    @shop = @item.shop
    @user = @item.user
    @followers = @item.followers_by_type('User').limit(8)
    @comment = Comment.new
    @comments = @item.comments.order("created_at DESC")
    @tags = @item.tags
    @foll_collections = @item.followers_by_type('Collection')
    @foll_items = @user.following_by_type('Item').limit(6).order("raiting DESC")

    if user_signed_in?
      @collections = current_user.collections
      @collection = Collection.new
    end
  end

  #def up
  #  @item = Item.find_by_id(params[:id])
  #  @item.liked_by current_user
  #  @respond = {item:{rating: @item.cached_votes_total}}
  #
  #  respond_to do |format|
  #    format.json {render json:  @respond, status:  :ok}
  #    format.any(:html,:xml) {render status:  404}
  #  end
  #end

  def add
    item_id = params[:id]
    collection_id = params[:collection_id]
    @item = Item.find_by_id(item_id)

    current_user.follow(@item)
    up_followers_cache(@item)
    update_raiting(@item)

    if collection_id.to_i != -1
      @collection = Collection.find_by_id(collection_id)
      @collection.follow(@item)
      @respond = {ans: "Добавлено в коллекцию \"#{@collection.title}\""}
    else
      @respond = {ans: "Товар успешно добавлен"}
    end

    respond_to do |format|
      format.json {render json:  @respond, status:  :ok}
      format.any(:html,:xml) {render status:  404}
    end
  end
  
  def remove
    item_id = params[:item_id]
    if Item.find_by_id(item_id).destroy # NSFW
      @respond = {ans: "Товар удален"}
    end

    respond_to do |format|
      format.json {render json:  @respond, status:  :ok}
      format.any(:html,:xml) {render status:  404}
    end
  end

  def change_url
    item_id = params[:id]
    if Item.find_by_id(item_id).update_attribute :url, params[:url]
      @respond = {ans: "Адрес изменен"}
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

  def up_followers_cache(item)
    if item.followers_count_cache == 0
      item.update_attribute(:followers_count_cache, item.count_user_followers - 1)
    else
      item.update_attribute(:followers_count_cache, item.followers_count_cache + 1) unless current_user.following?(item)
    end
  end
end
