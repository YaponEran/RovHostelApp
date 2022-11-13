module Operations
  module Admin
    module Individuals
      class Update
        include Dry::Monads[:result, :do]

        def call(resources, params)
          validated_params = yield validate(params.to_h)
          resources = yield commit(resources, validated_params.to_h)

          Success(resources)
        end

        private
        
        def validate(params)
          validation = Validations::Admin::Individual::Individual.new
          validation.call(params)
        end

        def commit(resources, params)
          resources.update!(params.to_h)

          Success(resources)
        rescue ActiveRecord::RecordNotUnique
          Failure[:uniqueness_violation, {}]
        end

      end
    end
  end
end