class Team < ActiveRecord::Base
  has_many :roles, dependent: :destroy
  has_many :projects, dependent: :destroy
  has_many :team_memberships, dependent: :destroy
  has_many :players, through: :team_memberships
  belongs_to :creator, foreign_key: 'creator_id', class_name: 'Player'

  default_scope { order(:updated_at) }

  def add(playa)
    tm = team_memberships.build(player_id: playa.id)
    tm ? {notice: 'Successfully added you to this team'} : {alert: 'Unable to add you to this team'}
  end

  def self.initialize_for(player)
    return 'First team already exists' if player.teams.first
    player.teams.create!(name: player.name.to_s + ' Enterprises')
  end

  def remove(playa)
    tm = TeamMembership.where(player_id: playa.id, team_id: self.id).first
    return {notice: 'Team Membership not found'} unless tm
    tm.destroy ? {notice: 'Successfully removed you from this team'} : {alert: 'Unable to remove you from this team'}
  end

  def self.last_active_or_create(user)
    user.teams.last || Team.create(creator_id: user.id, name: user.name.split(' ').first.to_s + ' Corporation')
  end
  
end