class MapController < ApplicationController
  def index
    @current_trends = Trend.most_recent
    @sample_trends = Trend.random_trends
    @past_trends = Trend.old_trends
  end

  def show
    render :partial => 'map/map', :layout => false
  end
end
