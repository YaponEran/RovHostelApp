module Operations
  module Buildings
    class Create
      include Dry::Monads[:result, :do]

      def call(hotel, params)
        validated_params = yield validate(params.to_h)
        hotel = yield check_hotel(hotel)
        individual = yield check_individual(hotel.individual)
        building = yield commit(validated_params.to_h.merge(hotel_id: hotel.id, individual_id: individual.id))
        Success(building)
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

      def check_individual(individual)
        individual = Individual.find_by(id: individual)
        individual ? Success(individual) : Failure[:individual_not_found, {}]
      end

      def commit(params)
        building = Building.create!(params)
        Success(building)
      rescue ActiveRecord::RecordNotUnique
        Failure[:uniqueness_violation, {}]
      end
    end
  end
end