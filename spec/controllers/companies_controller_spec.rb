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

	end
end
