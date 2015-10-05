class Challenge < ActiveRecord::Base
  TYPES = [
    ['Actions', 0],
    ['Action Scores', 1],
    ['Push-ups', 2],
    ['Breaths', 3],
    ['Attempted Actions', 4],
    ['Successful Actions', 5]
  ]

  OPERATIONS = [
    ['Sum', 0],
    ['Average', 1]
  ]

  has_many :accepted_challenges
  has_many :players, through: :accepted_challenges
  belongs_to :creator, class_name: 'Player'

  def item
    Challenge::TYPES[item_type][0] rescue 'Missing Item Type'
  end

  def op
    Challenge::OPERATIONS[operation_type][0] rescue 'Missing Op Type'
  end

  def description
    output = item + ' ' + op
    if greater_than && less_than
      output += ' between ' + less_than.to_s + ' and ' + greater_than.to_s
    elsif greater_than
      output += ' greater than ' + greater_than.to_s
    elsif less_than
      output += ' less than ' + less_than.to_s
    else
      output += ' (greater/less than missing)'
    end
  end

  def self.types
    
  end
  
  def self.operations
    
  end
end
