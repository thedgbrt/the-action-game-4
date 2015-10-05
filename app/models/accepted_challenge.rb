class AcceptedChallenge < ActiveRecord::Base
  belongs_to :challenge
  belongs_to :player  
end
