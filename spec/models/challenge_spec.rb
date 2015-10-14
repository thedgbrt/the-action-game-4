require 'rails_helper'

RSpec.describe Challenge, type: :model do
  before(:each) { @challenge = FactoryGirl.create(:challenge) }

  it '#op should return correctly' do
    @challenge.update_attributes(item_type: 99)
    expect(@challenge.item).to be nil

    @challenge.update_attributes(item_type: 0)
    expect(@challenge.item).to eq 'Total Actions'

    @challenge.update_attributes(item_type: 6)
    expect(@challenge.item).to eq 'Push-ups'
  end

end
