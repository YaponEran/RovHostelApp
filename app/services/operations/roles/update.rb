module Operations
  module Roles
    class Update
      include Dry::Monads[:result, :do]

      def call(resource, params)
        validated_params = yield validate(params.to_h)
        resource = yield commit(resource, validated_params.to_h)
        Success(resource)
      end

      private
      def validate(params)
        validation = Validations::Role::Role.new
        validation.call(params)
      end

      def commit(resource, params)
        resource.update!(params)
        Success(resource)
      rescue ActiveRecord::RecordNotUnique
        Failure[:uniqueness_violation, {}]
      end
    end
  end
end