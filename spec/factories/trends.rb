# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :trend do
    name { "World Cup" }
    woeid { 23424977 }
  end
end
