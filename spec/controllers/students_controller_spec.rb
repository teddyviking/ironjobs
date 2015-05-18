require 'rails_helper'

RSpec.describe StudentsController, type: :controller do
	# include StudentHelpers
	let(:create_student) {create(:student)}
	let(:create_complete_student) {create(:complete_student)}


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
		context "the student doesn't exit" do
			before(:each) {	get :show,{ id: "no_id" } }

			it "responds with an HTTP 404 status code" do
				expect(response).to have_http_status(301)
			end

			it "renders the index template" do
				expect(response).to render_template("index")
			end

			it "gets an array of students" do
				students = [create(:student), create(:student)]
				expect(assigns(:students)).to match_array(students)
			end
		end

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


	describe "PATCH #update" do
		context "the student is invalid" do
			before(:each) do
				@student = create_student

				patch :update, {id: @student.id, user: (attributes_for(:invalid_student))}
			end
			it "renders the edit template" do
				expect(response).to render_template("edit")
			end

			it "responds with an HTTP 422 status code" do
				expect(response).to have_http_status(422)
			end
		end

		context "the student is valid" do
			before(:each) do
				@student = create_student

				patch :update, {id: @student.id, user: (attributes_for(:complete_student))}
			end

			it "responds with an HTTP 302 status code" do
		      	expect(response).to have_http_status(302)
			end

			it "redirects to the show template of the student" do
				expect(response).to redirect_to(student_path(@student))
			end

		end

	end

end
