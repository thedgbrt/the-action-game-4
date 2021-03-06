class Role < ActiveRecord::Base
  belongs_to :team
  belongs_to :parent, class_name: 'Role'
  has_many :children, class_name: 'Role', foreign_key: 'parent_id'
  has_many :aktions
  has_many :role_assignments
  has_many :players, through: :role_assignments

  validates :team_id, presence: true

  def last_energized
    last_action_started || updated_at
  end

  def last_action_started
    aktions.map(&:timeslot).max
  end

  def self.initialize_for(solo_team, playa)
    return 'Roles already initialized' if playa.roles.first
    new_roles = [
      solo_team.roles.create!(name: 'Fearless Leader', description: 'Chooses vision and strategy, does everything else that another role has not yet been created for'),
      solo_team.roles.create!(name: 'Director of Finance', description: 'Budgets, pays the bills'),
      solo_team.roles.create!(name: 'Executive Assistant', description: 'Triages e-mail, schedules events, maintains everything'),
      solo_team.roles.create!(name: 'Lifelong Student', description: 'Explores and learns new things'),
      solo_team.roles.create!(name: 'Court Jester', description: 'Helps everyone to enjoy life more'),
    ]
    playa.roles = new_roles
  end

  def short_safe
    short || name
  end
  
  def team_role
    "#{team.name}: #{name}"
  end

  def short_team_role
    "#{team.short_safe}/#{name}"
  end

  def name_with_parent
    parent_id ? "#{parent.name_with_parent}/#{name}" : name
  end

  def name_with_short_parent
    parent_id ? "#{parent.short_name_with_short_parent}/#{name}" : name
  end

  def short_name_with_short_parent
    parent_id ? "#{parent.short_name_with_short_parent}/#{short}" : short
  end
end
