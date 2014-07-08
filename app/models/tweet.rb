class Tweet < ActiveRecord::Base
	belongs_to :trend

	def get_sentiment
		AlchemyAPI.search(:sentiment_analysis, :text => self.text.delete("#").delete("&amp;"))
	end

	def set_sentiment
		results = get_sentiment || { type: "neutral", score: 0.0 }
		self.update_attributes(sentiment: results["type"] || "neutral",
													 sentiment_score: results["score"] || 0.0)
	end

	def self.country_sentiment(country_code)
		tweets = Tweet.where("country_code = '#{country_code}' and sentiment_score is not null")
		(tweets.pluck(:sentiment_score).inject(:+) / tweets.length).round(4)
	end
end
