require "feature_helper"

feature "User destroy hotel" do
  let!(:role) { create(:role) }
  let!(:user) { create(:user, role: role) }
  let!(:hotel) { create(:hotel) }

  describe "With correct params", js: true do
    background do
      create(:permission, subject: "employee/hotels", action: "index", role: role)
      create(:permission, subject: "employee/hotels", action: "destroy", role: role)

      visit new_user_session_path
      sign_in_with(user.email, user.password)
      visit employee_hotels_path
    end

    scenario "With correct params" do
      accept_alert do
        click_on "Delete"
      end
      expect(page).to have_content "Hotel successfully deleted"
    end
  end
end