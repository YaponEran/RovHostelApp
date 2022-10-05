class Reservation < ApplicationRecord
  belongs_to :customer_user
  belongs_to :room
end
