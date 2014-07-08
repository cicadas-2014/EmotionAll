class Tweet < ActiveRecord::Base
	belongs_to :trend

	def analyze_sentiment
		results = AlchemyAPI.search(:sentiment_analysis, :text => self.text.delete("#").delete("&amp;")) || { type: "neutral", score: 0.0 }
		self.update_attributes(sentiment: results["type"] || "neutral",
													 sentiment_score: results["score"] || 0.0)
	end

	def self.country_sentiment(country_code)
		tweets = Tweet.where("country_code = '#{country_code}' and sentiment_score is not null")
		(tweets.pluck(:sentiment_score).inject(:+) / tweets.length).round(4)
	end

	def self.overall_country_sentiment
		output = []

		Tweet.pluck(:country_code).uniq.each do |country_code|
			output << { code: country_code,
									value: Tweet.country_sentiment(country_code) }
		end

		output
	end
end
