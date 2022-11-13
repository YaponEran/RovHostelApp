require "feature_helper"

feature "User create hotels building" do
  let!(:role) { create(:role) }
  let!(:user) { create(:user, role: role) }

  let!(:hotel) { create(:hotel, individual: user.individual) }

  describe "With correct policy", js: true do
    background do
      create(:permission, subject: "employee/buildings", action: "new", role: role)
      create(:permission, subject: "employee/buildings", action: "create", role: role)
      create(:permission, subject: "employee/hotels", action: "show", role: role)
      create(:permission, subject: "employee/hotels", action: "index", role: role)

      visit new_user_session_path
      sign_in_with(user.email, user.password)
      visit new_employee_hotel_building_path(hotel)
    end

    scenario "With correct params" do
      fill_in "Building title", with: "Building 1"
      fill_in "Building postcode", with: "000100"
      fill_in "Building address", with: "City abc street rty room 90"
      fill_in "Building phone number", with: "+7(707)000-00-00"

      click_on "Submit"
      expect(page).to have_content "Hotel buulding successfuly created"
      expect(page).to have_content "Building 1"
    end

    scenario "With incorrect params" do
      fill_in "Building title", with: ""
      fill_in "Building postcode", with: "000100"
      fill_in "Building address", with: "City abc street rty room 90"
      fill_in "Building phone number", with: "+7(707)000-00-00"

      click_on "Submit"
      expect(page).to have_content "Check the form"
    end
  end
end