class Friendship < ActiveRecord::Base
  belongs_to :requester, class_name: 'Player'
  belongs_to :accepter, class_name: 'Player'
end
