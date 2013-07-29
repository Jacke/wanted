class AddCachedCommentsToItems < ActiveRecord::Migration
  def change
    add_column :items, :cached_comments, :integer, :default => 0
  end
end
