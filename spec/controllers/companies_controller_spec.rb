require 'rails_helper'

RSpec.describe CompaniesController, type: :controller do
	let(:create_company) {create(:company)}

	describe "GET #index" do
		before(:each) do 
			sign_in(create(:admin))
			get :index
		end

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
		before(:each) {sign_in(create(:admin))}
		context "when the company doesn't exist" do
			before(:each) {	get :show,{ id: "no_id" } }

			it "responds with an HTTP 302 status code" do
				expect(response).to have_http_status(302)
			end

			it "redirects to the companies search action" do
				expect(response).to redirect_to(company_search_path)
			end
		end

		context "when the company exist" do
			before(:each) do	
				@company = create_company
				@company.update(confirmed: true)
				
				get :show,{ id: @company.id }
			end

			it "responds successfully with an HTTP 200 status code" do
		      	expect(response).to be_success
		      	expect(response).to have_http_status(200)
		    end

		    it "renders the show template" do
		      expect(response).to render_template("show")
		    end

		    it "gets the right company" do
		    	expect(assigns(:company)).to eq(@company)
		    end
		end
	end
end
