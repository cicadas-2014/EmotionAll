class MapController < ApplicationController
  def index
    @current_trends = Trend.most_recent
    @mapped_trend = @current_trends[0]
  end

  def show
    render :nothing => true
  end
end
