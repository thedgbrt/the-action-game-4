require 'rails_helper'

RSpec.describe Player, type: :model do

  before(:each) { @player = FactoryGirl.create(:player) }

  subject { @player }

  it { should respond_to(:name) }

  it "#name returns a string" do
    expect(@player.name).to match 'Test Player'
  end

  it '#admin? should return true for admins' do
    @player.role = :admin
    expect(@player.admin?).to be true
  end
end
