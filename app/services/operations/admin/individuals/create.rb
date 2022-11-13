module Operations
  module Admin
    module Individuals
      class Create
        include Dry::Monads[:result, :do]

        def call(params)
          validated_params = yield validate(params.to_h)
          personal_uuid = yield generate_personal_uuid
          auth_token = yield generate_auth_token

          individual = yield commit(validated_params.to_h.merge(personal_uuid: personal_uuid, auth_token: auth_token))

          Success(individual)
        end

        private

        def validate(params)
          validation = Validations::Admin::Individual::Individual.new
          validation.call(params)
        end

        def generate_personal_uuid
          personal_uuid = SecureRandom.uuid

          if personal_uuid
            Success(personal_uuid)
          else
            Failure[:code_genarator_failure, {}]
          end
        end

        def generate_auth_token
          auth_token = SecureRandom.hex(13)

          if auth_token
            Success(auth_token)
          else
            Failure[:code_genarator_error, {}]
          end
        end

        def commit(params)
          individual = Individual.create!(params)
          Success(individual)

        rescue ActiveRecord::RecordNotUnique
          Failure[:uniqueness_violation]
        end
      end
    end
  end
end