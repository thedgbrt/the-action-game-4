json.array!(@aktions) do |aktion|
  json.extract! aktion, :id, :timeslot, :focus, :player_id, :verb_id, :project_id, :flow, :flow_notes, :value, :value_notes, :visible_to, :status, :intensity, :how_it_went, :time_zone, :location_id, :role_id, :properties
  json.url aktion_url(aktion, format: :json)
end
