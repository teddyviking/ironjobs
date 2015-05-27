class DashboardController < ApplicationController
    before_action :authenticate_user!
    include DashboardHelper
  def index
    if current_user.role == "admin"
      @pending_companies = User.companies.where(confirmed: "unconfirmed")
      @pending_job_posts = JobPost.where(confirmed: "unconfirmed")

      set_admin_notifications
    end
  end

  private

  def set_admin_notifications
    flash[:companies] = create_pending_confirmation_message(@pending_companies) unless @pending_companies.empty?
    flash[:job_posts] = create_pending_confirmation_message(@pending_job_posts) unless @pending_job_posts.empty? 
    (flash[:notice] = "Nothing pending") if @pending_companies.empty? && @pending_job_posts.empty?
  end
end
