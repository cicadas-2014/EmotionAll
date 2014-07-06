class MapController < ApplicationController

  def index
    @trends = Trend.most_recent_trends
    @recent_trends = Trend.get_random_trends
  end

  def show
    render :partial => 'map/map', :layout => false
  end
end
