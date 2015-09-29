# Feature: Project Quick Add
#   As a user
#   I want to quickly add a project from the Aktion page, and commit to it
#   So that I can still start my Aktion as soon as possible, but have accurate projects

feature 'Project Quick Add' do
  # Scenario: Create a project and commit to it
  #   Given I am a user
  #   And I sign in
  #   And I click 'Start Action' link
  #   When I click the '+project' link
  #   Then I see the project name
  #   And I have a new project
  scenario 'I can create a Project from the new Aktion page', js: true do
    visit root_path
    signin

    sleep 2
    @team = Team.first
    @player = Player.first

    visit new_aktion_path(team_id: @team.id)

    expect(page).to have_content CHOICE
    expect(page).to have_content '+project'
    expect(@player.projects.count).to eq(2)
    expect(@team.projects.count).to eq(2)

    click_link '+project'
    page.driver.browser.switch_to.alert.accept

    expect(page).to have_content 'Outcome Achieved?'
    expect(@player.projects.count).to eq(3)
    expect(@team.projects.count).to eq(3)
  end

end
