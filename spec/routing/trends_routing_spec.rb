require "rails_helper"

RSpec.describe TrendsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/trends").to route_to("trends#index")
    end

    it "routes to #new" do
      expect(:get => "/trends/new").to route_to("trends#new")
    end

    it "routes to #show" do
      expect(:get => "/trends/1").to route_to("trends#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/trends/1/edit").to route_to("trends#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/trends").to route_to("trends#create")
    end

    it "routes to #update" do
      expect(:put => "/trends/1").to route_to("trends#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/trends/1").to route_to("trends#destroy", :id => "1")
    end

  end
end
