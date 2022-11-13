module Admin
  class IndividualsController < BaseController
    def new
      @individual = Individual.new
    end

    def show
      @individual = Individual.find_by(id: params[:id])
      @rooms = @individual.rooms
      @buildings = @individual.buildings
      @hotels = @individual.hotels
      @users = @individual.users
    end

    def new_individual_user
      @individual = Individual.find_by(id: params[:id])
      @user = User.new
    end

    def create_individual_user
      @individual = Individual.find_by(id: params[:id])

      operation = Operations::Admin::Users::Create.new
      result = operation.call(@individual, user_params)

      case result
      in Success
        flash[:success] = "Individual user successfully created"
        redirect_to admin_root_path
      in Failure[error, payload]
        flash[:error] = "While create Individual went: #{error} - #{payload}"
        @user = User.new
        render :new_individual_user
      end
    end

    def create
      operation = Operations::Admin::Individuals::Create.new
      result = operation.call(individual_params)

      case result
      in Success
        flash[:success] = "Individual successfuly created"
        redirect_to admin_root_path
      in Failure[error, payload]
        flash[:error] = "While create Individual went: #{error} - #{payload}"
        @individual = Individual.new
        render :new
      end
    end

    def edit
      @individual = Individual.find_by(id: params[:id])
    end

    def update
      @individual = Individual.find_by(id: params[:id])

      operation = Operations::Admin::Individuals::Update.new
      result = operation.call(@individual, individual_params)

      case result
      in Success
        flash[:success] = "Individual successfully updated"
        redirect_to admin_root_path
      in Failure[error, payload]
        flash[:error] = "While update Individual went: #{error} - #{payload}"
        redirect_to admin_root_path
      end
    end

    private

    def individual_params
      params.require(:individual).permit(:title, :judicial_adress, :postal_adress, :email, :phone)
    end

    def user_params
      params.require(:user).permit(:first_name, :last_name, :mobile_phone, :email, :password, :role_id, :admin)
    end
  end
end