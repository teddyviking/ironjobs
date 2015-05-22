class AdminController < ApplicationController

	def company_confirmation
		@company = User.companies.find_by_id(params[:id])
		@company.update(confirmed: true)
		flash[notice] = @company.company_name + " is now active"
		redirect_to dashboard_path
	end
end
