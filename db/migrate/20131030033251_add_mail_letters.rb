class AddMailLetters < ActiveRecord::Migration
  def change
      create_table :mail_letters, :force => true do |t|
      t.integer :user_id
      t.integer :item_id
      t.boolean :sended
      t.timestamps
      end

  end
end
