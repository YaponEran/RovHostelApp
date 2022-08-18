require "feature_helper"

feature "Destroy role" do
  let(:role) { create(:role) }
  let(:user) { create(:user, admin: true, role: role) }

  describe "With correct policy", js: true do
    background do
      create(:permission, subject: "employee/roles", action: "destroy", role: role)
      create(:permission, subject: "employee/roles", action: "show", role: role)
      create(:permission, subject: "employee/roles", action: "index", role: role)

      visit new_user_session_path
      sign_in_with(user.email, user.password)
      visit employee_role_path(role)
    end

    scenario "with correct params", js: true do
      click_on "Destroy"
      expect(page).to have_content("Destroy")
      save_and_open_page

      # при нажатие кнопку Destroy происходит Logout
      # так же не происходит удаление роли
      # save_and_open_page
    end

  end
end