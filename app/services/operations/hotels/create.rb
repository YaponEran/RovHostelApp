module Operations
  module Hotels
    class Create
      include Dry::Monads[:result, :do]

      def call(user, params)
        validated_params = yield validate(params.to_h)
        user = yield check_user(user)
        individual = yield check_individual(user.individual)
        hotel = yield commit(validated_params.to_h.merge(user_id: user.id, individual_id: individual.id))
        Success(hotel)
      end

      private

      def validate(params)
        validation = Validations::Hotel::Hotel.new
        validation.call(params)
      end

      def check_user(user)
        user = User.find_by(id: user.id)

        if user
          Success(user)
        else
          Failure[:user_not_found, {}]
        end
      end

      def check_individual(individual)
        individual = Individual.find_by(id: individual.id)
        individual ? Success(individual) : Failure[:individual_not_found, {}]
      end

      def commit(params)
        hotel = Hotel.create!(params)
        Success(hotel)
      end
    end
  end
end