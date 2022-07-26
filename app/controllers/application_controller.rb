class ApplicationController < ActionController::Base
  include Dry::Monads::Result::Mixin
  
  # before_action :configure_permitted_parameters, if: :devise_controller?
  # before_action :authenticate_user!

  # private
  # def configure_permitted_parameters
  #   devise_parameter_sanitizer.permit(:sign_up, keys:[:first_name, :last_name, :mobile_phone, :email, :password])
  # end
end
