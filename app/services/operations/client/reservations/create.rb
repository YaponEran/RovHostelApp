module Operations
  module Client
    module Reservations
      class Create
        include Dry::Monads[:result, :do]

        def call(params)
          validated_params = yield validate(params.to_h)
          yield check_customer_user(validated_params[:customer_user_id])
          yield check_room(validated_params[:room_id])

          reservation = commit(validated_params.to_h)

          Success(reservation)
        end

        private

        def validate(params)
          validations = Validations::Client::Reservation::Reservation.new
          validations.call(params)
        end

        def check_customer_user(customer_user)
          customer_user = CustomerUser.find_by(id: customer_user)

          if customer_user
            Success(customer_user)
          else
            Failure[:customer_user_not_found, {}]
          end
        end

        def check_individual(individual)
          # individual = Individual:
        end

        def check_room(room)
          room = Room.find_by(id: room)

          if room
            Success(room)
          else
            Failure[:room_not_found, {}]
          end
        end

        def commit(params)
          reservation = Reservation.create!(params)

          if reservation
            Success(reservation)
          else
            Failure[:while_create_reserve_error, {}]
          end
        end

      end
    end
  end
end