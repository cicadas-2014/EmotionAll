class TrendsController < ApplicationController
  def json
    map_info = Rails.cache.read('cache').map_info[params[:id].to_i]
    render json: map_info.to_json
  end
end
