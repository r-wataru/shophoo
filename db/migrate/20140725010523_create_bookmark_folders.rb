class CreateBookmarkFolders < ActiveRecord::Migration
  def change
    create_table :bookmark_folders do |t|
      t.references :user, null: false
      t.text :data
      
      t.timestamps
    end
  end
end
