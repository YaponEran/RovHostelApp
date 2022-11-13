module Client
  class RoomsController < BaseController

    def index
      @rooms = Room.all
    end

    def show
      @room = Room.find_by(id: params[:id])
      @reservation = Reservation.new
    end

    def customer_room_reservation
      @room = Room.find_by(id: params[:id])
      operations = Operations::Client::Reservations::Create.new
      
      result = operations.call(reservation_params)

      case result
      in Success
        redirect_to client_customer_user_path(current_customer_user)
        flash[:success] = "Reserve successfully created"
      in Failure[error, payload]
        redirect_to client_room_path(@room)
        flash[:error] = payload
      end
    end

    private

    def reservation_params
      params.require(:reservation).permit(:start_at, :end_at, :customer_user_id, :room_id)
    end

  end
end