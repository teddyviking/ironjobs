require 'rails_helper'

RSpec.describe JobPost, type: :model do
	context "when creating a JobPost from a student" do
		it "is invalid" do
			student = create(:student)
			job_post = student.job_posts.create
			expect(job_post).to be_invalid
			expect(JobPost.last).not_to eq(job_post)
		end
	end
	context "when creating a JobPost from a company" do
		it "is valid" do
			company = create(:company)
			expect(company.job_posts.create).to be_valid
		end
	end
end
