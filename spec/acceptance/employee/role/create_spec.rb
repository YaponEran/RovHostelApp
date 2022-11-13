require "feature_helper"

feature "Create Role" do
  let!(:individual) { create(:individual) }
  let!(:role) { create(:role, individual: individual) }
  let!(:user) { create(:user, role: role, individual: individual) }

  describe "With correct policy", js: true do
    background do
      create(:permission, subject: "employee/roles", action: "index", role: role)
      create(:permission, subject: "employee/roles", action: "new", role: role)
      create(:permission, subject: "employee/roles", action: "create", role: role)
      visit new_user_session_path
      sign_in_with(user.email, user.password)
      visit employee_roles_path
    end

    scenario "With correct params" do
      visit new_employee_role_path
      fill_in "Title", with: "Project manager"
      click_on "Submit"
      expect(page).to have_content("Project manager")
    end

    scenario "With bad params" do
      visit new_employee_role_path
      fill_in "Title", with: ""
      click_on "Submit"
      expect(page).to have_content("Check the form")
    end
  end
end
