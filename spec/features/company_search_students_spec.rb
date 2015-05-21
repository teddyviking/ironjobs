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

    expect(all('li').count).to eq(20)

  end

  scenario 'Filtering by one tag' do
  	@students.last.tag_list.add('node')
    @students.last.save

    visit student_search_path
  	fill_in(:query, :with => 'node')
  	click_on('Search')


  	expect(page).to have_content('node')


  end

  scenario 'Filtering by two tags separeted by ", "' do
  	@students.last.tag_list.add(['parrot', 'strawberry'])
  	@students.last.save

  	visit student_search_path

  	fill_in('query', :with => 'parrot, strawberry')
  	click_on('Search')

    expect(first('li')).to have_content('parrot')
	expect(first('li')).to have_content('strawberry')
  end

  scenario 'Finding no results when filtering' do
  	visit student_search_path
  	
  	fill_in('query', :with => 'nocilla, pegamento')
  	click_on('Search')

  	expect(page).to have_content("No student matches your search. Try again, please.")
  end
end