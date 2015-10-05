class Challenge < ActiveRecord::Base
  has_many :accepted_challenges
  has_many :players, through: :accepted_challenges
end
