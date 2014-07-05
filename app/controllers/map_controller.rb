class MapController < ApplicationController

  def index
    @trends = Trend.most_recent_trends
  end


  def show
    render :partial => 'map/map', :layout => false
  end
end
