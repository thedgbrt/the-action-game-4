FactoryGirl.define do
  factory :aktion do
    timeslot "2015-08-25 12:00:00"
    focus "MyString"
    player_id 1
    verb_id 1
    project_id 1
    flow 1
    flow_notes "MyText"
    value 1
    value_notes "MyText"
    visible_to 1
    intensity 1
    how_it_went "MyText"
    time_zone "MyString"
    location_id 1
    role_id 1
  end

end
