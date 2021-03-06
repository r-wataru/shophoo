class CreateOrganizationImages < ActiveRecord::Migration
  def change
    create_table :organization_images do |t|
      t.references :organization, null: false
      t.binary :thumbnail_data, limit: 20.megabytes
      t.string :thumbnail_content_type
      t.binary :data, limit: 20.megabytes
      t.string :content_type

      t.timestamps
    end
    add_index :organization_images, :organization_id
  end
end