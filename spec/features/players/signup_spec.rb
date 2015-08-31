# Feature: Signup
#   As a visitor
#   I want to sign up
#   So that I can play
feature 'Player signup' do

  # Scenario: Activate team
  #   Given I am a visitor
  #   When I visit the 'teams' page
  #   And I click the 'sign up' page
  #   Then I see 'signed in'
  scenario 'I can sign up' do
    visit root_path
    expect(Player.count).to eq(0)
    expect(page).to have_content 'Sign in with Google'

    signin

    expect(page).to have_content 'Signed in'
    expect(Player.count).to eq(1)
  end

end
