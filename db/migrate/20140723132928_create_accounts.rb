class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :type, null: false
      t.string :screen_name, null: false
      t.string :real_name, null: true
      t.string :family_name, null: true
      t.string :given_name, null: true
      t.string :password_digest, null: true
      t.date :birthday
      t.string :sex
      t.datetime :logged_at, null: true
      t.boolean :checked, null: false, default: false
      t.datetime :deleted_at

      t.timestamps
    end

    add_index :accounts, :screen_name, unique: true
  end
end