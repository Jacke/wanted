class AddRaitingToItem < ActiveRecord::Migration
  def change
    add_column :items, :raiting, :integer, :default => 0
  end
end
