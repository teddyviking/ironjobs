require 'rails_helper'


feature 'Admin dashboard' do
  background do
  	@admin = create(:admin)
  end

  scenario 'user logs in as an admin' do
    visit new_user_session_path

    fill_in("user_email", :with => @admin.email)
    fill_in("user_password", :with => @admin.password)
    click_on("Log in")

    expect(current_path).to eq(root_path)
    expect(page).to have_content("Welcome " + @admin.first_name)
    expect(page).to have_content("Companies waiting for confirmation")
    expect(page).to have_content("Job Posts to validate")
  end
end