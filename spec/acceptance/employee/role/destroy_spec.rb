require "feature_helper"

feature "Create Role" do
  let(:role) { create(:role) }
  let(:user) { create(:user, role: role) }

  let(:role_without_user) { create(:role) } 
  let!(:role_with_user) { create(:role) }
  let!(:user_with_role) { create( :user, role: role_with_user) } 

  describe "With correct policy", js: true do
    background do
      create(:permission, subject: "employee/roles", action: "destroy", role: role)
      create(:permission, subject: "employee/roles", action: "show", role: role)
      create(:permission, subject: "employee/roles", action: "index", role: role)
      visit new_user_session_path
      sign_in_with(user.email, user.password)
    end

    scenario "With correct params" do
      visit employee_role_path(role_without_user)
      accept_alert do
        click_on "Delete"
      end
      expect(page).to_not have_content(role_without_user.title)
      expect(page).to have_content("Role deleted successfully")
    end

    scenario "with bad params" do
      visit employee_role_path(role_with_user)
      accept_alert do
        click_on "Delete"
      end
      expect(page).to have_content("Role has dependent users")
    end

  end
end
