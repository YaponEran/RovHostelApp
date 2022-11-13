module Client
  class HotelsController < BaseController
    def show
      @hotel = Hotel.find_by(id: params[:id])
    end
  end
end