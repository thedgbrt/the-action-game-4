# Feature: Intensities
#   As a user
#   I want to track intensity of my Actions
#   So that I can be incentivized to play the game well, but in a playful non-judgmental way

feature 'Aktion Intensity' do
  # Scenario: Aktions created outside the right time frame have intensity 1
  #   Given I am a user
  #   And I sign in
  #   When I click the 'new planned' Aktion link
  #   Then I see status 'planned'
  #   And I see timeslot
  scenario 'I can create a Planned Aktion' do
  end


  # Scenario: Missed or abandoned Aktions (aka non-reviewed) have intensity 2 (if started within the right time frame)

  # Scenario: Reviewed Aktions have intensity 3 if date created is not within 3 min of time slot
  
  # Scenario: Reviewed Timely Aktions with no break info get intensity 4
  
  # Scenario: Reviewed Timely Aktions with break info get intensity 5

end
