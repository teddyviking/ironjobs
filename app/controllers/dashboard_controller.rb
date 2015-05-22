class DashboardController < ApplicationController
  	before_action :authenticate_user!
	def index
		@pending_companies = User.companies.where(confirmed: false)
	end
end
