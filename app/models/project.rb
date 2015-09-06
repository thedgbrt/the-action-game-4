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

  def self.initialize_for(solo_team)
    return 'Already initialized' if solo_team.projects.first
    [
      solo_team.projects.create!(name: 'Recurring/Maintenance', commitment: true),
      solo_team.projects.create!(name: 'I know how to use TheActionGame.com', commitment: false)      
    ]
  end
  
  def team_project
    "#{team.name}: #{name}"
  end

  def short_team_project
    "#{team_id? ? team.short_safe : 'N/A'}: #{name}"    
  end
end
