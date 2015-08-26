require 'rails_helper'

RSpec.describe Player, type: :model do

  before(:each) { @player = FactoryGirl.create(:player) }

  subject { @player }

  it { should respond_to(:name) }

  it "#name should return a string" do
    expect(@player.name).to match 'Test Player'
  end

  it '#admin? should return true for admins' do
    @player.role = :admin
    expect(@player.admin?).to be true
  end

  it '#init should build 1 team with membership, 1 role and 2 projects' do
    player = Player.new

    expect(player.teams.count).to eq(0)
    expect(player.roles.count).to eq(0)
    expect(player.projects.count).to eq(0)

    results = player.init
    player.save!

    expect(player.teams.count).to eq(1)
    team = results[0]
    pp team
    pp team.persisted?
    pp results
    pp team.id
    expect(player.projects.count).to eq(2)
    expect(player.roles.count).to eq(3)
  end

end
