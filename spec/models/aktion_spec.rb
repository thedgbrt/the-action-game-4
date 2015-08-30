require 'rails_helper'

RSpec.describe Aktion, type: :model do
  it 'should be invalid without team_id' do
    a = FactoryGirl.build(:aktion)
    expect(a.valid?).to be false
    expect(a.errors.messages).to eq({:team_id=>["can't be blank"]})
  end

  it 'should be invalid with missing or player-duplicate timeslot' do
    t = FactoryGirl.create(:team)
    p = FactoryGirl.create(:player)
    a = FactoryGirl.build(:aktion, team_id: t.id, player_id: p.id, timeslot: nil)
    expect(a.valid?).to be false

    a.timeslot = Aktion.current_timeslot
    expect(a.save!).to be true

    b = FactoryGirl.build(:aktion, team_id: t.id, player_id: p.id, timeslot: Aktion.current_timeslot)
    expect(b.valid?).to be false
  end
end
