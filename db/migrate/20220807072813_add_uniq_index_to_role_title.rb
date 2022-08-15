class AddUniqIndexToRoleTitle < ActiveRecord::Migration[6.1]
  def change
    add_index :roles, :title, unique: true
  end
end
