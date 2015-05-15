require 'rails_helper'

RSpec.describe User, type: :model do
  
  context "when saving an user" do
  	include UserHelpers
  	let(:create_student) {create(:student)}
  	let(:create_company) {create(:company)}
  	let(:create_admin) {create(:admin)}
  	let(:empty_user) {user = User.new}
  	
  	it "has an error if no email included" do
  		check_mandatory_attribute(:email, empty_user)
  	end
  	it "has an error if no first name included" do
  		check_mandatory_attribute(:first_name, empty_user)
  	end
  	it "has an error if no last name included" do
  		check_mandatory_attribute(:last_name, empty_user)
  	end
  	it "has an error if no location included" do
  		check_mandatory_attribute(:location, empty_user)
  	end
  	it "has an error if no role included" do
  		check_mandatory_attribute(:role, empty_user)
  	end

  	it "has an error if not valid role is included" do
  		user = build(:admin, role: "singer")
  		user.valid?
  		expect(user.errors[:role].any?).to eq(true)
  	end

  	it "has an error if email already in use" do
  		user1 = create_student
  		user2 = build(:student, email: user1.email )
  		user2.valid?
  		expect(user2.errors[:email].any?).to eq(true)
  	end

  	it "has an error if user not an admin and searching is empty" do
  		user = build(:student, searching: nil )
  		user.valid?
  		expect(user.errors[:searching].any?).to eq(true)
  	end
  end

end
