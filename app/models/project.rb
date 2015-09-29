class Project < ActiveRecord::Base
  belongs_to :team
  belongs_to :parent, class_name: 'Project'
  has_many :children, class_name: 'Project', foreign_key: 'parent_id'
  has_many :aktions
  has_many :project_memberships
  has_many :players, through: :project_memberships
  belongs_to :creator, class_name: 'Project'

  def self.search(tm, playa)
    tm.projects.select{ |p| playa.committed_to(p) }
  end

  def self.initialize_for(solo_team, playa)
    return 'Already initialized' if solo_team.projects.first
    p1 = Project.create!(team_id: solo_team.id, name: 'Recurring/Maintenance', commitment: true)
    p2 = Project.create!(team_id: solo_team.id, name: 'I know how to use TheActionGame.com', commitment: false)
    playa.projects << p1
    playa.projects << p2
  end
  
  def team_project
    "#{team.name}: #{name}"
  end

  def short_team_project
    "#{team_id? ? team.short_safe : 'N/A'}/#{name}"
  end
end
