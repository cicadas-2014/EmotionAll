class MapController < ApplicationController

  def index
    @trends = Trend.all
  end
end
