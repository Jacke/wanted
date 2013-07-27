#encoding: utf-8
class ItemsController < ApplicationController
  def new
    
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
    
  end

  def show
    @item = Item.find_by_id(params[:id])
    @user = @item.user
  end
end
