require 'rails_helper'


feature 'Student searches companies' do
  background do
  	@companies = []
  	20.times {|n| @companies << create(:company)}
  end
  scenario 'Displaying all the companies' do
    visit company_search_path

    @companies.each do |company|
    	expect(page).to have_content(company.company_name)
    end

    expect(find('.post-search')).to have_selector('li', count: 20)

  end

  scenario 'Filtering by one tag' do
  	@companies.last.tag_list.add('node')
    @companies.last.save

    visit company_search_path
  	fill_in(:query, :with => 'node')
  	click_on('Search')


  	expect(page).to have_content('node')


  end

  scenario 'Filtering by two tags separeted by ", "' do
  	@companies.last.tag_list.add(['parrot', 'strawberry'])
  	@companies.last.save

  	visit company_search_path

  	fill_in('query', :with => 'parrot, strawberry')
  	click_on('Search')

    expect(find('.post-search')).to have_content('parrot')
    expect(find('.post-search')).to have_content('strawberry')
  end

  scenario 'Finding no results when filtering' do
  	visit company_search_path
  	
  	fill_in('query', :with => 'nocilla, pegamento')
  	click_on('Search')

  	expect(page).to have_content("No company matches your search. Try again, please.")
  end
end