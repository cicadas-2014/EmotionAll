class Tweet < ActiveRecord::Base
	belongs_to :trend

	def analyze_sentiment
		results = AlchemyAPI.search(:sentiment_analysis, :text => self.text.delete("#").delete("&amp;")) || { type: "neutral", score: 0.0 }
		self.update_attributes(sentiment: results["type"] || "neutral",
													 sentiment_score: results["score"] || 0.0)
	end

end
