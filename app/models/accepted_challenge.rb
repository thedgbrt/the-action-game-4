class AcceptedChallenge < ActiveRecord::Base
  belongs_to :challenge
  belongs_to :player

  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }
  
  def description
    challenge.description rescue 'Challenge Not Found'
  end
  
  def item_type
    challenge.try(:item_type)
  end

  def greater_than
    challenge.try(:greater_than)
  end

  def also_accepted_by
    other_accepted_challenges = challenge.accepted_challenges - [self]
    other_accepted_challenges.map{ |ac| ac.player }.compact
  end
end
