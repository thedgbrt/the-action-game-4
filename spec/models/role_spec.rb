require 'rails_helper'

RSpec.describe Role, type: :model do
  before(:each) { @player = FactoryGirl.create(:player) }

  it '#initialize_for(player) should add roles and link them' do
    expect(Role.count).to eq(0)
    expect(@player.roles.count).to eq(0)

    Role.initialize_for(@player)

    expect(Role.count).to eq(5)
    expect(@player.roles.count).to eq(5)
  end
end
