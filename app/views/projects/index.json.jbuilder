json.array!(@projects) do |project|
  json.extract! project, :id, :name, :team_id, :active, :commitment, :visible_to, :ancestry
  json.url project_url(project, format: :json)
end
