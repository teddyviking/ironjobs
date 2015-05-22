class CompaniesController < ApplicationController
	before_action :authenticate_user!
	def index
		@companies = User.companies
	end

	def show
		
		if current_user.role == "admin"
			@company = User.companies.find_by_id(params[:id])
			unless @company
				@companies = User.where(role: "company")
				flash.now[:alert] = "Company not found"
				render "index", status: 301
				return
			end
		else
			@company = User.confirmed_companies.find_by_id(params[:id])
			unless @company
				@companies = User.where(role: "company")
				flash.now[:alert] = "Company not found"
				render "index", status: 301
				return
			end
		end
	end
end
