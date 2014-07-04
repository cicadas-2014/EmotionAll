json.array!(@tweets) do |tweet|
  json.extract! tweet, :id, :tweet, :tweetid, :retweet_count, :language, :country_code, :longitude, :latitude, :sentiment, :sentiment_score, :trend_id
  json.url tweet_url(tweet, format: :json)
end
