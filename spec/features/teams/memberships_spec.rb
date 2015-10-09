# Feature: Team
#   As a user
#   I want to easily determine my team memberships and current team
#   So that I can clarify my work
feature 'Team Memberships' do

  # Scenario: Activate team
  #   Given I am a user
  #   And I have at least two team memberships
  #   When I visit the 'teams' page
  #   Then I see "About the Website"
  scenario 'I can choose my team' do
    
    visit teams_path
    expect(page).to have_content 'You need to sign in for access to this page'

    signin
    cp = Player.last

    t1 = FactoryGirl.create(:team, name: 'FooTeam')
    t2 = FactoryGirl.create(:team, name: 'BarTeam')

    visit teams_path
    expect(page).to have_content 'My Teams'
    expect(page).to have_content 'Other Teams'

    expect(cp.teams.count).to eq(1)
    expect(page).to have_content 'FooTeam'
    expect(page).to have_content 'BarTeam'

    within(:css, "tr#team-#{t1.id}") do
      click_link 'JOIN'
      expect(cp.teams.count).to eq(2)
    end
  end

end
