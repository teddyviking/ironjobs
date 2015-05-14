require 'rails_helper'

RSpec.describe User, type: :model do
  
  context "when saving an user" do
  	include UserHelpers
  	let(:create_user) {create(:user)}
  	let(:empty_user) {user = User.new}
  	
  	it "has an error when no email included" do
  		check_mandatory_attribute(:email, empty_user)
  	end
  	it "has an error when no first name included" do
  		check_mandatory_attribute(:first_name, empty_user)
  	end
  	it "has an error when no last name included" do
  		check_mandatory_attribute(:last_name, empty_user)
  	end
  	it "has an error when no location included" do
  		check_mandatory_attribute(:location, empty_user)
  	end
  	it "has an error when email already in use" do
  		user1 = create_user
  		user2 = build(:user, email: user1.email )
  		user2.valid?
  		expect(user2.errors[:email].any?).to eq(true)
  	end
  end

end
