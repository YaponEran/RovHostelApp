module Employee
  class DashbordController < BaseController
    def index
      @welcome = "Hello Admin user"
    end
  end
end