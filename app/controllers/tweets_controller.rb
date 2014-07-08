class TweetsController < ApplicationController
  def json
    map_info = Trend.overall_country_sentiment
    render json: map_info.to_json
  end
end
