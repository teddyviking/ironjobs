require 'rails_helper'


feature 'Student Dashboard' do
  background do
    @students = create_list(:student, 10)
      @user = @students.first
  end

  scenario 'A student logs in the app' do
       visit new_user_session_path

       fill_in("user_email", :with => @user.email)
       fill_in("user_password", :with => @user.password)
       click_on("Log in")

       expect(current_path).to eq(root_path)

       expect(page).to have_content("Welcome " + @user.first_name)
       expect(source).to include(job_search_path)
       expect(source).to include(company_search_path)
       expect(source).to include(edit_student_path(@user))
       expect(source).to include(student_applications_path(@user))
  end
end