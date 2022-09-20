module Validations
  module Building
    class Building < Validations::Base
      params do
        required(:build_title).filled(:string)
        required(:build_postcode).filled(:string)
        required(:address).filled(:string)
        required(:phone_number).filled(:string)
      end
    end
  end
end