class SearchController < ApplicationController
	include SearchHelper

	def student_search
		if params[:query]
			@tags = get_tags
			@students = User.students.tagged_with(@tags)
			flash.now[:alert] = "No student matches your search. Try again, please." if @students.empty?
		else
			@students = User.students
		end
	end

	def job_search	
		@tags = get_tags		
		respond_to do |format|
			format.html {@job_posts = JobPost.confirmed}
			format.js do
				@job_posts = JobPost.tagged_search(@tags)
				flash[:alert] = "Nothing found" if @job_posts.empty?
			end
		end
	end

	def company_search
		if params[:query]
			@tags = get_tags
			@companies = User.confirmed_companies.tagged_with(@tags)
			flash.now[:alert] = "No company matches your search. Try again, please." if @companies.empty?
		else
			@companies = User.confirmed_companies
		end
	end

	private
end
