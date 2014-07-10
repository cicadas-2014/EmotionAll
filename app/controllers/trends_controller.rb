class TrendsController < ApplicationController
  def json
    map_info = Trend.map_info(params[:id])
    render json: map_info.to_json
  end
end

