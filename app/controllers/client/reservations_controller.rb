module Client
  class ReservationsController < BaseController
    def destroy
      @reservation = Reservation.find_by(id: params[:id])

      operations = Operations::Client::Reservations::Destroy.new
      result = operations.call(@reservation)

      case result
      in Success
        flash[:success] = "Reservation successfullu canceled"
        redirect_to client_customer_user_path(current_customer_user)
      in Failure[error, payload]
        flash[:error] = "#{error} - #{payload}"
        redirect_to client_customer_user_path(current_customer_user)
      end
    end
  end
end