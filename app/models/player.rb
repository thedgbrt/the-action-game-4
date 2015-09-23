class Player < ActiveRecord::Base
  def self.serialize(attr_name, class_name = Object, exposed_fields = [])
    super(attr_name, class_name)
    serialized_attr_accessor attr_name, exposed_fields
  end

  def self.serialized_attr_accessor(attr_name, *args)
    args.first.each do |method_name|
      eval "
        def #{method_name}
          (self[:#{attr_name}] || {})[:#{method_name}]
        end
        def #{method_name}=(value)
          self[:#{attr_name}] ||= {}
          self[:#{attr_name}][:#{method_name}] = value
        end
      "
    end
  end

  serialize :preferences, Hash, %w(current_team_id sound_choice tick_volume warning_volume
    review_before_relax commit_length)

  enum role: [:user, :vip, :admin]
  after_initialize :set_default_role, :if => :new_record?
  after_save :init

  has_many :aktions  
  has_many :teams_created, foreign_key: :creator_id

  has_many :team_memberships
  has_many :teams, through: :team_memberships
  has_many :project_memberships
  has_many :projects, through: :project_memberships
  has_many :role_assignments
  has_many :roles, through: :role_assignments
  belongs_to :first_team
  has_many :insights

  def committed_to(proj)
    true
  end

  def current_action
    a = Aktion.find_by(player_id: id, timeslot: Aktion.current_timeslot)
    a.try(:id)
  end

  def self.time_data_hash
    {
      "data-current_action" => in_action ? 'true' : 'false'
    }
  end

  def my_teams(excluded=nil)
    teams.sort_by{ |t| -actions_for_team(t).count } - [excluded]
  end

  def actions_for_team(tm)
    Aktion.where(team_id: tm.id, player_id: id)
  end

  def today
    "Today: " +
    "#{todays_actions.map{|a|a.score}.sum} Action Points " # +
 #    "#{todays_breaths} Breaths, " +
 #    "#{todays_pushups} Pushups"
  end

  def actions
    aktions
  end
  #
  # def planned_actions
  #   Aktion.planned_by(self).select{ |a| a.persisted? }
  # end

  def persist_sound_choice(sound)
    new_tick_volume = (sound == 'ticking' ? 30 : 0)
    update_attributes(sound_choice: sound, tick_volume: new_tick_volume)
  end

  # get a list of all my actions
  # 
  


  def frequent_actions_with_counts
    hash = aktions.by_timeslot.group_by{ |a| a.summary_hash }
    results = {}
    hash.each{ |k, v| results[v.first] = v.count }
    results.sort_by{ |r| -r[1] }
    @frequent_actions_with_counts ||= results
    # recents.sort_by{ |a| [a.team.try(:short) || 'None', a.role.try(:name) || 'None', a.verb.try(:name) || 'None'] }
  end

  def todays_actions(date=nil)
    aktions.select{ |a| a.persisted? && a.timeslot.in_time_zone(self.current_time_zone).to_date == Time.zone.now.in_time_zone(self.current_time_zone).to_date }
  end

  def initials
    name.split(' ').map{|w| w[0].upcase}.join
    
  end

  def self.todays_grid(tz, date=nil)
    date ||= Time.zone.now.in_time_zone(tz).to_date
    midnight = date.at_beginning_of_day
    (0..47).map{ |ts| midnight + (ts*30).minutes }
  end

  def self.weekly_grid(date=nil)
    date ||= Time.zone.now.to_date
    start = date.at_beginning_of_week.to_date
    (0..6).map{ |d| start + d.days }
  end

  def self.monthly_grid(date=nil)
    date ||= Time.zone.now.to_date
    start = date.at_beginning_of_month.to_date
    x = Time.days_in_month(Time.zone.now.month)
    (0..x).map{ |d| start + d.days }
  end


  def todays_breaths
    todays_actions.map{ |a| a.breaths.to_i}.compact.sum
  end

  def todays_pushups
    todays_actions.map{ |a| a.pushups.to_i}.compact.sum
  end

  def active_roles(team=nil)
    return roles if team == nil
    roles.to_set.intersection(team.roles.to_set) rescue []
  end

  def has_role(role)
    roles.include?(role)
  end

  def committed_to(project)
    projects.include?(project)
  end

  def admin?
    role == 'admin'
  end

  def first_name
    name.split(' ').first rescue ''
  end

  def gravatar(size = 24)
    gravatar_id = Digest::MD5.hexdigest(email.downcase) unless email.blank?
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}&d=monsterid"
  end

  def init
    team = Team.initialize_for(self)
    Role.initialize_for(team, self)
    Project.initialize_for(team, self)
  end

  def review_first
    true  #TODO: implement option
  end

  def set_default_role
    if Player.count == 0
      self.role ||= :admin
    else
      self.role ||= :user
    end
  end

  def self.sound_choices(current=nil)
    all = ['music', 'ticking', 'nature', 'silence']
    return all if !current
    all - [current.downcase]
  end

  def self.create_with_omniauth(auth)
    create! do |player|
      player.provider = auth['provider']
      player.uid = auth['uid']
      if auth['info']
        player.name = auth['info']['name'] || ""
        player.email = auth['info']['email'] || ""
      end
    end
  end
end
