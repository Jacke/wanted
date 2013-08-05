class AddMentionsNewCountToUsers < ActiveRecord::Migration
  def change
    add_column :users, :mentions_new_count, :integer, :default => 0
  end
end
