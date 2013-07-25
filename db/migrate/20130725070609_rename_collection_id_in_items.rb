class RenameCollectionIdInItems < ActiveRecord::Migration
  def change
    rename_column :items, :id_collection, :collection_id
  end
end
