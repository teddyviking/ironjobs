require 'rails_helper'

RSpec.describe JobPost, type: :model do
	before(:each) {
		@company = create(:company)
	}
	context "when creating a JobPost from a student" do
		it "is invalid" do
			student = create(:student)
			job_post = student.job_posts.create
			expect(job_post).to be_invalid
			expect(JobPost.last).not_to eq(job_post)
		end
	end
	context "when creating a JobPost from a company" do
		it "has a valid factory" do 
  			expect(create(:job_post, company_id: @company.id)).to be_valid
  		end 

		it "is invalid if has no description" do
			expect(@company.job_posts.create(attributes_for(:job_post, description: nil))).to be_invalid
		end
		it "is invalid if has no salary" do
			expect(@company.job_posts.create(attributes_for(:job_post, salary: nil))).to be_invalid
		end
		it "is invalid if has no contract type" do
			expect(@company.job_posts.create(attributes_for(:job_post, contract_type: nil))).to be_invalid
		end
		it "is invalid if has no position" do
			expect(@company.job_posts.create(attributes_for(:job_post, position: nil))).to be_invalid
		end
	end
end
