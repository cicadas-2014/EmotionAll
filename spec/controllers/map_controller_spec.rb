require 'rails_helper'
require 'spec_helper'



describe MapController do
  describe 'View index' do
    let!(:trend) { create :trend }
 	let!(:trends) { [trend, create(:trend)] }
 	trends = Trend.most_recent
 	trend = trends.shift
    it { expect(response).to be_success}
  end
end