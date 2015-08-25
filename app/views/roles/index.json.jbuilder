json.array!(@roles) do |role|
  json.extract! role, :id, :name, :team_id, :url
  json.url role_url(role, format: :json)
end
