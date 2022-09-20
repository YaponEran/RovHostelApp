require "feature_helper"

feature "Create User" do
  let(:role) { create(:role) }
  let(:user) { create(:user, role: role)}
  
  describe "With correct policy", js: true do
    background do
      create(:permission, subject: "employee/users", action: "index", role: role)
      create(:permission, subject: "employee/users", action: "new", role: role)
      create(:permission, subject: "employee/users", action: "create", role: role)

      visit new_user_session_path
      sign_in_with(user.email, user.password)
    end

    scenario "with correct params" do
      visit new_employee_user_path
      
      fill_in "First name", with: "Bud"
      fill_in "Last name", with: "Jersy"
      fill_in "Email", with: "budjr@mail.ru"
      fill_in "Mobile phone", with: "+7(759)000-00-01"
      fill_in "Password", with: "123456"
      click_on "Submit"

      expect(page).to have_content "User was successfully created"
    end

    scenario "with bad params" do
      visit new_employee_user_path
      fill_in "First name", with: "Bud"
      click_on "Submit"

      expect(page).to have_content "Check the form"
    end
  end
end
