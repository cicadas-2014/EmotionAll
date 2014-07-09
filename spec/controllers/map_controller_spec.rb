require 'rails_helper'
require 'spec_helper'



  # def setup
  #   @controller = MapController.new
  # end


describe 'Get #show' do 
	# @controller = MapController.new 
	it "renders the show template" do 
		get :show
		expect(response).to render_template :show
	end
end