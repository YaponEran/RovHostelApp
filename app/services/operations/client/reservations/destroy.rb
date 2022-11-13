module Operations
  module Client
    module Reservations
      class Destroy
        include Dry::Monads[:result, :do]

        def call(reservation)
          yield commit(reservation)
          Success()
        end

        private
        def commit(reservation)
          reservation.destroy!
          Success()
        end
      end
    end
  end
end