class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.references :organization, null: true
      t.string :code_name, null: false
      t.string :display_name, null: false
      t.integer :price, null: false, default: 0
      t.datetime :deleted_at
      t.integer :view_count, null: false, default: 0
      t.boolean :listable, null: false, default: false
      t.text :description

      t.timestamps
    end
    
    add_index :items, :organization_id
  end
end