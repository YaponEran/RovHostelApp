class AddRankToRoles < ActiveRecord::Migration[6.1]
  def change
    add_column :roles, :role_rank, :integer, default: 0 
  end
end
