module Operations
  module Roles
    class Create
      include Dry::Monads[:result, :do]

      def call(params, individual)
        validated_params = yield validate(params.to_h)
        individual = yield check_individual(individual.id)
        role = yield commit(validated_params.to_h, individual)
        Success(role)
      end

      private

      def validate(params)
        validation = Validations::Role::Role.new
        validation.call(params)
      end

      def check_individual(individual)
        individual = Individual.find_by(id: individual)
        individual ? Success(individual) : Failure[:individual_not_found, {}]
      end

      def commit(params, individual)
        role = Role.create!(params.to_h.merge(individual_id: individual.id))

        Success(role)
      rescue ActiveRecord::RecordNotUnique
        Failure[:uniqueness_violation, {}]
      end

    end
  end
end