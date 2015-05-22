class JobApplicationsController < ApplicationController
	before_action :is_student, only: [:new, :create, :index]
	before_action :authenticate_user!

	def index
		@student = User.students.find_by(id: params[:id])
		@applied_job_posts = @student.applied_job_posts
	end

	def create
		@student = User.students.find_by(id: params[:id])
		@job_post = JobPost.find_by_id(params[:job_post_id])

		if @student.applied_job_posts.include?(@job_post)
			flash[alert] = "You have already applied to this job post"
		else
			@applied_job_post = @student.applied_job_posts << @job_post
			flash[notice] = "Your application has been sent"
		end
		redirect_to student_applications_path(@student)
	end

	private

	def job_application_params
		params.require(:job_application).permit()
	end


	def is_student
		@user = User.find_by(id: current_user.id)
		redirect_to company_job_posts_path(@user), notice: "Not authorized to apply to a job post" if @user.role != "student"
	end
end
