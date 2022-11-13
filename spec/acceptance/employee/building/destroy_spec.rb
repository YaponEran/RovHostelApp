require "feature_helper"

feature "User create hotels building" do
  let!(:role) { create(:role) }
  let!(:user) { create(:user, role: role) }
  let!(:hotel) { create(:hotel, individual: user.individual) }
  let!(:building) { create(:building, hotel: hotel, individual: user.individual) }

  describe "With correct policy", js: true do
    background do
      create(:permission, subject: "employee/buildings", action: "destroy", role: role)
      create(:permission, subject: "employee/hotels", action: "show", role: role)
      create(:permission, subject: "employee/hotels", action: "index", role: role)

      visit new_user_session_path
      sign_in_with(user.email, user.password)
      visit employee_hotel_path(hotel)
    end

    scenario "With correct params" do
      accept_alert do
        click_on "Delete"
      end
      expect(page).to have_content("Hotel building successfuly deleted")
    end
  end
end