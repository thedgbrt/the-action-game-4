class Aktion < ActiveRecord::Base
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
  serialize :properties, Hash, %w(choice pushups situps wallsits breaths water snack tidy stop
    restroom stretch games friends other music change interruptions deflected distractions recovered
    declared_focus)
  enum status: [:committing, :attempting, :stopped, :reviewed]

  belongs_to :player
  belongs_to :project
  belongs_to :verb
  belongs_to :role
  belongs_to :location
  belongs_to :team
  has_many :insights

  validates :team_id, presence: true
  validates :timeslot, presence: true, uniqueness: {scope: :player_id}

  scope :by_timeslot, -> { order('timeslot DESC') }

  def self.count_by(actions, resource_name)
    
  end

  def in_date_range(starting_on, ending_on)
    if starting_on == ending_on
      timeslot.to_date == starting_on
    else
      timeslot.to_date >= starting_on && timeslot.to_date <= ending_on
    end
  end

  def break_activities_recorded
    stop || restroom || water || snack || stretch || tidy || games || friends || music || change ||
      pushups || situps || breaths
  end

  def color
    team.color(player)
  end

  def score
    return 0 if new_record?
    time_delta = (created_at - timeslot).abs/60
    if time_delta > 30
      1
    elsif time_delta > 5 || choice != '1' || obstacles > 0
      3
    else
      reported = [0, 1, 3, 6, 8, 10][intensity.to_i]
      [reported, 6].max
    end
  end

  def obstacles
    interruptions.to_i + distractions.to_i rescue 0
  end

  def plus_score
    '+' + score.to_s
  end

  def self.get(playa, slot)
    return nil if playa.nil?
    Aktion.find_by(player_id: playa.id, timeslot: slot)
  end

  def self.current_timeslot(t = nil)
    t ||= Time.zone.now
    if t.min < 30
      t.at_beginning_of_hour
    else
      t.at_beginning_of_hour + 30.minutes
    end
  end

  def self.current_simple_time
    Aktion.current_timeslot.strftime('%b-%d %l:%m %p')
  end

  def self.current(playa=nil)
    if playa
      find_by(player_id: playa.id, timeslot: Aktion.current_timeslot)
    else
      where(timeslot: Aktion.current_timeslot)
    end
  end

  def break
    output = '😀'
    output += " ✔︎water" if water == '1'
    output += " ✔︎snack" if snack == '1'
    output += " #{pushups} push-ups" if pushups && pushups != ''
    output += " #{breaths} breaths" if breaths && breaths != ''
    !output || output == '' ? '😰 no break' : output
  end

  def flow_str
    flow.to_i > 0 ? "+#{flow}" : flow.to_s
  end

  def value_str
    value.to_i > 0 ? "+#{value}" : value.to_s
  end

  def to_do
    if status == 'committing'
      'ATTEMPT'
    elsif status == 'attempting'
      'CONFIRM'
    elsif status == 'reviewed'
      'UPDATE'
    else
      'EDIT'
    end
  end

  def action_time(timestamp)
    timestamp ||= Time.zone.now
    timestamp.strftime('%b-%d %H:%M')    
  end

  def simple_time
    return '0:00' if !timeslot
    timeslot.strftime('%b-%d %l:%m %p')
  end
  
  def self.checkmark(int)
    int == '1' ? '✔︎' : '✘'
  end

  def status_full
    return '' if !status
    if ['reviewed', 'finished'].include?(status)
      status.capitalize + (completed? ? ' ✔︎' : ' ✘')
    else
      status.capitalize
    end
  end

  def summary_hash
    {
      verb: verb.try(:name),
      role: role.try(:short_safe),
      team: team.try(:short_safe)
    }
  end

  def summary
    [
      [summary_hash[:team], summary_hash[:role]].compact.join('/'),
      summary_hash[:verb]
    ].compact.join(': ')
  end

  def summary_with_focus
    summary + ' (' + focus + ')'
  end

  def summary_to_share
    player.first_name.to_s + ' (' + [verb.try(:name), focus].join(', ') + ')'
  end

  def summary_with_time_and_focus
    simple_time + ' ' + summary_with_focus
  end
end
