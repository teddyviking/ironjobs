require 'rails_helper'


feature 'Log-in and authorization' do
  background do
    @company = create(:company)
    @company.update(confirmed: true)
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

  scenario 'student tries to enter another students edit profile' do
    login_as(@student, :scope => :user)
    another_student = create(:student)
    visit edit_student_path(another_student)

    expect(current_path).to eq(students_path)
    expect(page).to have_content("Not authorized to edit this profile")
  end

  scenario 'student tries to edit a job post' do
    login_as(@student, :scope => :user)

    visit edit_company_job_post_path(@company, @company.job_posts.create(attributes_for(:job_post)))

    expect(current_path).to eq(job_search_path)
    expect(page).to have_content("Not authorized to edit this job post")

  end

  scenario 'student tries to create a job post' do
    login_as(@student, :scope => :user)

    visit new_company_job_post_path(@company)

    expect(current_path).to eq(job_search_path)
    expect(page).to have_content("Not authorized to create a job post")
  end

  scenario 'company tries to apply to a job post' do
    login_as(@company, :scope => :user)
    job_post = @company.job_posts.create(attributes_for(:job_post))

    visit company_job_post_path(@company, job_post)

    expect(page).not_to have_content('Apply!')
  end




end