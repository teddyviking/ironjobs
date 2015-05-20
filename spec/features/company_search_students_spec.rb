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
  	visit student_search_path

  	fill_in('query', :with => 'node')
  	click_on('Search')

  	expect(page).to have_content('node')


  end

  scenario 'Filtering by two tags separeted by ", "' do
  	visit student_search_path

  	fill_in('query', :with => 'node, javascript')
  	click_on('Search')

  	
    expect(first('li')).to have_content('node')
	expect(first('li')).to have_content('javascript')
 
  
  end

  # scenario 'Finding no results when filtering' do

  # end
end