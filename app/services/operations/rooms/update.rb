module Operations
  module Rooms
    class Update
      include Dry::Monads[:result, :do]

      def call(resource, params)
        validated_params = yield validate(params.to_h)
        yield check_buildind(resource.building)
        yield check_individual(resource.building.individual)
        yield check_room(resource)
        resource = yield commit(resource, validated_params.to_h)

        Success(resource)
      end

      private
      def validate(params)
        validation = Validations::Room::Room.new
        validation.call(params)
      end

      def check_buildind(building)
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

      def check_room(room)
        room = Room.find_by(id: room.id)
        if room
          Success(room)
        else
          Failure[:room_not_found, {}]
        end
      end

      def commit(resource, params)
        resource.update!(params)
        Success()
      end

    end
  end
end