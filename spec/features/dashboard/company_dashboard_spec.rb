require 'rails_helper'


feature 'Company Dashboard' do
  background do
    @companies = create_list(:company, 10)
      @companies.map{|company| company.update(confirmed: true)}
      @user = @companies.first
  end

  scenario 'A company logs in the app' do
       visit new_user_session_path

       fill_in("user_email", :with => @user.email)
       fill_in("user_password", :with => @user.password)
       click_on("Log in")

       expect(current_path).to eq(root_path)

       expect(page).to have_content("Welcome " + @user.first_name)
       expect(source).to include(student_search_path)
       expect(source).to include(edit_company_profile_path)
       expect(source).to include(new_company_job_post_path(@user))
  end
end