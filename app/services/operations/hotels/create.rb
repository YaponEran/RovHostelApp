module Operations
  module Hotels
    class Create
      include Dry::Monads[:result, :do]

      def call(user, params)
        validated_params = yield validate(params.to_h)
        user = yield check_user(user)
        hotel = yield commit(validated_params.to_h.merge(user_id: user.id))
        Success(hotel)
      end

      private

      def validate(params)
        validation = Validations::Hotel::Hotel.new
        validation.call(params)
      end

      def check_user(user)
        user = User.find_by(id: user.id)

        if user
          Success(user)
        else
          Failure[:user_not_found, {}]
        end
      end

      def commit(params)
        hotel = Hotel.create(params)
        Success(hotel)
      end
    end
  end
end