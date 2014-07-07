class MapController < ApplicationController
  def index
    @current_trends = Trend.most_recent_trends
    @sample_trends = Trend.get_random_trends
    @past_trends = Trend.get_past_trends
  end

  def show
    render :partial => 'map/map', :layout => false
  end
end
