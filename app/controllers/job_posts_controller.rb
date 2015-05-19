class JobPostsController < ApplicationController

	def index
		@company = User.find_by_id(params[:id])
		@job_posts = @company.job_posts
	end
end
