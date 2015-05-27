class AdminController < ApplicationController

  def company_confirmation
    @company = User.companies.find_by_id(params[:id])
    @company.confirm_company
    flash[notice] = @company.company_name + " is now active"
    redirect_to dashboard_path
  end

  def company_denial
    @company = User.companies.find_by_id(params[:id])
    @company.deny_company
    flash[notice] = @company.company_name + " has been denied"
    redirect_to dashboard_path
  end

  def job_post_confirmation
    @job_post = JobPost.find_by_id(params[:id])
    current_user.confirm_job_post(@job_post)
    flash[notice] = @job_post.position + " by " + @job_post.company.company_name + " is now active"
    redirect_to dashboard_path
  end
end
