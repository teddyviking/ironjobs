class JobPostsController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :is_company, only: [:new, :create]


  def index
    @company = User.find_by_id(params[:company_id])
    @job_posts = @company.job_posts
  end

  def show
    if current_user.role == "admin"
      @job_post = JobPost.find_by_id(params[:id])
      job_post_not_found if !@job_post || !@job_post.company
    else
      @job_post = JobPost.confirmed.find_by_id(params[:id])
      job_post_not_found if !@job_post || !@job_post.company.confirmed
    end
  end

  def new
    @company = User.find_by_id(params[:company_id])
    @job_post = @company.job_posts.new
    render 'new'
  end

  def create
    @company = User.find_by_id(params[:company_id])
    @job_post = @company.job_posts.new job_post_params
    if @job_post.save
      redirect_to company_job_post_path(@company, @job_post)
    else
      render 'new', status: 422
    end
  end
  def edit
    @company = User.find_by_id(params[:company_id])
    @job_post = @company.job_posts.find_by_id(params[:id])
  end

  def update
    @company = User.find_by_id(params[:company_id])
    @job_post = @company.job_posts.find_by_id(params[:id])
    if @job_post.update job_post_params
      redirect_to company_job_post_path(@company, @job_post)
    else
      render "edit", status: 422
    end
  end

  private

  def job_post_params
    params.require(:job_post).permit(:description, :location, :salary, :position, :contract_type, :tag_list)
  end

  def correct_user
    @user = User.find_by(id: params[:company_id])
    redirect_to job_search_path, notice: "Not authorized to edit this job post" if @user != current_user
  end

  def is_company
    @user = User.find_by(id: current_user.id)
    redirect_to job_search_path, notice: "Not authorized to create a job post" if @user.role != "company"
  end

  def job_post_not_found
    flash[alert] = "Job post does not exist"
    redirect_to job_search_path
  end
end
