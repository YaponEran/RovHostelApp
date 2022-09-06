module Operations
  module Hotels
    class Destroy
      include Dry::Monads[:result, :do]
      
      def call(hotel)
        yield check_hotel(hotel)
        yield delete(hotel)
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

      def delete(hotel)
        hotel.destroy!
        Success()
      end

    end
  end
end