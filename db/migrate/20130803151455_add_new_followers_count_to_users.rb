class AddNewFollowersCountToUsers < ActiveRecord::Migration
  def change
    add_column :users, :followers_new_count, :integer, :default => 0
    add_column :users, :followed_by_new_count, :integer, :default => 0
  end
end
