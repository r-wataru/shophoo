class CreateUserImages < ActiveRecord::Migration
  def change
    create_table :user_images do |t|
      t.references :user, null: false
      t.binary :thumbnail_data
      t.string :thumbnail_content_type
      t.binary :data
      t.string :content_type

      t.timestamps
    end
    add_index :user_images, :user_id
  end
end