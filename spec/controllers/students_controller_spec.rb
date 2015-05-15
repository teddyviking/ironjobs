require 'rails_helper'

RSpec.describe StudentsController, type: :controller do
	# include StudentHelpers
	let(:create_student) {create(:student)}

  	describe "GET #index" do
  		before(:each) {get :index}

		it "responds successfully with an HTTP 200 status code" do
	      	expect(response).to be_success
			expect(response).to have_http_status(200)
	    end
		
		it "renders the index template" do
	      expect(response).to render_template("index")
	    end

		it "gets an empty array if no students exist" do
			expect(assigns(:students)).to match_array([])
		end

		it "gets an array of students" do
			students = [create(:student), create(:student)]
			expect(assigns(:students)).to match_array(students)
		end
	end


	describe "GET #show" do
		context "the student exists" do
			before(:each) do 
				@student = create_student

				get :show, id: @student
			end

			it "responds successfully with an HTTP 200 status code" do
		      	expect(response).to be_success
		      	expect(response).to have_http_status(200)
		    end

		    it "renders the show template" do
		      expect(response).to render_template("show")
		    end

		    it "gets the correct student" do
		    	expect(assigns(:student)).to eq(@student)
		    end
		end

	end
end
