class TeamMembership < ActiveRecord::Base
  belongs_to :team
  belongs_to :player
  
  validates_uniqueness_of :player_id, :scope => [:team_id], :message => "This membership is already active."

  def roles
    player.active_roles(team)
  end

  def get_roles_from_api
    response = HTTParty.get(team.roles_api_url(api_key, external_id))
  end

  def api_response
    get_roles_from_api
  end

  def my_circles
    linked = api_response["linked"]
    return [] unless linked && linked != []
    linked['circles'].map{ |c| {id: c['id'], name: c['name']} }
  end
end
