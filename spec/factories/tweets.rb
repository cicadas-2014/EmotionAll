# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :tweet do
    text {"MyString"}
    tweetid {1}
    retweet_count {1}
    language {"MyString"}
    country_code {"MyString"}
    longitude {1.5}
    latitude {1.5}
    sentiment {"MyString"}
    sentiment_score {1.5}
    trend_id {1}
  end
end
