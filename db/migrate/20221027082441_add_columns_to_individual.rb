class AddColumnsToIndividual < ActiveRecord::Migration[6.1]
  def change
    add_column :individuals, :phone, :string, null: false
    add_column :individuals, :email, :string, null: false
    add_index :individuals, :phone, unique: true
    add_index :individuals, :email, unique: true
  end
end
