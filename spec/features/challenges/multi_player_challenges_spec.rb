# Feature: Team
#   As a player
#   I want to take on challenges with my friends
#   So that I am more motivated and have more fun
feature 'Team Challenges' do

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
    
    visit teams_path

  end
end
