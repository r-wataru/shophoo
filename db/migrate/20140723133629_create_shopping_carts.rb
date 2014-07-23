class CreateShoppingCarts < ActiveRecord::Migration
  def change
    create_table :shopping_carts do |t|
      t.references :user, null: false
      t.text :data

      t.timestamps
    end
  end
end