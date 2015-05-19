require 'rails_helper'

RSpec.describe JobPost, type: :model do
	context "when creating a JobPost from a student" do
		it "is invalid" do
			student = create(:student)
			expect(student.job_posts.create).to be_invalid
		end
	end
	context "when creating a JobPost from a company" do
		it "is valid" do
			company = create(:company)
			expect(company.job_posts.create).to be_valid
		end
	end
end
