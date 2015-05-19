require 'rails_helper'

RSpec.describe JobApplication, type: :model do
  let(:create_student) {create(:student)}
  let(:create_company) {create(:company)}

  context "when creating a Job Application from a company" do
		it "is invalid" do
			company = create_company
			job_post = company.job_posts.create
			job_application = company.job_applications.create(job_post: job_post)
			
			expect(job_application).to be_invalid
		end
	end
	context "when creating a Job Application from a company" do
		it "is invalid if doesn't have job_post_id" do
			student = create(:student)
			expect(student.job_applications.create).to be_invalid

		end
		# it "is valid" do
		# 	student = create(:student)
		# 	job_post = create_company.job_posts.create
		# 	expect(student.job_applications.create(job_post_id: job_post.id)).to be_valid
		# end
	end
end
