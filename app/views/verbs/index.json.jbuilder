json.array!(@verbs) do |verb|
  json.extract! verb, :id, :name, :description, :intensity, :creator_id, :examples, :level
  json.url verb_url(verb, format: :json)
end
