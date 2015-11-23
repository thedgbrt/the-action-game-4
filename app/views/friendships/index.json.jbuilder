json.array!(@friendships) do |friendship|
  json.extract! friendship, :id, :requester_id, :accepter_id
  json.url friendship_url(friendship, format: :json)
end
