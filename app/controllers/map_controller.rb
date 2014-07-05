class MapController < ApplicationController

  def index
    @trends = Trend.all
  end


  def show
    render :map, :layout => false
  end
end
