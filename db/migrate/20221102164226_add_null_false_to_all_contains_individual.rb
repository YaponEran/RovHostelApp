class AddNullFalseToAllContainsIndividual < ActiveRecord::Migration[6.1]
  def change
    change_column :hotels, :individual_id, :integer, null: false
    change_column :buildings, :individual_id, :integer, null: false
    change_column :rooms, :individual_id, :integer, null: false
    change_column :roles, :individual_id, :integer, null: false
  end
end
