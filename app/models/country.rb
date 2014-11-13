class Country < ActiveRecord::Base
  has_many :tweets

  def self.update_sentiments
    Country.all.each do |c|
      overall_sentiment = c.tweets.average(:sentiment_score).round(2)
      c.update_attributes(overall_sentiment: overall_sentiment)
    end
  end

  # def self.new_countries
  #   Tweet.pluck(:country_code).uniq.each do |c|
  #     Country.find_or_create_by(country_code: c)
  #   end
  # end
end