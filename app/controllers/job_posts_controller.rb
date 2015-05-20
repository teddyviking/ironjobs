class JobPostsController < ApplicationController

	def index
		@company = User.find_by_id(params[:company_id])
		@job_posts = @company.job_posts
	end

	def show
		@company = User.find_by_id(params[:company_id])
		@job_post = @company.job_posts.find_by_id(params[:id])
	end

	def new
		@company = User.find_by_id(params[:company_id])
		@job_post = @company.job_posts.new
		render 'new'
	end

	def create
		@company = User.find_by_id(params[:company_id])
 		@job_post = @company.job_posts.new job_post_params
 		if @job_post.save
 			redirect_to company_job_post_path(@company, @job_post)
 		else
			render 'new', status: 422
		end
		
	end

	private

	def job_post_params
		params.require(:job_post).permit(:description, :location, :salary, :position, :contract_type, :tag_list)
	end
end
