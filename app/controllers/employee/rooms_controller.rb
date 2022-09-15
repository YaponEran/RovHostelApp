module Employee
  class RoomsController < BaseController

    def index
    end

    def new
      @building = Building.find_by(id: params[:building_id])
      @room = Room.new
    end

    def create
      @building = Building.find_by(id: params[:building_id])
      @room = Room.new

      operations = Operations::Rooms::Create.new
      result = operations.call(@building, room_params)

      case result
      in Success
        flash[:success] = "Room successfuly created"
        # redirect_to employee_hotel_path(@building.hotel)
        redirect_to employee_building_path(@building)
      in Failure[error, payload]
        failure_resolver(error, **payload)
        @room = Room.new
        render :new
      end
    end

    def edit
      @room = Room.find_by(id: params[:id])
    end

    def update
      @room = Room.find_by(id: params[:id])

      operations = Operations::Rooms::Update.new
      result = operations.call(@room, room_params)

      case result
      in Success
        flash[:success] = "Room successfully updated"
        redirect_to employee_building_path(@room.building)
      in Failure[error, payload]
        failure_resolver(error, **payload)
        redirect_to employee_building_path(@room.building)
      end
    end

    def destroy
      @room = Room.find_by(id: params[:id])
      operations = Operations::Rooms::Destroy.new
      result = operations.call(@room)

      case result
      in Success
        flash[:success] = "Room successfuly deleted"
        redirect_to employee_building_path(@room.building)
      in Failure[error, payload]
        failure_resolver(error, **payload)
        redirect_to employee_building_path(@room.building)
      end
    end

    private

    def room_params
      params.require(:room).permit(:overnight_kind, :total_room, :total_bed, :has_air_con, :has_kitchen, :has_bath, :has_wifi, :price)
    end
    
  end
end