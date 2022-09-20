class CreateHotels < ActiveRecord::Migration[6.1]
  def change
    create_table :hotels do |t|
      t.string :title, null: false
      t.string :adress, null: false
      t.string :postcode, null: false
      t.string :phone_number, null: false
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end

    add_index :hotels, :title, unique: true
  end
end
