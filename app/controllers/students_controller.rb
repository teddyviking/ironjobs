class StudentsController < ApplicationController
	def index
		@students = User.where(role: "student")
	end

	def show
		@student = User.find_by_id(params[:id])
		unless @student
			redirect_to students_path, status: 301
		end
	end
end
