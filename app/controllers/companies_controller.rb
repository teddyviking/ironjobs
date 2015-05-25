class CompaniesController < ApplicationController
	before_action :authenticate_user!
	def index
		@companies = User.companies
	end

	def show
		if current_user.role == "admin"
			@company = User.companies.find_by_id(params[:id])
			company_not_found unless @company
		else
			@company = User.confirmed_companies.find_by_id(params[:id])
			company_not_found unless @company
		end
	end


	private

	def company_not_found
		flash[:alert] = "Company not found"
		redirect_to company_search_path
		return
	end
end
