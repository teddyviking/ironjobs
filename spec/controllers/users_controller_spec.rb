require 'rails_helper'

RSpec.describe UsersController, type: :controller do
	let(:create_student) {create(:student)}
  	let(:create_company) {create(:company)}
  	let(:create_admin) {create(:admin)}

  	describe "GET #students_index" do
		it "gets an empty array if no students exist" do
			get :students_index

			expect(assigns(:users)).to eq([])
		end


	end

end
