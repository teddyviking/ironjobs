class AdminMailer < ApplicationMailer
	default from: 'ironjobs@ironhack.com'

	def send_activation(user)
		mail(to: user.email, subject: 'Your Ironjobs account has been activated')
	end
end
