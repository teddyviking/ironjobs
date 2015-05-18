class StudentsController < ApplicationController
	def index
		@students = User.where(role: "student")
	end

	def show
		@student = User.find_by_id(params[:id])
		unless @student
			@students = User.where(role: "student")
			flash.now[:alert] = "Student not found"
			render "index", status: 301
		end
	end
end
