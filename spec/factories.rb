FactoryGirl.define do
  factory :user do
    first_name "John"
    last_name  "Snow"
    email { "#{first_name}#{last_name}@nightswatch.com".downcase }
    location "The Wall"
  end
end