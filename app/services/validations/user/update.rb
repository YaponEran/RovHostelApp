module Validations
    module User
      class Update < Validations::Base
        params do 
          required(:first_name).filled(:string)
          required(:last_name).filled(:string)
          required(:mobile_phone).filled(:string)
          required(:email).filled(:string)
          required(:role_id).filled(:integer)
        end
  
        rule(:email) do
          key(:email).failure("email not valid") unless value.include?("@")
        end
      end
    end
  end