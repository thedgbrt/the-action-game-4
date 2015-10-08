class Challenge < ActiveRecord::Base
  TYPES = [
    ['Actions', 0],
    ['Action Scores', 1],
    ['Push-ups', 2],
    ['Conscious Breaths', 3],
    ['+3 Actions', 4],
    ['Decent Actions', 5],
    ['Solid Actions', 6],
    ['Perfect Actions', 7]
  ]

  OPERATIONS = [
    ['Total', 0]
    # ['Average', 1]
  ]

  has_many :accepted_challenges
  has_many :players, through: :accepted_challenges
  belongs_to :creator, class_name: 'Player'
  
  scope :all_daily, -> { where(daily: true) } 

  def self.count(playa, item_type)
    if item_type == 0
      playa.todays_actions.count
    elsif item_type == 2
      playa.todays_pushups
    elsif item_type == 3
      playa.todays_breaths
    elsif item_type == 4
      playa.todays_actions.select{ |a| a.score >= 3 }.count
    elsif item_type == 5
      playa.todays_actions.select{ |a| a.score >= 6 }.count
    elsif item_type == 6
      playa.todays_actions.select{ |a| a.score >= 8 }.count
    elsif item_type == 7
      playa.todays_actions.select{ |a| a.score >= 10 }.count
    end
  end

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
