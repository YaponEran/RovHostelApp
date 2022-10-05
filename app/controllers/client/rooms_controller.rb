module Client
  class RoomsController < BaseController

    def show
      @room = Room.find_by(id: params[:id])
    end

  end
end