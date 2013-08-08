class AddFollowersCountToItem < ActiveRecord::Migration
  def change
    add_column :items, :followers_count, :integer, :default => 0
    remove_column :items, :cached_votes_total
    remove_column :items, :cached_votes_score
    remove_column :items, :cached_votes_up
    remove_column :items, :cached_votes_down
  end
end
