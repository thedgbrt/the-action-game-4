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

end
