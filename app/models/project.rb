class Project < ActiveRecord::Base
  belongs_to :team
  belongs_to :parent, class_name: 'Project'
  has_many :children, class_name: 'Project', foreign_key: 'parent_id'
  has_many :aktions

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
end
