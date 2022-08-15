shared_examples_for "Authenticable with bad credentials" do
  it "with bad credentials" do
    visit new_user_session_path
    fill_in "Email", with: "test.ru"
    fill_in "Password", with: "123456"
    click_on "Log in"
    expect(page).to have_content("Invalid email or password")
  end
end

shared_examples_for "Authenticable without policy" do
  it "with correct credentials without policy" do
    visit new_user_session_path
    sign_in_with(user.email, user.password)
    visit new_office_branch_path
    expect(page).to have_content("You are not authorized for this action")
  end
end
