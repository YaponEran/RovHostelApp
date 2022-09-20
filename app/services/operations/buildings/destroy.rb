module Operations
  module Buildings
    class Destroy
      include Dry::Monads[:result, :do]

      def call(building)
        yield check_hotel(building.hotel)
        yield check_buildind(building)
        yield commit(building)

        Success()
      end

      private

      def check_hotel(hotel)
        hotel = Hotel.find_by(id: hotel.id)
        if hotel
          Success(hotel)
        else
          Failure[:hotel_not_found, {}]
        end
      end

      def check_buildind(building)
        building = Building.find_by(id: building.id)
        if building
          Success(building)
        else
          Failure[:building_not_found, {}]
        end
      end

      def commit(building)
        building.destroy!
        Success()
      end
    end
  end
end