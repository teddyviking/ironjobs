# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

def create_students(number)
	number.times {|n| User.create(first_name: "John#{n+1}", 
								  last_name: "Snow#{n+1}",
								  location: "The Wall",
								  email: "johnsnow#{n+1}@nightswatch.com",
								  role: "student",
								  searching: false,
								  password: "test1234",
    							  password_confirmation: "test1234")}
end

def create_companies(number)
	number.times {|n| User.create(first_name: "Stannis#{n+1}", 
								  last_name: "Baratheon#{n+1}",
								  location: "The Wall",
								  email: "stannisbaratheon#{n+1}@trueking.com",
								  role: "company",
								  searching: false,
								  password: "test1234",
    							  password_confirmation: "test1234")}
end

def create_admin(number)
	number.times {|n| User.create(first_name: "Aemon#{n+1}", 
								  last_name: "Targaryen#{n+1}",
								  location: "The Wall",
								  email: "maesteraemon#{n+1}@nightswatch.com",
								  role: "admin",
								  password: "test1234",
    							  password_confirmation: "test1234")}
end

create_students(3)
create_companies(3)
create_admin(1)
