module Operations
  module Rooms
    class Create
      include Dry::Monads[:result, :do]

      def call(building, params)
       validated_params = yield validate(params.to_h)
       building = yield check_building(building)
       room = yield commit(validated_params.to_h.merge(building_id: building.id))

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

      def commit(params)
        room = Room.create!(params)
        Success(room)
      rescue ActiveRecord::RecordNotUnique
        Failure[:uniqueness_violation, {}]
      end
    end
  end
end