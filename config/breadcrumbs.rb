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

crumb :employee_user do |user|
  link user.email, employee_user_path(user)
  parent :employee
end


# crumb :projects do
#   link "Projects", projects_path
# end

# crumb :project do |project|
#   link project.name, project_path(project)
#   parent :projects
# end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).