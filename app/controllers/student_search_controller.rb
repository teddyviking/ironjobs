class StudentSearchController < ApplicationController
	def index
		@students = User.students
	end
end
