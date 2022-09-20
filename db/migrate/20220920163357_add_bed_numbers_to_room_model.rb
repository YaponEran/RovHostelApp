class AddBedNumbersToRoomModel < ActiveRecord::Migration[6.1]
  def change
    add_column :rooms, :bed_number, :integer, default: 0
  end
end
