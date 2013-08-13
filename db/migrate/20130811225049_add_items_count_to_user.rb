class AddItemsCountToUser < ActiveRecord::Migration
  def self.up  
    add_column :users, :items_count, :integer, :default => 0  
      
    User.all.each do |p|  
      p.update_attribute :items_count, p.items.length  
    end  
  end  
  
  def self.down  
    remove_column :users, :items_count  
  end 
end
