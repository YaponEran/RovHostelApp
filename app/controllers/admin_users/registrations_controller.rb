module AdminUsers
  class RegistrationsController < Devise::RegistrationsController

    layout "admin"

    def after_update_path_for(_resource)
      admin_root_path
    end
  end
end