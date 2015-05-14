require 'rails_helper'

RSpec.describe User, type: :model do
  context "when saving an user without required attributes" do
  	user = User.new
  	user.valid?
  	it "raises an error when no email included" do
  		expect(user.errors[:email].any?).to eq(true)
  	end
  	it "raises an error when no name included" do
  		expect(user.errors[:name].any?).to eq(true)
  	end
  	it "raises an error when no last name included" do
  		expect(user.errors[:last_name].any?).to eq(true)
  	end
  	it "raises an error when no location included" do
  		expect(user.errors[:location].any?).to eq(true)
  	end
  end
end
