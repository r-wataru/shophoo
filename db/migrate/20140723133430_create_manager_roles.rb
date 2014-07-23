class CreateManagerRoles < ActiveRecord::Migration
  def change
    create_table :manager_roles do |t|
      t.references :user, null: false
      t.references :organization, null: false
      t.boolean :owner, null: false, default: false

      t.timestamps
    end
    
    add_index :manager_roles, [ :user_id, :organization_id ], unique: true
  end
end