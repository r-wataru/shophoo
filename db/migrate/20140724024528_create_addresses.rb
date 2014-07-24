class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :type, null: false
      t.references :user
      t.references :organization
      t.string :country_code
      t.string :zip_code
      t.string :state
      t.string :city
      t.string :address1
      t.string :address2
      t.string :phone
      t.string :mobile
      t.string :fax
      t.date :birthday
      t.string :sex

      t.timestamps
    end
  end
end