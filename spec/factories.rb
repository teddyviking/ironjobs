require 'faker'

FactoryGirl.define do
  factory :student, class: User do
    role "student"
    first_name Faker::Name.first_name
    last_name  Faker::Name.last_name
    email { "#{first_name}#{last_name}@nightswatch.com".downcase }
    location Faker::Address.city
    searching false
  end

  factory :company, class: User do
  	role "company"
  	first_name Faker::Name.first_name
    last_name  Faker::Name.last_name
    email { "#{first_name}#{last_name}@trueking.com".downcase }
    location Faker::Address.city
    searching true
  end


  factory :admin, class: User do
  	role "admin"
  	first_name Faker::Name.first_name
    last_name  Faker::Name.last_name
    email { "#{first_name}#{last_name}@nightswatch.com".downcase }
    location Faker::Address.city
  end

  factory :invalid_student, parent: :student do
    role "singer"
    searching nil
  end

  factory :invalid_company, parent: :company do
    role "singer"
    searching nil
  end
end