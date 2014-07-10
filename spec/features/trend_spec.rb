require 'spec_helper'
require 'rails_helper'

feature 'Top Header Management' do 
  describe'Trend' do
    it "has a valid factory" do 
      expect(FactoryGirl.build(:trend)).to be_valid
    end
  end
  let!(:trend) { create :trend }
  let!(:trends) { [trend, create(:trend)] }
  scenario "User can click on About Button" do
      visit root_path
      click_button("About")
      expect(page.status_code).to be(200)
  end
end


feature 'Trend List' do
  let!(:trend) { create :trend }
  let!(:trends) { [trend, create(:trend)] }
  scenario "User can see current trends list" do
      @current_trends = trends
      visit root_path
      expect(page).to have_content("popular Twitter trend")
  end
  # scenario "User can click on Current Trends Link" do
  #     @current_trends = trends
  #     @past_trends = trends
  #     visit root_path
  #     click_link("Current Trends")
  #     expect(page.status_code).to be(200)
  # end
  # scenario "User can click on Creators Link" do
  #     @current_trends = trends
  #     @past_trends = trends
  #     visit root_path
  #     click_link("Creators")
  #     expect(page.status_code).to be(200)
  # end
end


