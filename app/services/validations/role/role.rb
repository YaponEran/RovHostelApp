module Validations
  module Role
    class Role < Validations::Base
      params do 
        required(:title).filled(:string)
      end
    end
  end
end