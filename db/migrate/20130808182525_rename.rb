class Rename < ActiveRecord::Migration
  def change
    rename_column :items, :followers_count, :followers_count_cache
  end
end
