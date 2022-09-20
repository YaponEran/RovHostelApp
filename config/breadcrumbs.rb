PATH = "breadcrumbs".freeze

crumb :employee do
  link I18n.t("#{PATH}.employee"), employee_root_path
end

crumb :employee_dashbord do
  link I18n.t("#{PATH}.employee")
  parent :employee
end


# ROLES
crumb :employee_roles do
  link I18n.t("#{PATH}.roles"), employee_roles_path
  parent :employee
end

crumb :employee_role do |role|
  link role.title, employee_role_path(role)
  parent :employee_roles
end

crumb :employee_new_role do
  link I18n.t("#{PATH}.new_roles"), new_employee_role_path
  parent :employee_roles
end

# Users
crumb :employee_users do |user|
  link I18n.t("#{PATH}.employee_users"), employee_users_path
  parent :employee
end

crumb :employee_user do |user|
  link user.email, employee_user_path(user)
  parent :employee_users
end

# Hotels
crumb :employee_hotels do
  link I18n.t("#{PATH}.hotels"), employee_hotels_path
  parent :employee
end

crumb :employee_hotel do |hotel|
  link hotel.title, employee_hotels_path
  parent :employee_hotels
end

# Buildings

crumb :employee_building do |hotel, buiding|
  link buiding.build_title
  parent :employee_hotel, hotel
end
