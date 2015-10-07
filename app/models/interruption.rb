class Interruption < ActiveRecord::Base
  belongs_to :aktion
  
  def external
    !internal
  end

  def unrecovered
    !recovered
  end
end
