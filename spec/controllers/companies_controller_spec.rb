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

	
end
