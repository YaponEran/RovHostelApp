class ApplicationController < ActionController::Base
  include Dry::Monads::Result::Mixin
  
  # before_action :configure_permitted_parameters, if: :devise_controller?
  # before_action :authenticate_user!

  # private
  # def configure_permitted_parameters
  #   devise_parameter_sanitizer.permit(:sign_up, keys:[:first_name, :last_name, :mobile_phone, :email, :password])
  # end

  def self.renderer_with_user(user)
    ActionController::Renderer::RACK_KEY_TRANSLATION["warden"] ||= "warden"
    proxy = Warden::Proxy.new({}, Warden::Manager.new({})).tap do |i|
      i.set_user(user, scope: :user, store: false, run_callbacks: false)
    end
    renderer.new("warden" => proxy)
  end

  def after_sign_in_path_for(_resource)
    employee_root_path
  end

  def after_sign_out_path_for(_resource)
    new_user_session_path
  end
end
