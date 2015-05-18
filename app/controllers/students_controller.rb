class StudentsController < ApplicationController
	def index
		@students = User.students
	end

	def show
		@student = User.find_by_id(params[:id])
		unless @student
			@students = User.students
			flash.now[:alert] = "Student not found"
			render "index", status: 301
		end
	end

	def edit
		@student = User.find_by_id(params[:id])
	end
end
