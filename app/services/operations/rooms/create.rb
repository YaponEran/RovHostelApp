module Operations
  module Rooms
    class Create
      include Dry::Monads[:result, :do]

      def call(building, params)
        validated_params = yield validate(params.to_h)
        building = yield check_building(building)
        individual = yield check_individual(building.individual)
        room = yield commit(validated_params.to_h.merge(building_id: building.id, individual_id: individual.id))

        Success(room)
      end

      private

      def validate(params)
        validation = Validations::Room::Room.new
        validation.call(params)
      end

      def check_building(building)
        building = Building.find_by(id: building.id)
        if building
          Success(building)
        else
          Failure[:building_not_found, {}]
        end
      end

      def check_individual(individual)
        individual = Individual.find_by(id: individual)
        individual ? Success(individual) : Failure[:individual_not_found, {}]
      end

      def commit(params)
        room = Room.create!(params)
        Success(room)
      rescue ActiveRecord::RecordNotUnique
        Failure[:uniqueness_violation, {}]
      end
    end
  end
end