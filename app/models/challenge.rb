class Challenge < ActiveRecord::Base
  TYPES = [
    ['Actions', 0],
    ['Action Acores', 1],
    ['Push-ups', 2],
    ['Conscious Breaths', 3],
    ['Attempted Actions', 4],
    ['Completed Actions', 5]
  ]

  OPERATIONS = [
    ['Total', 0]
    # ['Average', 1]
  ]

  has_many :accepted_challenges
  has_many :players, through: :accepted_challenges
  belongs_to :creator, class_name: 'Player'
  
  scope :all_daily, -> { where(daily: true) } 

  def item
    Challenge::TYPES.to_h.invert[item_type] rescue 'Missing Item Type'
  end

  def op
    Challenge::OPERATIONS.to_h.invert[operation_type] rescue 'Missing Op Type'
  end

  def description
    output = item + ' ' + op
    if greater_than && less_than
      output += ' between ' + less_than.to_s + ' and ' + greater_than.to_s
    elsif greater_than
      'At least ' + greater_than.to_s + ' ' + item
    elsif less_than
      output += ' less than ' + less_than.to_s
    else
      output += ' (greater/less than missing)'
    end
  end

  def accepted_by(playa)
    AcceptedChallenge.where(player_id: playa.id, challenge_id: id)
  end
end
