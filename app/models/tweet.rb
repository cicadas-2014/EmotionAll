class Tweet < ActiveRecord::Base
	belongs_to :trend

	def get_sentiment
		AlchemyAPI.search(:sentiment_analysis, :text => self.text.delete("#"))
	end

	def set_sentiment
		results = get_sentiment
		self.update_attributes( sentiment: results["type"],
														sentiment_score: results["score"] )
	end

	def get_highmap_val
		( ( self.sentiment_score + 1 ) / 2 * 101 ).round
	end
end
