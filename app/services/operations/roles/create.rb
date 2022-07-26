module Operations
  module Roles
    class Create
      include Dry::Monads[:result, :do]

      def call(params)
        validated_params = yield validate(params.to_h)
        role = yield commit(validated_params.to_h)

        Success(role)
      end

      private

      def validate(params)
        validation = Validations::Role::Role.new
        validation.call(params)
      end

      def commit(params)
        role = Role.create!(params)

        Success(role)
      rescue ActiveRecord::RecordNotUnique
        Failure[:uniqueness_violation, {}]
      end

    end
  end
end