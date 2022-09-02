module Operations
  module Roles
    class Destroy
      include Dry::Monads[:result, :do]

      def call(role)
        role = yield check_role(role)
        yield check_users(role)
        yield commit(role)

        Success()
      end

      private
      def check_role(role)
        role = Role.find_by(id: role.id)
        Success(role)
      rescue ActiveRecord::RecordNotUnique
        Failure[:role_does_not_found, {}]
      end

      def check_users(role)
        if role.users.empty?
          Success()
        else
          Failure[:role_has_dependent_users, {}]
        end
      end

      def commit(role)
        role.destroy
        Success()
      end
    end
  end
end