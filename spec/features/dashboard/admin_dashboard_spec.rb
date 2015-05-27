require 'rails_helper'


feature 'Admin dashboard' do
  background do

    @admin = create(:admin)
    @companies = create_list(:company, 10)
    @companies.map{|company| company.update(confirmed: true)}
  end

  scenario 'user logs in as an admin' do
    visit new_user_session_path

    fill_in("user_email", :with => @admin.email)
    fill_in("user_password", :with => @admin.password)
    click_on("Log in")

    expect(current_path).to eq(root_path)
    expect(page).to have_content("Welcome " + @admin.first_name)
    expect(page).to have_content("Companies waiting for confirmation")
    expect(page).to have_content("Job Posts to validate")
  end

  scenario 'there is nothing pending' do 
    login_as(@admin, :scope => :user)
    visit dashboard_path

    expect(page).to have_content("Nothing pending")
    expect(find('.alert-info')).to have_selector('section', count: 1)

  end

  context 'confirming new companies' do

    scenario 'there is a pending company waiting for confirmation' do
      new_company = create(:company)
      login_as(@admin, :scope => :user)


      visit dashboard_path

      expect(page).to have_content("1 pending User confirmation request")
      expect(page).to have_content(:link_or_button, new_company.company_name)

      click_on(new_company.company_name)

      expect(current_path).to eq(company_path(new_company))

      click_on("Confirm company")

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content(new_company.company_name + " is now active")
      expect(page).to have_content("Nothing pending")
      expect(find('.alert-info')).to have_selector('section', count: 2)
    end

   scenario 'there are multiple companies waiting for confirmation' do
    new_companies = create_list(:company, 2)
    login_as(@admin, :scope => :user)

      visit dashboard_path

      expect(page).to have_content("2 pending User confirmation requests")
    expect(page).to have_content(:link_or_button, new_companies[0].company_name)
    expect(page).to have_content(:link_or_button, new_companies[1].company_name)
    end
  end

  context 'confirming new job posts' do
    scenario 'there is a job post pending on validation' do
      new_job_post = @companies.first.job_posts.create(attributes_for(:job_post))
      new_job_post_path = new_job_post.position + " by " + new_job_post.company.company_name
      login_as(@admin, :scope => :user)

      visit dashboard_path

      expect(page).to have_content("1 pending Job Post confirmation request")
      expect(page).to have_content(:link_or_button, new_job_post_path)

      click_on(new_job_post_path)

      expect(current_path).to eq(company_job_post_path(new_job_post.company, new_job_post))

      click_on("Validate job post")

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content(new_job_post_path + " is now active")
      expect(page).to have_content("Nothing pending")
      expect(find('.alert-info')).to have_selector('section', count: 2)

    end

    scenario 'there are multiple job posts waiting for confirmation' do
      new_job_posts = []
      2.times{new_job_posts << @companies.first.job_posts.create(attributes_for(:job_post))}
      login_as(@admin, :scope => :user)

      visit dashboard_path

      expect(page).to have_content("2 pending Job Post confirmation request")
      expect(page).to have_content(:link_or_button, new_job_posts[0].position + " by " + new_job_posts[0].company.company_name)
      expect(page).to have_content(:link_or_button, new_job_posts[0].position + " by " + new_job_posts[0].company.company_name)
    end
  end


  context 'denying companies and job posts' do
    # let(:new_company) { create(:company) }
    scenario 'deny a company pending on validation' do
      new_company = create(:company,  company_name: "denied company")
      login_as(@admin, :scope => :user)

      visit company_path(new_company)

      click_on("Deny company")
      
      
      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content(new_company.company_name + " has been denied")
      expect(source).not_to include(company_path(new_company))
    end

    scenario 'deny a job post pending on validation' do
      new_job_post = @companies.first.job_posts.create(attributes_for(:job_post))
      login_as(@admin, :scope => :user)

      visit company_job_post_path(new_job_post.company, new_job_post)

      click_on("Deny job post")

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content(new_job_post.position + " by " + new_job_post.company.company_name + " has been denied")
      expect(source).not_to include(company_job_post_path(new_job_post.company, new_job_post))
    end
  end

  context 'displaying only confirmed companies/job posts' do

    scenario 'student is searching companies' do
      new_company = create(:company)
      login_as(create(:student), :scope => :user)

      visit company_search_path

      expect(source).not_to include(company_path(new_company))
    end

    scenario 'student is searching job posts' do
      new_job_post = @companies.first.job_posts.create(attributes_for(:job_post))
      login_as(create(:student), :scope => :user)

      visit job_search_path

      expect(source).not_to include(company_job_post_path(new_job_post.company, new_job_post))
    end
  end

  

 
end