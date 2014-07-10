class TrendsController < ApplicationController
  def json
    map_info = Trend.map_info(params[:id])
    render json: map_info.to_json
  end

  def tweets
    trend = Trend.find(params[:id])
    tweet = trend.tweets.where(country_code: params[:country]).sample
    tweet_from_country = { text: tweet.text,
                           sentiment: tweet.sentiment_score.round(2) }
    render json: tweet_from_country.to_json
  end
end
