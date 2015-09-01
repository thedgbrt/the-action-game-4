module ApplicationHelper
  
  def rand_seconds(max_minutes)
    rand(max_minutes * 60)
  end
end
