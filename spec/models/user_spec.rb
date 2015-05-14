require 'rails_helper'

RSpec.describe User, type: :model do
  
  context "when saving an user without required attributes" do
  	user = User.new
  	user.valid?
  	it "has an error when no email included" do
  		expect(user.errors[:email].any?).to eq(true)
  	end
  	it "has an error when no name included" do
  		expect(user.errors[:first_name].any?).to eq(true)
  	end
  	it "has an error when no last name included" do
  		expect(user.errors[:last_name].any?).to eq(true)
  	end
  	it "has an error when no location included" do
  		expect(user.errors[:location].any?).to eq(true)
  	end
  end

  context "when trying to save an email already in use" do
  		let(:create_user) {create(:user)}
  	it "has an error when email already in use" do
  		user1 = create_user
  		user2 = build(:user, email: user1.email )
  		user2.valid?
  		expect(user2.errors[:email].any?).to eq(true)
  	end
  end
end
