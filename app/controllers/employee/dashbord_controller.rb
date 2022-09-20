module Employee
  class DashbordController < BaseController
    skip_before_action :authorize_action!, only: [:index]
    
    def index
      @welcome = "Hello Admin user"
    end
  end
end