# Feature: Project Quick Add
#   As a user
#   I want to quickly add a project from the Aktion page, and commit to it
#   So that I can still start my Aktion as soon as possible, but have accurate projects

feature 'Project Quick Add' do
  # Scenario: Create a project and link to it
  #   Given I am a user
  #   And I sign in
  #   And I click 'Start Action' link
  #   When I click the '+project' link
  #   Then I see the project name
  #   And I have a new project
  scenario 'I can create a Project from the new Aktion page', js: true do
    pp Capybara.current_driver
    visit root_path
    signin
    p = Player.first

    click_link '=> Example Enterprises'
    expect(page).to have_content 'I freely, consciously choose to play'

    expect(p.projects.count).to eq(2)

    find_by_id('#add-project').find_link('+project').trigger('click')
#    save_and_open_screenshot

  end



end
