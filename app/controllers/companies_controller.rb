class CompaniesController < ApplicationController
	def index
		@companies = User.where(role: "company")
	end

	def show

		render "index", status: 301
		
	end
end
