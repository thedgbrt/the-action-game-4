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

  serialize :preferences, Hash, %w(current_team_id sound_choice)

  enum role: [:user, :vip, :admin]
  after_initialize :set_default_role, :if => :new_record?

  has_many :aktions  
  has_many :teams_created, foreign_key: :creator_id

  has_many :team_memberships
  has_many :teams, through: :team_memberships
  has_many :project_memberships
  has_many :projects, through: :project_memberships
  has_many :role_assignments
  has_many :roles, through: :role_assignments

  def actions
    aktions
  end

  # start with the player's aktions, sorted by timeslot DESC
  # filter out Aktions with duplicate summaries
  # return latest 5
  def previous_actions
    previous_aktions_hash = aktions.order('timeslot DESC').first(10).group_by{ |a| a.summary }
    previous_aktions_hash.keys.map{ |key| previous_aktions_hash[key].first }.sort_by{ |a| a.timeslot}.reverse
  end

  def todays_actions
    aktions.select{ |a| a.timeslot.to_date == DateTime.now.to_date }
  end

  def todays_breaths
    todays_actions.map{ |a| a.breaths.to_i}.compact.sum
  end

  def active_roles(team)
    roles.to_set.intersection(team.roles.to_set)
  end

  def has_role(role)
    roles.include?(role)
  end

  def admin?
    role == 'admin'
  end

  def first_name
    name.split(' ').first
  end

  def gravatar(size = 24)
    gravatar_id = Digest::MD5.hexdigest(email.downcase) unless email.blank?
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}&d=monsterid"
  end

  def init
    team = Team.initialize_for(self)
    return team if team.is_a? String
    [
      team,
      Role.initialize_for(team),
      Project.initialize_for(team)
    ]
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
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      if auth['info']
        user.name = auth['info']['name'] || ""
        user.email = auth['info']['email'] || ""
      end
    end
  end
end
