FactoryGirl.define do
  factory :student, class: User do
    role "student"
    first_name "John"
    last_name  "Snow"
    email { "#{first_name}#{last_name}@nightswatch.com".downcase }
    location "The Wall"
  end

  factory :company, class: User do
  	role "company"
  	first_name "Stannis"
    last_name  "Baratheon"
    email { "#{first_name}#{last_name}@trueking.com".downcase }
    location "The Wall"
  end


  factory :admin, class: User do
  	role "admin"
  	first_name "Aemon"
    last_name  "Targaryen"
    email { "#{first_name}#{last_name}@nightswatch.com".downcase }
    location "The Wall"
  end


end