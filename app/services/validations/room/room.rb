module Validations
  module Room
    class Room < Validations::Base
      params do
        required(:overnight_kind).filled(:string)
        required(:total_room).filled(:integer)
        required(:total_bed).filled(:integer)
        required(:bed_number).filled(:integer)
        required(:has_air_con).filled(:bool)
        required(:has_kitchen).filled(:bool)
        required(:has_bath).filled(:bool)
        required(:has_wifi).filled(:bool)
        required(:price).filled(:decimal)
      end
    end
  end
end