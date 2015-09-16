class Project < ActiveRecord::Base
  belongs_to :team
  belongs_to :parent, class_name: 'Project'
  has_many :children, class_name: 'Project', foreign_key: 'parent_id'
  has_many :aktions

  def self.for_select(tm=nil)
    projects = tm ? tm.projects : Project.all
    teams_hash = {}
    projects.each do |r|
      prev = teams_hash[r.team_id.to_s] || ''
      teams_hash[r.team_id.to_s] = prev + "\n<option value='#{r.id.to_s}'>#{r.name}</option>"
    end
    teams_hash.to_json
  end

  def self.initialize_for(solo_team, playa)
    return 'Already initialized' if solo_team.projects.first
    p1 = Project.create!(team_id: solo_team.id, name: 'Recurring/Maintenance', commitment: true)
    pp p1
    p2 = Project.create!(team_id: solo_team.id, name: 'I know how to use TheActionGame.com', commitment: false)
    pp p2
    pp 'playa.projects before', playa.projects
    playa.projects << p1
    playa.projects << p2
    pp 'playa.projects', playa.projects
  end
  
  def team_project
    "#{team.name}: #{name}"
  end

  def short_team_project
    "#{team_id? ? team.short_safe : 'N/A'}: #{name}"    
  end
end
