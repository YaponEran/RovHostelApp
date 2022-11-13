class AddRoleIndexByIdAndTitle < ActiveRecord::Migration[6.1]
  def change
    add_index :roles, [:title, :individual_id], unique: true
  end
end
