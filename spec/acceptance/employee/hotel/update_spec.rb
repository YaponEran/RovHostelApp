require "feature_helper"

feature "User update hotel" do
  let!(:role) { create(:role) }
  let!(:user) { create(:user, role: role) }
  let!(:hotel) { create(:hotel) }

  describe "With correct params", js: true do
    background do
      create(:permission, subject: "employee/hotels", action: "index", role: role)
      create(:permission, subject: "employee/hotels", action: "edit", role: role)
      create(:permission, subject: "employee/hotels", action: "update", role: role)

      visit new_user_session_path
      sign_in_with(user.email, user.password)
      visit edit_employee_hotel_path(hotel)
    end

    scenario "with correct params" do
      fill_in "Title", with: "Almaty hotel 2"
      fill_in "Adress", with: "City Almaty street: bz room 2002"
      fill_in "Postcode", with: "0005003"
      fill_in "Phone number", with: "+7(707)000-00-01"

      click_on "Submit"
      expect(page).to have_content "Hotel successfully updated"
    end

    scenario "with incorrect param" do
      fill_in "Title", with: ""
      fill_in "Adress", with: "City Almaty street: bz room 2002"
      click_on "Submit"
      expect(page).to have_content "Check the form"
    end
  end
end