require 'spec_helper'
require 'rails_helper'

feature 'Top Header Management' do 
  background do 
  end
  scenario 'shows the about page content' do
    visit about_path
    expect(page).to have_content 'wonder'
  end
  describe'Trend' do
    it "has a valid factory" do 
      expect(FactoryGirl.build(:trend)).to be_valid
    end
  end
end
#     describe'Trend' do
#     it "has a valid factory" do 
#       expect(FactoryGirl.build(:trend)).to be_valid
#     end
#   end



feature 'Trend List' do
  let!(:trend) { create :trend }
  let!(:trends) { [trend, create(:trend)] }
  scenario "User can see current trends list" do
      @current_trends = trends
      @sample_trends = trends
      @past_trends = trends
      visit root_path
      # click_link("Trends")
      expect(page).to have_content("Popular Trends")
  end
end



# feature 'Map Page', :js => true do
#   let!(:trend) { create :trend }
#   let!(:tweet) { create :tweet }

#   scenario 'user can view a world map' do
#     visit map_path
#     click_button trend.name
#     wait_for_ajax_to_finish
#     expect(page).to have_css("#map-container")
#   end

# end
