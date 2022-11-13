class RemoveRoleTitleIndex < ActiveRecord::Migration[6.1]
  def change
    remove_index :roles, name: "index_roles_on_title"
  end
end
