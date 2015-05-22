class DashboardController < ApplicationController
  	before_action :authenticate_user!
	def index
		@admin = User.find_by(id: current_user)
	end
end
