module Client
  class BuildingsController < BaseController
    def show
      @building = Building.find_by(id: params[:id])
    end
  end
end