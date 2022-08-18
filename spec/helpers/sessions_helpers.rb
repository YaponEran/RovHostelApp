module Features
  module SessionsHelpers
    def sign_in_with(email, password)
      fill_in "Email", with: email
      fill_in "Password", with: password
      click_button "Log in"
    end
  end
end