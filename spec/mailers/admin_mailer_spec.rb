require "rails_helper"

RSpec.describe AdminMailer, type: :mailer do
  describe "Activation email" do
  	let(:create_company) {create(:company)}
  	let(:mail) {AdminMailer.send_activation(create_company)}
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
end
