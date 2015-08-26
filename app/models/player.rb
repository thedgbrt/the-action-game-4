class Player < ActiveRecord::Base
  enum role: [:user, :vip, :admin]
  after_initialize :set_default_role, :if => :new_record?

  has_many :aktions  
  has_many :teams, foreign_key: :creator_id
  has_many :team_memberships
  has_many :teams, through: :team_memberships

  def roles
    return [] unless teams.first
    return teams.first.roles unless teams[1]
    teams.map(&:roles).map(&:+)
  end

  def projects
    return [] unless teams.first
    return teams.first.projects unless teams[1]
    teams.map(&:projects).map(&:+)
  end

  def admin?
    role == 'admin'
  end

  def gravatar(size = 24)
    gravatar_id = Digest::MD5.hexdigest(email.downcase) unless email.blank?
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}&d=monsterid"
  end

  def init(team_name)
    t = teams.build(creator_id: id, name: team_name)
    t.add(self)
    p1 = t.projects.build(name: "Happiness")
    p2 = t.projects.build(name: "Maintenance")
    r1 = t.roles.build(name: "CEO")
    r2 = t.roles.build(name: "CFO")
    r3 = t.roles.build(name: "Court Jester")
    [t, p1, p2, r1, r2, r3]
  end

  def set_default_role
    if Player.count == 0
      self.role ||= :admin
    else
      self.role ||= :user
    end
  end

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      if auth['info']
        user.name = auth['info']['name'] || ""
        user.email = auth['info']['email'] || ""
      end
      user.init((user.name || 'No Name') + ' Enterprises')
    end
  end
end
