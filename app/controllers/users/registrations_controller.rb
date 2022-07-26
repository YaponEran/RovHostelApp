module Users
  class RegistrationsController < Devise::RegistrationsController

    layout "employee"

    def after_update_path_for(_resource)
      employee_root_path
    end
  end
end