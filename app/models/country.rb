class Country < ActiveRecord::Base

  def self.update_sentiments
    Country.all.each do |c|
      tweets = Tweet.where("country_code = '#{c.country_code}' and sentiment_score is not null")
      overall_sentiment = (tweets.pluck(:sentiment_score).inject(:+) / tweets.length).round(2)
      c.update_attributes(overall_sentiment: overall_sentiment)
    end
  end

  def self.new_countries
    Tweet.all.each do |t|
      Country.find_or_create_by(country_code: t.country_code)
    end
  end
end
