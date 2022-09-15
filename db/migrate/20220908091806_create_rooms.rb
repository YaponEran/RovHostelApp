class CreateRooms < ActiveRecord::Migration[6.1]
  def change
    create_table :rooms do |t|
      t.string :overnight_kind, null: false
      t.integer :total_room, null: false, default: 0
      t.integer :total_bed, null: false, default: 0
      t.boolean :has_air_con, null: false, default: false
      t.boolean :has_kitchen, null: false, default: false
      t.boolean :has_bath, null: false, default: false
      t.boolean :has_wifi, null: false, default: false
      t.belongs_to :building, null: false, foreign_key: true
      t.decimal :price, default: 0.0

      t.timestamps
    end
  end
end
