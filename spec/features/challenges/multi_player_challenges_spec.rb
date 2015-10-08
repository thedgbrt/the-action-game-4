# Feature: Team
#   As a player
#   I want to take on challenges with my friends
#   So that I am more motivated and have more fun
feature 'Team Challenges' do
  pending

  # Scenario: I want to accept a challenge
  # Scenario: I want to propose a challenge to specific people to all friends
  # Scenario: I want to propose a challenge to specific people to specific people
  # Scenario: I want to be able to create either a collaboration challenge or a competition challenge


  # Scenario: Activate team
  #   Given I am a user
  #   And I have at least two team memberships
  #   When I visit the 'teams' page
  #   Then I see "About the Website"
  scenario 'I can choose my team' do
    pending
    
    visit teams_path
    expect(page).to have_content 'You need to sign in for access to this page'

    signin
    @cp = Player.last

    t1 = FactoryGirl.create(:team, name: 'FooTeam')
    t2 = FactoryGirl.create(:team, name: 'BarTeam')
    t3 = FactoryGirl.create(:team, name: 'BazTeam')

    visit teams_path
    expect(page).to have_content 'My Teams'
    expect(page).to have_content 'Other Teams'

    # expect(@cp.teams.count).to eq(0)
    # @cp.teams = [t1, t2, t3]
    # expect(@cp.teams.count).to eq(3)
    expect(@cp.current_team_id).to eq nil
    expect(page).to have_content 'FooTeam'
    expect(page).to have_content 'BarTeam'
    expect(page).to have_content 'BazTeam'

    within(:css, "tr#team-#{t1.id}") do
      click_link 'JOIN'
    end

    within(:css, "tr#team-#{t2.id}") do
      click_link 'JOIN'
    end

    within(:css, "tr#team-#{t3.id}") do
      click_link 'JOIN'
    end

    within(:css, "tr#team-#{t1.id}") do
      click_link 'ACTIVATE'
    end

    # expect(@cp.current_team_id).to eq t1.id
  end

end
