class JobSearchController < ApplicationController

	def index
		if params[:query]
			tags = params[:query].split(",")
			@job_posts = JobPost.tagged_with(tags)
		else
			@job_posts = JobPost.all
		end
	end

end
