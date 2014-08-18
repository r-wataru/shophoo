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
      t.string :company_name
      t.text :about

      t.timestamps
    end
  end
end