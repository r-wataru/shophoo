class CreateUserTokens < ActiveRecord::Migration
  def change
    create_table :user_tokens do |t|
      t.references :user, null: false
      t.string :value, null: false

      t.timestamps
    end
    
    add_index :user_tokens, :value
  end
end
