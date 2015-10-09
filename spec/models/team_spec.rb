require 'rails_helper'

RSpec.describe Team, type: :model do
  before(:each) { @player = FactoryGirl.create(:player) }

  it 'new player should add a team and link it' do
    expect(Team.count).to eq(1)
    expect(@player.teams.count).to eq(1)
  end
end
