class CreateBuildings < ActiveRecord::Migration[6.1]
  def change
    create_table :buildings do |t|
      t.string :build_title, null: false
      t.string :build_postcode, null: false
      t.string :address, null: false
      t.string :phone_number, null: false
      t.references :hotel, null: false, foreign_key: true
      
      t.timestamps
    end
  end
end
