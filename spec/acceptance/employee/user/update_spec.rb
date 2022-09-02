require "feature_helper"

feature "Update User" do
  let!(:role) { create(:role) }
  let!(:user) { create(:user, role: role) }

  let!(:role2) { create(:role) }
  let!(:user2) { create(:user, role: role2) }
  describe "With correct policy", js: true do
    background do
      create(:permission, subject: "employee/users", action: "index", role: role)
      create(:permission, subject: "employee/users", action: "edit", role: role)
      create(:permission, subject: "employee/users", action: "update", role: role)

      visit new_user_session_path
      sign_in_with(user.email, user.password)
    end

    scenario "whith correct params" do
      visit edit_employee_user_path(user2)

      fill_in "First name", with: "Nike"
      fill_in "Last name", with: "Eazy"
      fill_in "Email", with: "nike@mail.ru"
      fill_in "Mobile phone", with: "+7(759)000-00-03"
      click_on "Submit"

      expect(page).to have_content "User was successfully updated"
    end

    scenario "With bad params" do
      visit edit_employee_user_path(user2)

      fill_in "First name", with: ""
      click_on "Submit"

      expect(page).to have_content "Check the form"
    end
  end
end