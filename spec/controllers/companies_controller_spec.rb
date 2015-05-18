require 'rails_helper'

RSpec.describe CompaniesController, type: :controller do
	let(:create_company) {create(:company)}

	describe "GET #index" do
		before(:each) {get :index}

		it "responds successfully with an HTTP 200 status code" do
	      	expect(response).to be_success
	      	expect(response).to have_http_status(200)
	    end

	    it "renders the index template" do
	      expect(response).to render_template("index")
	    end

	    it "gets an empty array if no company exist" do
			expect(assigns(:companies)).to match_array([])
		end

		it "gets an array of companies" do
			companies = [create(:company), create(:company)]
			expect(assigns(:companies)).to match_array(companies)
		end
	end

	describe "GET #show" do
		context "when the company doesn't exist" do
			before(:each) {	get :show,{ id: "no_id" } }

			it "responds with an HTTP 301 status code" do
				expect(response).to have_http_status(301)
			end

			it "renders the index template" do
				expect(response).to render_template("index")
			end

			it "gets an array of companies" do
				companies = [create(:company), create(:company)]
				expect(assigns(:companies)).to match_array(companies)
			end
		end

		context "when the company exist" do
			before(:each) do	
				@company = create_company

				get :show,{ id: @company.id }
			end

			it "responds successfully with an HTTP 200 status code" do
		      	expect(response).to be_success
		      	expect(response).to have_http_status(200)
		    end

		    it "renders the show template" do
		      expect(response).to render_template("show")
		    end
		end
	end
	

	# describe "POST #create" do
	# 	context "when register information is invalid" do
	# 		it ""
	# 	end

	# 	context "when register information is valid" do

	# 	end
	# end

	
end
