class Tweet < ActiveRecord::Base
	belongs_to :trend
	belongs_to :country
	before_create :set_country
	
	def analyze_sentiment
		results = AlchemyAPI.search(:sentiment_analysis, :text => self.text.delete("#").delete("&amp;")) || { type: "neutral", score: 0.0 }
		self.update_attributes(sentiment: results["type"] || "neutral",
													 sentiment_score: results["score"] || 0.0)
	end

	private

	def set_country
		self.country = Country.find_or_create_by(country_code: self.country_code)
	end
end