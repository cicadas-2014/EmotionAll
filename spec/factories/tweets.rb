# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :tweet do
    tweet { "Hello there, I am happy to see you all again! " }
    tweetid { 1 }
    retweet_count { 1 }
    language { "en" }
    country_code { "NG" }
    longitude { 18 }
    latitude { 20 }
    sentiment { "positive" }
    sentiment_score { 1.0 }
    trend_id { 1 }
  end
end
