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

      def make_unique_role(params, individual)
        params[:title].include?(individual.title) ? params[:title] : "#{individual.title} - #{params[:title]}"
      end

      def cehck_unique_role_title(params, individual)
        unique_role_title = params[:title]
        unique_role_title == "#{individual.title} - #{unique_role_title}" ? Success(unique_role_title) : Failure[:role_title_should_be_with_individual_title]
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