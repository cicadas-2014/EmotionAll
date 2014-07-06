require 'rails_helper'
require 'spec_helper'


feature "Trend List management" do
  # let!(:trend) {Trend.create(name: "World Cup", woeid: 23424977)}
  scenario "User clicks on a trend", :js => true do
  visit map_path
   # wait_for_ajax_to_finish
   # wait_for_ajax
   expect(page).to have_content ("about")
 end
end

# describe "Map" do
#   describe "User can view map" do
#     it "by visiting homepage" do
#       visit map_url
#       expect(page).to have_css("#map-container")
#     end
#   end
#   describe "User can see a trends list" do
#     it "by visiting the home page"  do
#       visit map_url
#       expect(page).to have_content("Pick a trend")
#       expect(page).to have_css('.trend-list')
#     end
#   end
#   describe "User can click on a trend" do
#     it "when viewing the trends list" do
#       visit map_url
#       expect(page).to have_content(trend.trend) # refers to factory
#     end
#   end
#   describe "User can read about map data" do
#     it "by clicking on about link" do
#       visit map_url
#       click('About')
#       expect(page).to have_content('About EmotionAll')
#     end

#   end
# end



