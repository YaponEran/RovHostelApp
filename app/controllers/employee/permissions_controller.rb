module Employee
  class PermissionsController < BaseController
    def create
      @role = Role.find_by(id: params[:role_id])
      @permission = @role.permissions.new(permission_params)
      @permission.save
      redirect_to employee_role_path(@role)
    end

    def destroy
      @role = Role.find_by(id: params[:role_id])
      @permission = @role.permissions.find(params[:id])
      @permission.destroy
      redirect_to employee_role_path(@role)
    end

    def permission_params
      params.require(:permission).permit!
    end
  end
end