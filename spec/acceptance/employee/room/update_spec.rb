require "feature_helper"

feature "User create room" do
  let!(:role) { create(:role) }
  let!(:user) { create(:user, role: role) }
  let!(:hotel) { create(:hotel)}
  let!(:building) { create(:building, hotel: hotel) }
  let!(:room) { create(:room, building: building) }

  describe "With correct policy", js: true do
    background do
      create(:permission, subject: "employee/rooms", action: "edit", role: role )
      create(:permission, subject: "employee/rooms", action: "update", role: role )
      create(:permission, subject: "employee/buildings", action: "show", role: role )

      visit new_user_session_path
      sign_in_with(user.email, user.password)
    end

    scenario "When all params are correct" do
      visit edit_employee_room_path(room)

      select "Bed", :from => "Overnight kind"
      fill_in "Total room", with: 1
      fill_in "Total bed", with: 1
      page.check('Air conditioner')
      page.check('Kitchen')
      page.check('Bath room')
      page.check('Wifi router')
      fill_in "Price", with: 200.00
      
      click_on "Submit"
      expect(page).to have_content("Room successfully updated")
    end
  end
end