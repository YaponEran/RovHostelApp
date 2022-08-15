require "feature_helper"

feature "Destroy role" do
  let!(:role) { create(:role) }
  let!(:user) { create(:user, role: role) }

  describe "With correct policy", js: true do
    background do
      create(:permission, subject: "employee/roles", action: "destroy", role: role)
      create(:permission, subject: "employee/roles", action: "show", role: role)
      create(:permission, subject: "employee/roles", action: "index", role: role)
      sign_in_with(user.email, user.password)
    end

    scenario "with correct params" do
      visit employee_role_path(role)
      # click_on "Destroy"
      save_and_open_page
      
      # within(".role_destroy") do
      #   click_on "Destroy"
      #   save_and_open_page
      # end
      # accept_alert do
        # click_on "Destroy"
      # end
    end

  end
end