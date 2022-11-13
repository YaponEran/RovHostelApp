module Operations
  module Rooms
    class Destroy
      include Dry::Monads[:result, :do]

      def call(room)
        room = yield cehck_room(room)
        yield check_individual(room.individual)

        yield commit(room)
        
        Success()
      end

      private

      def check_individual(individual)
        individual = Individual.find_by(id: individual)
        individual ? Success(individual) : Failure[:individual_not_found, {}]
      end

      def cehck_room(room)
        room = Room.find_by(id: room.id)
        if room
          Success(room)
        else
          Failure[:room_not_found, {}]
        end
      end

      def commit(room)
        room.destroy
        Success()
      end
    end
  end
end