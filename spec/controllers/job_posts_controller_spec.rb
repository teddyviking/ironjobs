require 'rails_helper'

RSpec.describe JobPostsController, type: :controller do
	

	describe "GET #index" do
		
		before(:each) do 
			@company = create(:company)
			get :index,{ company_id: @company.id }
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


	describe "POST #create" do
		before(:each) {@company= create(:company)}
		context "when creating an invalid job post" do
			before(:each) { post :create,{company_id: @company.id, job_post:(attributes_for(:invalid_job_post))}}
			it "renders the new template" do
				expect(response).to render_template("new")
			end

			it "responds with an HTTP 422 status code" do
				expect(response).to have_http_status(422)
			end
		end
		context "when creating a valid job post" do
			before(:each){ post :create,{ company_id: @company.id, job_post:(attributes_for(:job_post))}}

			it "responds with an HTTP 302 status code" do
		      	expect(response).to have_http_status(302)
			end

			it "redirects to the show template of the student" do
				expect(response).to redirect_to(company_job_posts_path(@company, JobPost.last))
			end
		end

	end
end
