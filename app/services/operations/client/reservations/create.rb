module Operations
  module Client
    module Reservations
      class Create
        include Dry::Monads[:result, :do]

        def call(params)
          validated_params = yield validate(params)

          puts "!!!!!!!!!!!!"
          puts validated_params.inspect
          puts "!!!!!!!!!!!!"
        end

        private

        def validate(params)
          validations = Validations::Client::Reservation::Reservation.new
          validations.call(params)
        end

      end
    end
  end
end