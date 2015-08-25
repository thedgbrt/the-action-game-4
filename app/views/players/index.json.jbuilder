json.array!(@players) do |player|
  json.extract! player, :id, :name, :provider, :uid, :role, :email, :fictional, :current_time_zone
  json.url player_url(player, format: :json)
end
