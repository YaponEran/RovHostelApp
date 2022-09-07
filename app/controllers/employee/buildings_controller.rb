module Employee
  class BuildingsController < BaseController
    def index
      @buildings = Building.all
    end

    def new
      @hotel = Hotel.find_by(id: params[:hotel_id])
      @building = Building.new
    end

    def create
      @hotel = Hotel.find_by(id: params[:hotel_id])
      
      operations = Operations::Buildings::Create.new
      result = operations.call(@hotel, building_params)

      case result 
      in Success
        flash[:success] = "Hotel buulding successfuly created"
        redirect_to employee_hotel_path(@hotel)
      in Failure[error, payload]
        failure_resolver(error, **payload)
        @building = Building.new
        render :new
      end
    end

    private

    def building_params
      params.require(:building).permit(:build_title, :build_postcode, :address, :phone_number)
    end
  end
end