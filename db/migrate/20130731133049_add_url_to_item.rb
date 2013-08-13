class AddUrlToItem < ActiveRecord::Migration
  def change
    add_column :items, :url, :string
    add_column :items, :shop_id, :integer
  end
end
