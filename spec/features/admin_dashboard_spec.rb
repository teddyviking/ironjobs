require 'rails_helper'


feature 'Admin dashboard' do
  background do

  	@admin = create(:admin)
  	@companies = create_list(:company, 10)
  	@companies.map{|company| company.update(confirmed: true)}
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

  scenario 'there is nothing pending' do 
  	login_as(@admin, :scope => :user)
  	visit dashboard_path

  	expect(page).to have_content("Nothing pending")
	expect(find('.notifications')).to have_selector('li', count: 1)

  end

  scenario 'there is a company waiting for confirmation' do
	new_company = create(:company)
	login_as(@admin, :scope => :user)


  	visit dashboard_path

  	expect(page).to have_content("1 company confirmation request")
	expect(page).to have_content(:link_or_button, new_company.company_name)

	click_on(new_company.company_name)

	expect(current_path).to eq(company_path(new_company))

	click_on("Confirm company")

	expect(current_path).to eq(dashboard_path)
	expect(page).to have_content(new_company.company_name + " is now active")
	expect(page).to have_content("Nothing pending")
	expect(find('.notifications')).to have_selector('li', count: 1)
  end

  scenario 'there are multiple companies waiting for confirmation' do
  	new_companies = create_list(:company, 2)
  	login_as(@admin, :scope => :user)

  	visit dashboard_path

  	expect(page).to have_content("2 company confirmation requests")
	expect(page).to have_content(:link_or_button, new_companies[0].company_name)
	expect(page).to have_content(:link_or_button, new_companies[1].company_name)
  end
end