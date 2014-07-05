class TrendsController < ApplicationController
	def index
    @trends = Trend.all
	end

end
