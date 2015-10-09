require 'rails_helper'

RSpec.describe Role, type: :model do
  before(:each) { @player = FactoryGirl.create(:player) }

  it 'new player should have 5 linked roles' do
    expect(Role.count).to eq(5)
    expect(@player.roles.count).to eq(5)
  end
end
