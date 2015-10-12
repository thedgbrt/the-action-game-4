require 'rails_helper'

RSpec.describe Player, type: :model do

  before(:each) {
    @player = FactoryGirl.create(:player)
    @team = FactoryGirl.create(:team)
  }

  subject { @player }

  it { should respond_to(:name) }

  it '#actions_count_before_2am_4am_6am should work' do
    slot = Time.zone.now.in_time_zone(@player.current_time_zone).at_beginning_of_day + 30.minutes
    puts "slot.to_date is #{slot.to_date}"

    expect(@player.todays_actions_from_grid.count).to eq(0)
    expect(@player.current_time_zone).to eq('Hawaii')
    expect(@player.actions_count_before_2am_4am_6am).to eq([0, 0, 0])
    expect(Aktion.count).to eq(0)

    slot = Time.zone.now.in_time_zone(@player.current_time_zone).at_beginning_of_day + 30.minutes
    a = FactoryGirl.create(:aktion, player_id: @player.id, team_id: @team.id, timeslot: slot)
    puts "a.timeslot is #{a.timeslot}"

    expect(Aktion.count).to eq(1)
    expect(@player.todays_actions_from_grid.count).to eq(1)
    # expect(@player.actions_before_6am(slot.to_date).count).to eq(1)
    expect(@player.actions_count_before_2am_4am_6am(slot.to_date)).to eq([1, 0, 0])
  end

  it '#persist_sound_choice should change the sound' do
    expect(@player.sound_choice).to be nil
    @player.persist_sound_choice('foo')
    expect(@player.sound_choice).to eq('foo')
  end

  it "#name should return a string" do
    expect(@player.name).to match 'Test Player'
  end

  it '#admin? should return true for admins' do
    @player.role = :admin
    expect(@player.admin?).to be true
  end

  it '#init should build 1 team with membership, 5 roles and 2 projects' do
    @player = Player.new

    expect(@player.teams.count).to eq(0)
    expect(@player.roles.count).to eq(0)
    expect(@player.projects.count).to eq(0)

    @player.save!
    results = @player.init

    expect(@player.teams.count).to eq(1)
    team = results[0]

    expect(@player.projects.count).to eq(2)
    expect(@player.roles.count).to eq(5)
  end

end
