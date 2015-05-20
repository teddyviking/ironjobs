class StudentSearchController < ApplicationController
	def index
		if params[:query]
			tags = params[:query].split(", ")
			@students = User.students.tagged_with(tags)
			flash[:alert] = "No student matches your search. Try again, please." if @students.empty?
		else
			@students = User.students
		end
	end
end
