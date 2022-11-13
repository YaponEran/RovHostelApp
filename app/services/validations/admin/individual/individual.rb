module Validations
  module Admin
    module Individual
      class Individual < Validations::Base
        params do
          required(:title).filled(:string)
          required(:judicial_adress).filled(:string)
          required(:postal_adress).filled(:string)
          required(:phone).filled(:string)
          required(:email).filled(:string)
        end

        rule(:email) do
          key(:email).failure("email not valid") unless value.include?("@")
        end
        
      end
    end
  end
end