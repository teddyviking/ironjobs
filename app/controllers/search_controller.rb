class SearchController < ApplicationController
  include SearchHelper

  def student_search
    @tags = get_tags    
    respond_to do |format|
      format.html {@students = User.students}
      format.js do
        @students = User.tagged_search(@tags, "student")
        flash.now[:alert] = "Nothing found" if @students.empty?
      end
    end
  end

  def job_search  
    @tags = get_tags    
    respond_to do |format|
      format.html {@job_posts = JobPost.confirmed}
      format.js do
        @job_posts = JobPost.tagged_search(@tags)
        flash.now[:alert] = "Nothing found" if @job_posts.empty?
      end
    end
  end

  def company_search
    @tags = get_tags
      respond_to do |format|
        format.html {@companies = User.confirmed_companies}
        format.js do
          @companies = User.tagged_search(@tags, "company")
          flash.now[:alert] = "Nothing found" if @companies.empty?
        end
      end
  end


end
