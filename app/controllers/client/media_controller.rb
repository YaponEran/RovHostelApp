module Client
  class MediaController < BaseController
    def index
      @media = "Customer page"
      @rooms = Room.all
      # @user = current_customer_user
      # @customer = @user.customer
      # @users = CustomerUser.default.with_customer(@customer)
    end
  end
end