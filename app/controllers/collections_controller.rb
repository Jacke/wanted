#encoding: utf-8
class CollectionsController < ApplicationController
  def create
    #@item = Item.find(params[:id])
    @collections = current_user.collections

    @collection = Collection.new(params[:collection])
    @collection.user_id = current_user.id

    if @collection.save
      render partial: "collections/collections_list"
    else
      not_found
    end
  end

  def remove
    collection_id = params[:collection_id]
    if Collection.find(collection_id).destroy #NSFW
      @respond = {ans: "Коллекция удалена"}
    end

    respond_to do |format|
      format.json {render json:  @respond, status:  :ok}
      format.any(:html,:xml) {render status:  404}
    end
  end
end
