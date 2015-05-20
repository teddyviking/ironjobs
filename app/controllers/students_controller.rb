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
			return
		end
	end

	def edit
		@student = User.find_by_id(params[:id])
	end

	def update
		@student = User.find_by_id(params[:id])
		unless @student.update(student_params)
			render "edit", status: 422
			return
		end
		redirect_to student_path(@student)
	end



	private

	def student_params
		params.require(:user).permit(:first_name, :last_name, :url, :location,
										:email, :facebook, :github, :twitter, :phone, :searching, :tag_list)
	end
end
