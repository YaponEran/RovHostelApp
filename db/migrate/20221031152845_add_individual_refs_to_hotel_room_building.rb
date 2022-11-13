class AddIndividualRefsToHotelRoomBuilding < ActiveRecord::Migration[6.1]
  def change
    add_reference :hotels, :individual, foreign_key: true
    add_reference :buildings, :individual, foreign_key: true
    add_reference :rooms, :individual, foreign_key: true
  end
end
