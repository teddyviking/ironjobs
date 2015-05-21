module JobPostsHelper

	def dynamic_job_post_form_route(company, job_post)
		job_post.new_record? ? company_job_posts_path(company) : company_job_post_path(company, job_post)
	end
end
