class TeamMembership < ActiveRecord::Base
  belongs_to :team
  belongs_to :player
  
  validates_uniqueness_of :player_id, :scope => [:team_id], :message => "This membership is already active."

  def get_roles_from_api
    response = HTTParty.get(team.roles_api_url(api_key, external_id))
  end
end
