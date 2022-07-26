class WelcomeController < ApplicationController
  # before_action :authenticate_user!

  def index
    @hello = "Welcome index page"
  end
end