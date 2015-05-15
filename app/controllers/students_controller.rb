class StudentsController < ApplicationController
	def index
		@students = User.where(role: "student")
	end

	def show
		
	end
end
