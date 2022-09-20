module Operations
  module Rooms
    class Destroy
      include Dry::Monads[:result, :do]

      def call(room)
        room = yield cehck_room(room)
        yield commit(room)
        
        Success()
      end

      private
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