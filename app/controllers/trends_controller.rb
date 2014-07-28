class TrendsController < ApplicationController
  def json
    map_info = Rails.cache.read('cache').map_info[params[:id].to_i] || Trend.map_info(params[:id])
    render json: map_info.to_json
  end
end