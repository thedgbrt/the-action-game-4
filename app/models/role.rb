class Role < ActiveRecord::Base
  belongs_to :team
  
  def team_role
    "#{team.name}: #{name}"
  end
end
