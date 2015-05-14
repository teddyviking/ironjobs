FactoryGirl.define do
  factory :user do
    name "John"
    last_name  "Snow"
    email { "#{name}#{last_name}@nightswatch.com".downcase }
    location "The Wall"
  end
end