class Role < ActiveRecord::Base
  belongs_to :team
  belongs_to :parent, class_name: 'Role'
  has_many :children, class_name: 'Role', foreign_key: 'parent_id'

  def self.initialize_for(solo_team)
    return 'Roles already initialized' if solo_team.roles.first
    [
      solo_team.roles.create!(name: 'Fearless Leader', description: 'Chooses vision and strategy, does everything else that another role has not yet been created for'),
      solo_team.roles.create!(name: 'Director of Finance', description: 'Budgets, pays the bills'),
      solo_team.roles.create!(name: 'Executive Assistant', description: 'Triages e-mail, schedules events, maintains everything'),
      solo_team.roles.create!(name: 'Lifelong Student', description: 'Explores and learns new things'),
      solo_team.roles.create!(name: 'Court Jester', description: 'Helps everyone to enjoy life more'),      
    ]
  end
  
  def team_role
    "#{team.name}: #{name}"
  end
end
