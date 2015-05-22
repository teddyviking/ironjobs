require 'rails_helper'
require 'helpers/users_helper_spec'

RSpec.describe User, type: :model do
  
  context "when saving an user" do
  	include UserHelpers
  	
  	it "has a valid factory" do 
      expect(create(:student)).to be_valid
  		expect(create(:admin)).to be_valid
  		expect(create(:company)).to be_valid 		 
  	end 
  	
  	let(:create_student) {create(:student)}
  	let(:create_company) {create(:company)}
  	let(:create_admin) {create(:admin)}
  	let(:empty_user) {user = User.new}
  	
  	it "is invalid if no email included" do
  		check_mandatory_attribute(:email, empty_user)
  	end
  	it "is invalid if no first name included" do
  		check_mandatory_attribute(:first_name, empty_user)
  	end
  	it "is invalid if no last name included" do
  		check_mandatory_attribute(:last_name, empty_user)
  	end
  	it "is invalid if no location included" do
  		check_mandatory_attribute(:location, empty_user)
  	end
  	it "is invalid if no role included" do
      user = empty_user
      user.role = nil
  		check_mandatory_attribute(:role, user)
  	end

  	it "is invalid if not valid role is included" do
  		user = build(:admin, role: "singer")
  		user.valid?
  		expect(user.errors[:role].any?).to eq(true)
  	end

  	it "is invalid if email already in use" do
  		user1 = create_student
  		user2 = build(:student, email: user1.email )
  		user2.valid?
  		expect(user2.errors[:email].any?).to eq(true)
  	end

  	it "is invalid if user not an admin and searching is empty" do
  		user = build(:student, searching: nil )
  		user.valid?
  		expect(user.errors[:searching].any?).to eq(true)
  	end

    context "is a company" do
      it "add pending confirmation before saving" do
        user = create(:company)
        expect(user.confirmed).to eq(false)
      end
    end

  end

end
