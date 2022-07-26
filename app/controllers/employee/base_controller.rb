module Employee
  class BaseController < ApplicationController
    include Dry::Monads::Result::Mixin

    layout "employee"
    before_action :authenticate_user!
    
    def failure_resolver(failure_code, **payload)
      @errors = payload if failure_code == :validation_error
      exceptions_path = "employee.failures"
      flash[:error] = t("#{exceptions_path}.#{failure_code}", **payload)
    end
  end
end