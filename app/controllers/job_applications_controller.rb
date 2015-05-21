class JobApplicationsController < ApplicationController
	def index
		@student = User.students.find_by(id: params[:id])
		@applied_job_posts = @student.applied_job_posts
	end

	def create
		@student = User.students.find_by(id: params[:id])
		@job_post = JobPost.find_by_id(params[:job_post_id])
		@applied_job_post = @student.applied_job_posts << @job_post
		redirect_to student_applications_path(@student)
	end

	private

	def job_application_params
		params.require(:job_application).permit()
	end
end
