json.array!(@insights) do |insight|
  json.extract! insight, :id, :text, :category, :player_id, :aktion_id
  json.url insight_url(insight, format: :json)
end
