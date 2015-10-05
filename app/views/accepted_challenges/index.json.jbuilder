json.array!(@accepted_challenges) do |accepted_challenge|
  json.extract! accepted_challenge, :id, :player_id, :challenge_id, :active, :comments
  json.url accepted_challenge_url(accepted_challenge, format: :json)
end
