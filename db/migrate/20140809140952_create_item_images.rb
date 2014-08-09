class CreateItemImages < ActiveRecord::Migration
  def change
    create_table :item_images do |t|
      t.references :item, null: false
      t.binary :thumbnail_data, limit: 20.megabytes
      t.string :thumbnail_content_type
      t.binary :data1, limit: 20.megabytes
      t.string :data1_content_type
      t.binary :data2, limit: 20.megabytes
      t.string :data2_content_type
      t.binary :data3, limit: 20.megabytes
      t.string :data3_content_type

      t.timestamps
    end
    add_index :item_images, :item_id
  end
end
