class AcceptedChallenge < ActiveRecord::Base
  belongs_to :challenge
  belongs_to :player
  
  def description
    challenge.description rescue 'Challenge Not Found'
  end

end
