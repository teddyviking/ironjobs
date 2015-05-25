require "rails_helper"

RSpec.describe AdminMailer, type: :mailer do
  describe "company activation email" do
  	let(:create_company) {create(:company)}
  	let(:mail) {AdminMailer.send_company_activation(create_company)}
  	it 'renders the subject' do
      expect(mail.subject).to eql('Your Ironjobs account has been activated')
    end

    it 'renders the receiver email' do
      expect(mail.to).to eql([create_company.email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eql(['ironjobs@ironhack.com'])
    end
  end

  describe "job post confirmation email" do
  	let(:company) {create(:company, confirmed: true)}
    let(:new_job_post) { company.job_posts.create(attributes_for(:job_post))}
  	let(:mail) {AdminMailer.send_job_post_activation(new_job_post)}

  	it 'renders the subject' do
      expect(mail.subject).to eql('Your job post has been accepted')
    end

    it 'renders the receiver email' do
      expect(mail.to).to eql([company.email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eql(['ironjobs@ironhack.com'])
    end
  end

  describe "notification of the creation of a company" do
    let(:create_company) {create(:company)}
    let(:mail) {AdminMailer.send_new_company_notification(create_company)}

    it 'renders the subject' do
      expect(mail.subject).to eql('New company needs validation')
    end

    it 'renders the receiver email' do
      expect(mail.to).to eql(['ironjobs@ironhack.com'])
    end

    it 'renders the sender email' do
      expect(mail.from).to eql(['ironjobs@ironhack.com'])
    end

    it 'renders the link to the company profile' do
      expect(mail.body.encoded).to match("http://example.com/companies/#{create_company.id}")
    end
  end

  describe "notification of the creation of a job post" do
    let(:company) {create(:company, confirmed: true)}
    let(:new_job_post) { company.job_posts.create(attributes_for(:job_post))}
    let(:mail) {AdminMailer.send_new_job_post_notification(new_job_post)}

    it 'renders the subject' do
      expect(mail.subject).to eql('New job post needs validation')
    end

    it 'renders the receiver email' do
      expect(mail.to).to eql(['ironjobs@ironhack.com'])
    end

    it 'renders the sender email' do
      expect(mail.from).to eql(['ironjobs@ironhack.com'])
    end

    it 'renders the link to the company profile' do
      expect(mail.body.encoded).to match("http://example.com/companies/#{company.id}/job_posts/#{new_job_post.id}")
    end
  end
end
