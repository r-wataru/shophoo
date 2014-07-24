class CreateHistories < ActiveRecord::Migration
  def change
    create_table :histories do |t|
      t.references :user, null: false
      t.references :organization, null: false
      t.references :item, null: false
      t.text :message

      t.timestamps
    end
    
    add_index :histories, [ :user_id, :item_id ], unique: true
  end
end