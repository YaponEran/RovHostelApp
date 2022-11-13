require "feature_helper"

feature "User create room" do
  let!(:role) { create(:role) }
  let!(:user) { create(:user, role: role) }

  let!(:hotel) { create(:hotel, individual: user.individual) }
  let!(:building) { create(:building, hotel: hotel, individual: user.individual) }
  let!(:room) { create(:room, building: building, individual: user.individual) }

  describe "With correct policy", js: true do
    background do
      create(:permission, subject: "employee/rooms", action: "destroy", role: role )
      create(:permission, subject: "employee/rooms", action: "index", role: role )
      create(:permission, subject: "employee/buildings", action: "show", role: role )

      visit new_user_session_path
      sign_in_with(user.email, user.password)
    end

    scenario "When all params are correct" do
      visit employee_building_path(building)
      accept_alert do
        click_on "Delete"
      end
      expect(page).to have_content("Room successfuly deleted")
    end
  end
end