module SearchHelper

	def set_route_to_filter
		if params[:action] == "student_search"
			student_search_path
		elsif params[:action] == "job_search"
			job_search_path
		elsif params[:action] == "company_search"
			company_search_path	
		end
	end
end
