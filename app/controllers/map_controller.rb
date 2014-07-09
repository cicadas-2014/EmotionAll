class MapController < ApplicationController
  def index
    @current_trends = Trend.most_recent
  end

  def show
    render :nothing => true
  end
end
