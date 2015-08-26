class Aktion < ActiveRecord::Base
  class Properties
    include ActiveModel::Conversion
    extend ActiveModel::Naming

    attr_accessor :drank_water, :conscious_breaths, :pushups

    def persisted?; true end
    def id; 1 end

    def self.load json
      obj = self.new
      unless json.nil?
        attrs = JSON.parse json
        obj.twitter_handle = attrs['twitter_handle']
        obj.location = attrs['location']
      end
      obj
    end

    def self.dump obj
      obj.to_json if obj
    end
  end
  serialize :properties, Properties

  belongs_to :player
  belongs_to :project
  belongs_to :verb
  belongs_to :role
  belongs_to :location

  def self.current_timeslot(t = nil)
    t ||= Time.zone.now
    if t.min < 30
      t.at_beginning_of_hour
    else
      t.at_beginning_of_hour + 30.minutes
    end
  end

  def self.intensities
    [ ['1 - Quasi Action', 1],
      ['2 - Split Focus', 2], 
      ['3 - Maintenance', 3],
      ['4 - Important', 4],
      ['5 - Urgent', 5]]
  end
end
