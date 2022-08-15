module Employee
  class BaseController < ApplicationController
    include Dry::Monads::Result::Mixin

    layout "employee"
    before_action :authenticate_user!
    before_action :authorize_action!
    
    def failure_resolver(failure_code, **payload)
      @errors = payload if failure_code == :validation_error
      exceptions_path = "employee.failures"
      flash[:error] = t("#{exceptions_path}.#{failure_code}", **payload)
    end

    protected
    def authorize_action!
      raise AccessDenied unless can?(params[:controller], params[:action])
    rescue AccessDenied
      respond_to do |format|
        format.html do
          redirect_to(
            employee_root_path,
            flash: { error: I18n.t(:access_denied, scope: %i[employee exceptions]) }
          )
        end
        format.json { render json: { error: :access_denied } }
      end 
    end

    def can?(subject, action)
      current_user.can?(subject, action)
    end
  end

  class AccessDenied < StandardError; end
end