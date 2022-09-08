require "feature_helper"

feature "User create hotels" do
  let!(:role) { create(:role) }
  let!(:user) { create(:user, role: role) }

  describe "With correct policy", js: true do
    background do
      create(:permission, subject: "employee/hotels", action: "index", role: role)
      create(:permission, subject: "employee/hotels", action: "new", role: role)
      create(:permission, subject: "employee/hotels", action: "create", role: role)

      visit new_user_session_path
      sign_in_with(user.email, user.password)
      visit new_employee_hotel_path
    end

    scenario "With correct params" do
      fill_in "Hotel title", with: "Almaty hotel"
      fill_in "Hotel address", with: "City Almaty street: bz room 1001"
      fill_in "Hotel postcode", with: "0005001"
      fill_in "Hotel phone number", with: "+7(707)000-00-01"

      click_on "Submit"

      expect(page).to have_content "Hotel created successfully"
    end

    scenario "Witn incorrect params" do
      fill_in "Hotel title", with: "Almaty hotel"
      fill_in "Hotel address", with: "City Almaty street: bz room 1001"
      click_on "Submit"

      expect(page).to have_content "Check the form"
    end
  end
end