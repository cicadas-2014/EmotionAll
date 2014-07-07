class TrendsController < ApplicationController
  def json
    map_info = Trend.get_json_for_tweets(params[:id])
    render json: map_info.to_json
  end
end
