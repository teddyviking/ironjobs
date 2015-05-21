require 'rails_helper'


feature 'Log-in and authorization' do
  background do
    @company = create(:company)
    @student = create(:student)
  end
  scenario 'invalid user tries to log in' do
  end
  scenario 'valid user logs in' do
  end

  scenario 'company tries to enter a student edit profile' do
    login_as(@company, :scope => :user)
    visit edit_student_path(@student)

    expect(current_path).to eq(students_path)
    expect(page).to have_content("Not authorized to edit this profile")
  end

  
end