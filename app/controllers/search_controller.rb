class SearchController < ApplicationController
	def student_search
		if params[:query]
			tags = params[:query].split(", ")
			@students = User.students.tagged_with(tags)
			flash.now[:alert] = "No student matches your search. Try again, please." if @students.empty?
		else
			@students = User.students
		end
	end

	def job_search
		if params[:query]
			tags = params[:query].split(", ")
			@job_posts = JobPost.tagged_with(tags)
			flash.now[:alert] = "No job post matches your search. Try again, please." if @job_posts.empty?
		else
			@job_posts = JobPost.all
		end
	end

	def company_search
		
	end
end
