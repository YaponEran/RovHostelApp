module Employee
  class RolesController < BaseController

    def index
      @roles = Role.all
    end

    def new
      @role = Role.new
    end

    def create
      operations = Operations::Roles::Create.new
      result = operations.call(role_params.to_h)

      case result
      in Success
        flash[:success] = t(".success")
        redirect_to employee_roles_path
      in Failure[error, payload]
        # flash[:error] = "While create role went wrong with: #{error} - #{payload}"
        failure_resolver(error, **payload)
        @role = Role.new(role_params)
        render :new
      end
    end

    def show
      @role = Role.find_by(id: params[:id])
    end

    private
    def role_params
      params.require(:role).permit(:title)
    end
  end
end