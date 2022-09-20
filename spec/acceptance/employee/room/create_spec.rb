require "feature_helper"

feature "User create room" do
  let!(:role) { create(:role) }
  let!(:user) { create(:user, role: role) }
  let!(:building) { create(:building) }
  describe "With correct policy", js: true do
    background do
      create(:permission, subject: "employee/rooms", action: "new", role: role )
      create(:permission, subject: "employee/rooms", action: "create", role: role )
      create(:permission, subject: "employee/buildings", action: "show", role: role )

      visit new_user_session_path
      sign_in_with(user.email, user.password)
      visit new_employee_building_room_path(building)
    end

    scenario "When all params are correct" do
      select "Room", :from => "Overnight kind"
      fill_in "Total room", with: 1
      fill_in "Total bed", with: 2
      page.check('Air conditioner')
      page.check('Kitchen')
      page.check('Bath room')
      page.check('Wifi router')
      fill_in "Price", with: 100.00
      
      click_on "Submit"

      # save_and_open_page

      expect(page).to have_content("Room successfuly created")
    end
  end
end