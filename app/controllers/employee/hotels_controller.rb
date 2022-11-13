module Employee
  class HotelsController < BaseController
    before_action :find_individual

    def index
      @hotels = Hotel.with_individual(@individual).all
    end

    def new
      @hotel = Hotel.new
    end

    def create
      operations = Operations::Hotels::Create.new
      result = operations.call(current_user, hotel_params)

      case result
      in Success
        flash[:success] = t(".success")
        redirect_to employee_hotels_path
      in Failure[error, payload]
        failure_resolver(error, **payload)
        @hotel = Hotel.new
        render :new
      end
    end

    def show
      @hotel = Hotel.with_individual(@individual).find_by(id: params[:id])
    end

    def edit
      @hotel = Hotel.with_individual(@individual).find_by(id: params[:id])
    end

    def update
      @hotel = Hotel.with_individual(@individual).find_by(id: params[:id])
      
      operations = Operations::Hotels::Update.new
      result = operations.call(@hotel, hotel_params)

      case result
      in Success
        flash[:success] = t(".success")
        redirect_to employee_hotels_path
      in Failure[error, payload]
        failure_resolver(error, **payload)
        render :edit
      end
    end

    def destroy
      @hotel = Hotel.with_individual(@individual).find_by(id: params[:id])

      operations = Operations::Hotels::Destroy.new
      result = operations.call(@hotel)

      case result
      in Success
        flash[:success] = t(".success")
        redirect_to employee_hotels_path
      in Failure[error, payload]
        failure_resolver(error, **payload)
        redirect_to employee_hotels_path
      end
    end

    private
    def find_individual
      @individual = current_user.individual
    end

    def hotel_params
      params.require(:hotel).permit(:title, :adress, :postcode, :phone_number)
    end
  end
end