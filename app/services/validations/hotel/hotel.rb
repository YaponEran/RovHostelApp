module Validations
  module Hotel
    class Hotel < Validations::Base
      params do
        required(:title).filled(:string)
        required(:adress).filled(:string)
        required(:postcode).filled(:string)
        required(:phone_number).filled(:string)
      end
    end
  end 
end