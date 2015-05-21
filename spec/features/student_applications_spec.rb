require 'rails_helper'


feature 'Student applications' do
  background do
  	@company = create(:company)
    @job_post = @company.job_posts.create(attributes_for(:job_post))
    @student = create(:student)
  end
  scenario 'student applies to a job post' do
    visit company_job_post_path(@company, @job_post)

    click_on('Apply!')

    expect(current_path).to eq(student_applications_path(@student))
    expect(page).to have_content(:link_or_button, @job_post.position + " at " + @job_post.company.company_name) 
  end
end