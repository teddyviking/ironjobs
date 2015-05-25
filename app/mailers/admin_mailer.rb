class AdminMailer < ApplicationMailer
	default from: 'ironjobs@ironhack.com'

	def send_company_activation(user)
		mail(to: user.email, subject: 'Your Ironjobs account has been activated')
	end

	def send_job_post_activation(job_post)
		mail(to: job_post.company.email, subject: 'Your job post has been accepted')
	end
end
