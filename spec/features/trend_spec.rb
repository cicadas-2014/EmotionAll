require 'spec_helper'
require 'rails_helper'

feature 'Home Page' do

  scenario 'shows the header' do
    visit map_path
    expect(page).to have_content 'EmotionAll'
    expect(page).to have_content 'About'
    expect(page).to have_content 'Github'
  end
end

feature 'Trend List', :js => true do
  let!(:trend) { create :trend }
  let!(:tweet) { create :tweet }

  scenario 'shows a list of current trends' do
    visit map_path
    expect(page).to have_content trend.name
  end

  scenario 'user can click on a trend' do
    visit map_path
    click_button trend.name
    wait_for_ajax_to_finish
    expect(response.status).to eq 200
  end
end

feature 'Map Page', :js => true do
  let!(:trend) { create :trend }
  let!(:tweet) { create :tweet }

  scenario 'user can view a world map' do
    visit map_path
    click_button trend.name
    wait_for_ajax_to_finish
    expect(page).to have_css("#map-container")
  end

end
