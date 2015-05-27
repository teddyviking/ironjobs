require 'rails_helper'


feature 'Company searches students' do
  background do
  	@students = []
  	20.times {|n| @students << create(:student)}
  end
  scenario 'Displaying all the students' do
    visit student_search_path

    @students.each do |student|
    	expect(page).to have_content(student.name)
    end

    expect(find('.post-search')).to have_selector('li', count: 20)

  end

  scenario 'Filtering by one tag', :js => true do
  	@students.last.tag_list.add('node')
    @students.last.save

    visit student_search_path
  	fill_in(:query, :with => 'node')
  	click_on('Search')


  	expect(page).to have_content('Filtering by: node')


  end

  scenario 'Filtering by two tags separeted by ", "', :js => true do
  	@students.last.tag_list.add(['parrot', 'strawberry'])
  	@students.last.save

  	visit student_search_path

  	fill_in('query', :with => 'parrot, strawberry')
  	click_on('Search')


    expect(page).to have_content('Filtering by: parrot strawberry') 

  end

  scenario 'Finding no results when filtering', :js => true do
  	visit student_search_path
  	
  	fill_in('query', :with => 'nocilla, pegamento')
  	click_on('Search')

  	expect(page).to have_content("Nothing found")
  end
end