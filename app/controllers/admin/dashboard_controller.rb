module Admin
  class DashboardController < BaseController
    def index
      @admin_page = "Admin page"
      @individuals = Individual.all
    end
  end
end