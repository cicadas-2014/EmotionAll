class MapController < ApplicationController
  def index
    @current_trends = Trend.most_recent
  end

  def show
    render :partial => 'map/map', :layout => false
  end
end
