class CompaniesController < ApplicationController
	def index
		@companies = User.where(role: "company")
	end
end
