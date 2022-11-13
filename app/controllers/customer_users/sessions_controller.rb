module CustomerUsers
  class SessionsController < Devise::SessionsController
    def after_sign_in_path_for(resource)
      stored_location_for(resource) ||  client_root_path
    end

    def after_sign_out_path_for(_resource)
      new_customer_user_session_path
    end
  end
end