module Employee
  class UsersController < BaseController

    def new
      @user = User.new
    end

    def create
      operations = Operations::Users::Create.new
      result = operations.call(user_params)

      case result
      in Success
        flash[:notice] = t(".success")
        redirect_to employee_root_path
      in Failure[error, payload]
        # flash[:error] = "While create new account went wrong with: #{error} - #{payload}"
        failure_resolver(error, **payload)
        @user = User.new(user_params)
        
        redirect_to new_employee_user_path
      end
    end

    def show
      @user = User.find_by(id: params[:id])
    end

    private

    def user_params
      params.require(:user).permit(:first_name, :last_name, :mobile_phone, :email, :password, :role_id)
    end
  end
end