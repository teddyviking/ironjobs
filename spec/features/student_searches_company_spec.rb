require 'rails_helper'


feature 'Student searches companies' do
  background do
    @companies = []
    20.times {|n| @companies << create(:company)}
    @companies.map{|company| company.update(confirmed:"confirmed")}
  end
  scenario 'Displaying all the companies' do
    visit company_search_path

    @companies.each do |company|
      expect(source).to include(company_path(company))
    end

    expect(find('.post-search')).to have_selector('li', count: 20)

  end

  scenario 'Filtering by one tag', :js => true do
    @companies.last.tag_list.add('node')
    @companies.last.save

    visit company_search_path
    fill_in(:query, :with => 'node')
    click_on('Search')


    expect(page).to have_content('Filtering by: node')


  end

  scenario 'Filtering by two tags separeted by ", "', :js => true do
    @companies.last.tag_list.add(['parrot', 'strawberry'])
    @companies.last.save

    visit company_search_path

    fill_in('query', :with => 'parrot, strawberry')
    click_on('Search')

    expect(page).to have_content('Filtering by: parrot strawberry')
  end

  scenario 'Finding no results when filtering', :js => true do
    visit company_search_path
    
    fill_in('query', :with => 'nocilla, pegamento')
    click_on('Search')

    expect(page).to have_content("Nothing found")
  end
end