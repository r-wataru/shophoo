class CreateNewEmails < ActiveRecord::Migration
  def change
    create_table :new_emails do |t|
      t.references :user, null: false
      t.string :address, null: false
      t.string :confirmation_token, null: false
      t.boolean :used, null: false, default: false

      t.timestamps
    end
  end
end