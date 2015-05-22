class AdminController < ApplicationController

	def company_confirmation
		@company = User.companies.find_by_id(params[:id])
		@company.update(confirmed: true)
		flash[notice] = @company.company_name + " is now active"
		redirect_to dashboard_path
	end

	def job_post_confirmation
		@job_post = JobPost.find_by_id(params[:id])
		@job_post.update(confirmed: true)
		flash[notice] = @job_post.position + " by " + @job_post.company.company_name + " is now active"
		redirect_to dashboard_path
	end
end
