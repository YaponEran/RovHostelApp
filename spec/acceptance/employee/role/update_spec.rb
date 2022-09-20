require "feature_helper"

feature "User update hotel" do
  let!(:role) { create(:role) }
  let!(:user) { create(:user, role: role) }

  describe "With correct params", js: true do
    background do
      create(:permission, subject: "employee/roles", action: "index", role: role)
      create(:permission, subject: "employee/roles", action: "show", role: role)
      create(:permission, subject: "employee/roles", action: "edit", role: role)
      create(:permission, subject: "employee/roles", action: "update", role: role)

      visit new_user_session_path
      sign_in_with(user.email, user.password)
      visit edit_employee_role_path(role)
    end

    scenario "with correct params" do
      fill_in "Title", with: "Role updated"
      click_on "Submit"
      expect(page).to have_content "Role successfully updated"
    end

    scenario "with incorrect param" do
      fill_in "Title", with: ""
      click_on "Submit"
      expect(page).to have_content "Check the form"
    end
  end
end