# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

def create_students(number)
	students = []
	number.times {|n| students << User.create(first_name: Faker::Name.first_name, 
								  last_name: Faker::Name.last_name,
								  location: Faker::Address.city,
								  email: Faker::Internet.email,
								  role: "student",
								  searching: false,
								  password: "test1234",
    							  password_confirmation: "test1234")}
	students
end

def create_companies(number)
	companies = []
	number.times {|n| companies << User.create(first_name: Faker::Name.first_name, 
								  last_name: Faker::Name.last_name,
								  location: Faker::Address.city,
								  email: Faker::Internet.email,
								  role: "company",
								  searching: false,
								  company_name: Faker::Company.name,
								  situation: "growing",
								  description: Faker::Lorem.paragraph,
								  password: "test1234",
    							  password_confirmation: "test1234")}
	companies
end

def create_admin(number)
	admin = []
	number.times {|n| admin << User.create(first_name: Faker::Name.first_name, 
								  last_name: Faker::Name.last_name,
								  location: Faker::Address.city,
								  email: Faker::Internet.email,
								  role: "admin",
								  password: "test1234",
    							  password_confirmation: "test1234")}
	admin
end

def create_job_posts(number, company)
	number.times {|n| JobPost.create( company_id: company.id,
    								company_type: "User",
    								description: Faker::Lorem.paragraph,
    								location: Faker::Address.city,
    								salary: Faker::Number.number(6),
    								position: Faker::Name.title,
    								contract_type: Faker::Lorem.word )}
end

students = create_students(3)
companies = create_companies(3)
admin = create_admin(1)
job_posts = companies.each{|company| create_job_posts(3, company)}
