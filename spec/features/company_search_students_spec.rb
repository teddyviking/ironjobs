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

  end

  scenario 'Filtering by one tag' do
  	visit student_search_path

  	fill_in('query', :with => 'node')
  	click_on('Search')

  	expect(page).to have_content('node')


  end

  # scenario 'Filtering by two tags' do

  # end

  # scenario 'Finding no results when filtering' do

  # end
end