class CollectionsController < ApplicationController
  def create
    #@item = Item.find_by_id(params[:id])
    @collections = current_user.collections

    @collection = Collection.new(params[:collection])
    @collection.user_id = current_user.id

    if @collection.save
      render partial: "collections/collections_list"
    else
      not_found
    end
  end
end
