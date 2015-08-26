class Project < ActiveRecord::Base
  belongs_to :team
  
  def team_project
    "#{team.name}: #{name}"
  end
end
