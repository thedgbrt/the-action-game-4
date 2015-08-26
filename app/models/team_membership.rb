class TeamMembership < ActiveRecord::Base
  belongs_to :team
  belongs_to :player
  
  validates_uniqueness_of :player_id, :scope => [:team_id], :message => "This membership is already active."
end
