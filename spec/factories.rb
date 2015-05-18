require 'faker'

FactoryGirl.define do
  factory :student, class: User do |f|
    f.role "student"
    f.first_name { Faker::Name.first_name }
    f.last_name  { Faker::Name.last_name }
    f.email { "#{first_name}#{last_name}@nightswatch.com".downcase }
    f.location Faker::Address.city
    f.searching [false, true].sample
  end

  factory :company, class: User do |f|
  	f.role "company"
  	f.first_name {Faker::Name.first_name}
    f.last_name  {Faker::Name.last_name}
    f.email { "#{first_name}#{last_name}@trueking.com".downcase }
    f.location Faker::Address.city
    f.searching [false, true].sample
  end


  factory :admin, class: User do |f|
  	f.role "admin"
  	f.first_name {Faker::Name.first_name}
    f.last_name  {Faker::Name.last_name}
    f.email { "#{first_name}#{last_name}@nightswatch.com".downcase }
    f.location {Faker::Address.city}
  end

  factory :invalid_student, parent: :student do |f|
    f.role "singer"
    f. searching nil
  end

  factory :complete_student, parent: :student do |f|
    f.facebook {Faker::Internet.url}
    f.twitter {Faker::Internet.url}
    f.github {Faker::Internet.url}
    f.linkedin {Faker::Internet.url}
    f.phone {Faker::PhoneNumber.cell_phone}
    f.url {Faker::Internet.url}
  end

  factory :invalid_company, parent: :company do |f|
    f. role "singer"
    f. searching nil
  end
end