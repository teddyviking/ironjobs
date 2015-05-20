require 'faker'

FactoryGirl.define do
  tags = ["javascript", "rails", "css", "jquery", "node", "photoshop"]

  factory :student, class: User do |f|
    f.role "student"
    f.first_name { Faker::Name.first_name }
    f.last_name  { Faker::Name.last_name }
    f.email { "#{first_name}#{last_name}@nightswatch.com".downcase }
    f.location Faker::Address.city
    f.searching false
    f.tag_list {tags.sample(rand(1..3))}
    f.password "test1234"
    f.password_confirmation "test1234"
  end

  factory :company, class: User do |f|
  	f.role "company"
  	f.first_name {Faker::Name.first_name}
    f.last_name  {Faker::Name.last_name}
    f.email { "#{first_name}#{last_name}@trueking.com".downcase }
    f.location Faker::Address.city
    f.searching false
    f.tag_list {tags.sample(rand(1..3))}
    f.password "test1234"
    f.password_confirmation "test1234"
  end


  factory :admin, class: User do |f|
  	f.role "admin"
  	f.first_name {Faker::Name.first_name}
    f.last_name  {Faker::Name.last_name}
    f.email { "#{first_name}#{last_name}@nightswatch.com".downcase }
    f.location {Faker::Address.city}
    f.password "test1234"
    f.password_confirmation "test1234"
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
    f.role "singer"
    f.searching nil
  end

  factory :job_post do |f|
    f.company_id 4
    f.company_type "User"
    f.description {Faker::Lorem.paragraph}
    f.location {Faker::Address.city}
    f.salary {Faker::Number.number(6)}
    f.position {Faker::Name.title}
    f.contract_type {Faker::Lorem.word}
    f.tag_list {tags.sample(rand(1..3))}
  end

  factory :invalid_job_post, parent: :job_post do |f|
    f.company_id nil
    f.description nil
    f.location nil
  end

end
