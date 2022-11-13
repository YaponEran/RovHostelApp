class AddIndividualNullFalseOption < ActiveRecord::Migration[6.1]
  def change
    change_column :users, :individual_id, :integer, null: false
  end
end
