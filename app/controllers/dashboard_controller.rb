class DashboardController < ApplicationController
  	before_action :authenticate_user!
	def index
		# binding.pry
		@pending_companies = User.companies.where(confirmed: false)
	end
end
