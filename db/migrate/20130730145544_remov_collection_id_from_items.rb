class RemovCollectionIdFromItems < ActiveRecord::Migration
  def change
    remove_column :items, :collection_id
  end
end
