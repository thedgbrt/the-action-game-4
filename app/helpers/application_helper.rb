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

  def sidebars?
    return true if current_player && current_player.show_sidebars == '1'
    false
  end
  
  def insights?
    return true if current_player && current_player.show_insights == '1'
    false
  end
  
  def simple_rubric?
    current_player && current_player.show_rubric == '1'
  end
  
  def full_rubric?
    current_player && current_player.show_rubric == '2'
  end
end
