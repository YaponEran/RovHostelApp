module Validations
  module Client
    module Reservation
      class Reservation < Validations::Base
        params do
          required(:customer_user_id).filled(:integer)
          required(:room_id).filled(:integer)
          required(:start_at).filled(:date_time)
          required(:end_at).filled(:date_time)
        end
      end
    end
  end 
end