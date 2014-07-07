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

	# default options are recent tweets and english language
	def get_tweets  # gets tweets connected to a trend
		get_twitter_client.search("#{self.name}", result_type:"recent", lang: "en").attrs[:statuses]
		# in the future, add logic to get a more location-diverse sample of tweets
	end

	def create_tweets
		new_tweets = get_tweets
		new_tweets.select{ |tweet| tweet[:geo] != nil }.each do |t|
			unless Tweet.find_by(tweetid: t[:id_str])
				if t[:place]
					if t[:geo]
						Tweet.create(text: t[:text],
											 	 tweetid: t[:id_str],
										 		 retweet_count: t[:retweet_count],
									 			 language: t[:lang],
								 				 country_code: t[:place][:country_code],
												 latitude: t[:geo][:coordinates][0],
					 	  					 longitude: t[:geo][:coordinates][1],
						  					 trend: self)
					else
						Tweet.create(text: t[:text],
											 	 tweetid: t[:id_str],
										 		 retweet_count: t[:retweet_count],
									 			 language: t[:lang],
								 				 country_code: t[:place][:country_code],
						  					 trend: self)
					end
				end
			end
		end
	end

	def update_tweets_sentiments
		self.tweets.each do |t|
			t.set_sentiment unless t.sentiment && t.sentiment_score
		end
	end

	def self.most_recent_trends
		Trend.order(updated_at: :desc).take(10)
	end

	def self.most_recent_names_array
		most_recent_trends.map{|t| t.name}
	end

	def find_own_tweets
		longest_word = self.name.split(" ").group_by(&:size).max.last.first # doesn't work well for common words like today
		own_tweets = Tweet.where("text ILIKE (?)", "%#{longest_word}%").where(trend: nil)
		own_tweets.each do |t|
			t.update_attributes(trend: self)
		end
	end

	def self.update_tweets 
		self.most_recent_trends.each do |trend|
			trend.create_tweets # uses REST API to get most recent 100 tweets of a given trend
			trend.find_own_tweets # for tweets that were saved using the Streaming API
			trend.update_tweets_sentiments # makes Alchemy API calls if tweet doesn't have sentiments
		end
	end

	def self.get_json_for_tweets(trend_id)
		trend = Trend.find(trend_id)
		tweets = trend.tweets.where("sentiment != 'neutral'") # only care about positive or negative tweets
		countries = []
		json_output = []

		tweets.each do |t|
			countries << t.country_code
		end

		countries.uniq.each do |c|
			country_average = []
			tweets.select{ |t| t.country_code == c }.each do |tweet|
				country_average << tweet.sentiment_score
			end
			country_average = country_average.inject(:+) / country_average.length
			json_output << { code: c,
		        					 value: country_average }
		end

		json_output
	end

	def self.get_random_trends
		recent_trends = []
		4.times do
			trend = self.most_recent_trends.sample
			recent_trends << trend unless recent_trends.include?(trend)
		end
		recent_trends
	end

	def self.get_past_trends
		past_trends = []
		Trend.all.each { |t| past_trends << t if !self.most_recent_trends.include?(t) }
		past_trends
	end
end
