class Room < ApplicationRecord
  belongs_to :building

  OVERNIGHT_KIND = %w[Room Bed]
end
