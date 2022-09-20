module Operations
  module Buildings
    class Update
      include Dry::Monads[:result, :do]

      def call(resource, params)
        validated_params = yield validate(params.to_h)
        yield check_hotel(resource.hotel)
        yield check_buildind(resource)

        resource = yield commit(resource, validated_params.to_h)

        Success(resource)
      end

      private

      def validate(params)
        validation = Validations::Building::Building.new
        validation.call(params)
      end

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

      def commit(resource, params)
        resource.update!(params)
        Success()
      end

    end
  end
end