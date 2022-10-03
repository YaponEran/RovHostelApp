module CustomerUsers
  class RegistrationsController < Devise::RegistrationsController

    layout "client"

    def after_update_path_for(_resource)
      client_root_path
    end
  end
end