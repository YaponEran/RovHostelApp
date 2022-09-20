module Operations
  module Users
    class Update
      include Dry::Monads[:result, :do]

      def call(resource, params)
        validated_params = yield validate(params.to_h)
        yield check_role(validated_params[:role_id])
        resource =  yield commit(resource, validated_params.to_h)
        Success(resource)
      end

     def validate(params)
      validation = Validations::User::Update.new
      validation.call(params)
     end


      def check_role(role_id)
        role = Role.find_by(id: role_id)
        if role
          Success()
        else
          Failure[:role_not_found]
        end
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