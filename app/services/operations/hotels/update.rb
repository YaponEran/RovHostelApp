module Operations
  module Hotels
    class Update
      include Dry::Monads[:result, :do]

      def call(resource, params)
        validated_params = yield validate(params.to_h)
        yield check_hotel(resource)
        resource = yield commit(resource, validated_params.to_h)

        Success(resource)
      end

      private

      def validate(params)
        validation = Validations::Hotel::Hotel.new
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

      def commit(resource, params)
        resource.update!(params)
        Success(resource)
      end

    end
  end
end