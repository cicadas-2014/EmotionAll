class MapController < ApplicationController

  def index
    @trends = Trend.all
  end


  def show
    render :partial => 'map/map', :layout => false
  end
end
