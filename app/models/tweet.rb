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

	def get_highmap_val
		((self.sentiment_score + 1) / 2 * 101).round
	end
end
