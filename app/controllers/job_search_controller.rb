class JobSearchController < ApplicationController

	def index
		if params[:query]
			tags = params[:query].split(", ")
			@job_posts = JobPost.tagged_with(tags)
			flash.now[:alert] = "No job post matches your search. Try again, please." if @job_posts.empty?
		else
			@job_posts = JobPost.all
		end
	end

end
