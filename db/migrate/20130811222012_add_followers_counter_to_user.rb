class AddFollowersCounterToUser < ActiveRecord::Migration
  def change
    add_column :users, :followers_counter, :integer, :default => 0
  end
end
