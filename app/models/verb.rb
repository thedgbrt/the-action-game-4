class Verb < ActiveRecord::Base
  belongs_to :creator, class_name: 'Player'
end
