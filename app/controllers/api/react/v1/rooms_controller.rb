module Api
  module React
    module V1
      class RoomsController < BaseController
        respond_to :json

        def index
          @rooms = Room.all
          render json: @rooms
        end
      end
    end
  end
end