class UsersNotifySettings < ActiveRecord::Migration
  def self.up
    add_column :users, :follow_notice, :boolean, default: true
    add_column :users, :reply_notice, :boolean, default: true
    add_column :users, :new_item_notice, :boolean, default: true
  end
  def self.down
   remove_column :users, :follow_notice, :boolean
   remove_column :users, :reply_notice, :boolean
   remove_column :users, :new_item_notice, :boolean
  end
end
