module Employee
  class HotelsController < BaseController
    def index
      @hotels = Hotel.all
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

    def edit
      @hotel = Hotel.find_by(id: params[:id])
    end

    def update
      @hotel = Hotel.find_by(id: params[:id])
      
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
      @hotel = Hotel.find_by(id: params[:id])

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
    def hotel_params
      params.require(:hotel).permit(:title, :adress, :postcode, :phone_number)
    end
  end
end