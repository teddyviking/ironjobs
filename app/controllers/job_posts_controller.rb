class JobPostsController < ApplicationController

	def index
		@company = User.find_by_id(params[:company_id])
		@job_posts = @company.job_posts
	end

	def show
		@company = User.find_by_id(params[:company_id])
		@job_post = @company.job_posts.find_by_id(params[:id])
	end
end
