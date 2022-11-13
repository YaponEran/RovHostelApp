module Client
  class MediaController < BaseController
    def index
      @media = "Hotels for clients"
      @hotels = Hotel.all
    end

    def show
      @room = Room.find_by(id: params[:id])
    end
  end
end