class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name            ,:null => false, :default => ""
      t.integer :id_collection
      t.integer :sex            , :default => 0
      t.integer :prise          , :default => 0
      t.text :comment
      t.boolean :clothes        , :default => false

      t.timestamps
    end
  end
end
