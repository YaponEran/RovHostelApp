module Validations
  module Role
    class Role < Validations::Base
      params do 
        required(:title).filled(:string)
        required(:role_rank).filled(:integer)
      end
    end
  end
end