module ApplicationHelper
  
  def rand_time(max)
    minutes = rand(max)
    h = minutes % 60
    m = minutes - h * 60
    "#{h}:{m}"
  end
end
