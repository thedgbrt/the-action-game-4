# Feature: Planning
#   As a user
#   I want to plan future Actions
#   So that I can get to important but non-urgent work and organize my day/week

feature 'Aktion planning' do
  # Scenario: Create a planned Aktion
  #   Given I am a user
  #   And I sign in
  #   When I click the 'new planned' Aktion link
  #   Then I see status 'planned'
  #   And I see timeslot
  scenario 'I can create a Planned Aktion' do
    visit root_path
    signin
    p = Player.first

    t = FactoryGirl.create(:team)
    p.teams = [t]
    expect(p.teams.count).to eq(1)
    p.update_attributes(current_team_id: t.id)
  end


  # Scenario: Planned Aktions can have a date and sequence number

  # Scenario: I see a list of 1-click Planned Aktions
  
  # Scenario: Selecting a Planned Aktion opens new_aktion_path with those details

end
