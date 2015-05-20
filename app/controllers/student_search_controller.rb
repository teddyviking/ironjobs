class StudentSearchController < ApplicationController
	def index
		if params[:query]
			tags = params[:query].split(", ")
			@students = User.students.tagged_with(tags)
		else
			@students = User.students
		end
	end
end
