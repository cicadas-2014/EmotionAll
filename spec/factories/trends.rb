# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :trend do
    trend { "World Cup" }
    woeid { 23424977 }
  end
end
