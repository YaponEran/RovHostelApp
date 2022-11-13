module Operations
  module Users
    class Create
      include Dry::Monads[:result, :do]

      def call(params, individual)
        validated_params = yield validate(params.to_h)
        individual = yield check_individual(individual.id)

        user = yield commit(validated_params.to_h, individual)
        Success(user)
      end

      private

      def validate(params)
        validation = Validations::User::User.new
        validation.call(params)
      end

      def check_individual(individual)
        individual = Individual.find_by(id: individual)
        individual ? Success(individual) : Failure[:individual_not_found, {}]
      end

      def commit(params, individual)
        user = User.create!(params.to_h.merge(individual_id: individual.id))
        Success(user)
      rescue ActiveRecord::RecordNotUnique
        Failure[:uniqueness_violation, {}]
      end
    end
  end
end