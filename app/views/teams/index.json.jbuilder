json.array!(@teams) do |team|
  json.extract! team, :id, :captain_id, :name, :description, :url, :logo_url
  json.url team_url(team, format: :json)
end
