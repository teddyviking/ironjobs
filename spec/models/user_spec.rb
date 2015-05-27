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
      it "add pending confirmation before saving a new company" do
        company = create(:company)
        expect(company.confirmed).to eq("unconfirmed")
      end

      it "do not add pending confirmation to an already existing company" do
        company = create(:company)
        expect(company.confirmed).to eq("unconfirmed")
        company.update(confirmed: "confirmed")
        company.update(twitter: "no")
        expect(company.confirmed).to eq("confirmed")
      end

      it "is invalid if situation is not filled" do
        company = build(:company, situation: nil)
        expect(company).to be_invalid
      end

      it "is invalid if  company name is not filled" do
        company = build(:company, company_name: nil)
        expect(company).to be_invalid
      end

      it "sends an email to the admin" do

        expect { create(:company) }.to change { ActionMailer::Base.deliveries.count }.by(1)
      end
    end

  end

  context "when admin confirms a company" do
    let(:admin) { create(:admin)}
    let(:new_company) { create(:company)}

    it "changes the confirmed state" do
      new_company.confirm_company
      expect(new_company.confirmed).to eq("confirmed")
    end

    it "sends an email to the company" do
      expect { new_company.confirm_company }.to change { ActionMailer::Base.deliveries.count }.by(2)
    end
  end

  context "when admin denies a company" do
    let(:new_company) { create(:company)}

    it "changes the confirmed state" do
      new_company.deny_company
      expect(new_company.confirmed).to eq("denied")
    end
  end

  context "when admin confirms a job post" do
    let(:admin) { create(:admin)}
    let(:company) {create(:company, confirmed: "confirmed")}
    let(:new_job_post) { company.job_posts.create(attributes_for(:job_post))}

    it "changes the confirmed state" do
      new_job_post.confirm_job_post
      expect(new_job_post.confirmed).to eq("confirmed")
    end

    it "sends an email to the company" do
      expect { new_job_post.confirm_job_post }.to change { ActionMailer::Base.deliveries.count }.by(3)
    end

  end

end
