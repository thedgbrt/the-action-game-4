module ApplicationHelper
  
  def rand_seconds(max_minutes)
    rand(max_minutes * 60)
  end
  
  def starting_path
    if current_player.teams.count > 1
      start_aktions_path
    else
      new_aktion_path(team_id: current_player.teams.first)
    end
  end
end
