module Operations
  module Admin
    module Users
      class Create
        include Dry::Monads[:result, :do]

        def call(resource, params)
          validated_params = yield validate(params.to_h)
          yield check_admin_value(validated_params)
          individual = yield check_individual(resource)
          user = yield commit(validated_params.to_h, individual)

          Success(user)
        end

        private
        def validate(params)
          validation = Validations::Admin::User::User.new
          validation.call(params)
        end

        def check_individual(individual)
          individual = Individual.find_by(id: individual.id)
          individual ? Success(individual) : Failure[:individual_not_found, {}]
        end

        def check_admin_value(params)
          admin = params[:admin]
          admin ? Success() : Failure[:user_should_be_client_admin, {}]
        end

        def commit(params, individual)
          ActiveRecord::Base.transaction do
            individual = Individual.find_by(id: individual.id)

            operations = Operations::Roles::Create.new
            result = operations.call({title: "Администратор", role_rank: 1}, individual)
            
            role = result.value!

            user = User.create!(params.to_h.merge(role_id: role.id, individual_id: individual.id))
            
            # user = Operations::Users::Create.new.call({
            #   first_name: params[:first_name],
            #   last_name: params[:last_name],
            #   mobile_phone: params[:mobile_phone],
            #   password: params[:password],
            #   email: params[:email],
            #   admin: params[:admin],
            #   role_id: role.id,
            # }, individual)
            
            Success(user)
          rescue ActiveRecord::RecordNotSaved
            Failure[:user_not_saved, {}]
          end
        end
      end
    end
  end
end