class CompaniesController < ApplicationController
	def index
		@companies = User.where(role: "company")
	end

	def show
		@company = User.find_by_id(params[:id])
		unless @company
			@companies = User.where(role: "company")
			flash.now[:alert] = "Company not found"
			render "index", status: 301
			return
		end
	end
end
