# Feature: Polling
#   As a user
#   I want to see new Aktions within 5 seconds of when they are created
#   So that I feel a sense of camraderie with other players

feature 'Aktion Polling', js: true do

  # Scenario: When a 
  #   Given I am signed in
  #   When a 'Now Aktion' with focus 'Foo Bar' gets submitted by another user
  #   Then I see 'Foo Bar'
  scenario 'I can see an Aktion created by someone else without refreshing' do
    example = FactoryGirl.create(:player, name: 'Example User', email: 'example.user@playfullyproductive.com', show_sidebars: true)
    other = FactoryGirl.create(:player, name: 'Other Player')
    signin
    pp 'Players', Player.all
    other.aktions.create!(team: other.teams.first, timeslot: Aktion.current_timeslot, focus: 'Foo Bar')
    3.times do |idx|
      sleep 1
      puts "#Sleeping {idx}..."
    end
    expect(page).to have_content('Foo Bar')
  end


end
