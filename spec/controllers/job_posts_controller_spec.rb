require 'rails_helper'

RSpec.describe JobPostsController, type: :controller do
	

	describe "GET #index" do
		
		before(:each) do 
			@company = create(:company)
			get :index,{ id: @company.id }
		end

		it "responds successfully with an HTTP 200 status code" do
	      	expect(response).to be_success
			expect(response).to have_http_status(200)
	    end
		
		it "renders the index template" do
	      expect(response).to render_template("index")
	    end

	    it "gets an empty array if no job posts exist" do
			expect(assigns(:job_posts)).to match_array([])
		end

		it "gets an array of job posts" do
			job_posts = [create(:job_post, company_id: @company.id), create(:job_post, company_id: @company.id)]
			expect(assigns(:job_posts)).to match_array(job_posts)
		end

	end
end
