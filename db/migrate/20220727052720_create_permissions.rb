class CreatePermissions < ActiveRecord::Migration[6.1]
  def change
    create_table :permissions do |t|
      t.references :role, foreign_key: true
      t.string :subject, null: false
      t.string :action, null: false

      t.timestamps
    end

    add_index :permissions, :subject
    add_index :permissions, :action
    add_index :permissions, %i[role_id subject action], unique: true
  end
end
