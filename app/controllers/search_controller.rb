class SearchController < ApplicationController
	def student_search
		if params[:query]
			tags = get_tags
			@students = User.students.tagged_with(tags)
			flash.now[:alert] = "No student matches your search. Try again, please." if @students.empty?
		else
			@students = User.students
		end
	end

	def job_search
		if params[:query]
			tags = get_tags
			@job_posts = JobPost.tagged_with(tags)
			flash.now[:alert] = "No job post matches your search. Try again, please." if @job_posts.empty?
		else
			@job_posts = JobPost.all
		end
	end

	def company_search
		if params[:query]
			tags = get_tags
			@companies = User.confirmed_companies.tagged_with(tags)
			flash.now[:alert] = "No company matches your search. Try again, please." if @companies.empty?
		else
			@companies = User.confirmed_companies
		end
	end

	private

	def get_tags
		params[:query].split(", ")
	end
end
