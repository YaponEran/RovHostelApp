class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.references :customer_user, null: false, foreign_key: true
      t.references :room, null: false, foreign_key: true
      t.datetime :start_at, null: false
      t.datetime :end_at, null: false
      
      t.timestamps
    end
  end
end
