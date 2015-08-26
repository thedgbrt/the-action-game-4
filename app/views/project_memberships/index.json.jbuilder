json.array!(@project_memberships) do |project_membership|
  json.extract! project_membership, :id, :project_id, :player_id, :active, :owner
  json.url project_membership_url(project_membership, format: :json)
end
