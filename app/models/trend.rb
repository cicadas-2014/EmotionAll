class Trend < ActiveRecord::Base
	has_many :tweets

	# defaults to US trends
	def self.get_current_trends(woeid=23424977)
		new_trends = get_twitter_client.trends(woeid)
		new_trends.each do |trend|
			existing_trend = Trend.find_by(name: trend.name)
			if existing_trend
				existing_trend.update(updated_at: Time.now)
			else
				Trend.create(name: trend.name, woeid: woeid)
			end
		end
	end

	def self.

	end

	# default options are recent tweets and english language
	def get_tweets
		new_tweets = get_twitter_client.search("#{self.name}", result_type:"recent", lang: "en")
		# in the future, add logic to get a more location-diverse sample of tweets
		new_tweets.select{ |tweet| tweet.geo? }.each do |t|
			unless Tweet.find_by(text: t.text)
				Tweet.create( text: t.text,
											tweetid: t.id.to_s,
											retweet_count: t.retweet_count,
											language: t.lang,
											country_code: t.place.country_code,
											latitude: t.geo.coordinates[0],
											longitude: t.geo.coordinates[1],
											trend: self )
			end
		end
	end

	def update_tweets_sentiments
		self.tweets.each do |t|
			t.set_sentiment unless t.sentiment && t.sentiment_score
		end
	end

	def self.get_json_for_tweets(trend_id)
		trend = Trend.find(trend_id)
		json = []
		trend.tweets.each do |t|
			json << { code: t.country_code,
								value: t.get_highmap_val }
		end
		json
	end
end
