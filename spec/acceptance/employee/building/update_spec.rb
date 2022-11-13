require "feature_helper"

feature "User update building" do
  let!(:role) { create(:role) }
  let!(:user) { create(:user, role: role) }
  let!(:hotel) { create(:hotel, individual: user.individual) }
  let!(:building) { create(:building, hotel: hotel, individual: user.individual) }

  describe "with correct policy", js: true do
    background do
      create(:permission, subject: "employee/buildings", action: "edit", role: role)
      create(:permission, subject: "employee/buildings", action: "update", role: role)
      create(:permission, subject: "employee/hotels", action: "show", role: role)

      visit new_user_session_path
      sign_in_with(user.email, user.password)
      visit employee_hotel_path(hotel)
    end

    scenario "With correct params" do
      find(".building_edit_button").trigger("click")
      fill_in "Building title", with: "Updated Building 2"
      fill_in "Building postcode", with: "210100"
      fill_in "Building address", with: "updated City abc street rty room 90"
      fill_in "Building phone number", with: "+7(707)000-00-01"
      click_on "Submit"

      expect(page).to have_content "Hotel buulding successfuly updated"
      expect(page).to have_content("Updated Building 2")
    end

    scenario "With incorrect params" do
      find(".building_edit_button").trigger("click")
      fill_in "Building title", with: ""
      click_on "Submit"

      expect(page).to have_content "Check the form"
    end
  end
end