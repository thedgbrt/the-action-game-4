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

  serialize :properties, Hash, %w(choice pushups situps breaths water snack tidy stop restroom stretch)
  enum status: [:committing, :attempting, :reviewed, :finished]

  belongs_to :player
  belongs_to :project
  belongs_to :verb
  belongs_to :role
  belongs_to :location
  belongs_to :team

#  validate :focus_or_verb#, :must_be_at_choice, 

  def self.current_timeslot(t = nil)
    t ||= Time.zone.now
    if t.min < 30
      t.at_beginning_of_hour
    else
      t.at_beginning_of_hour + 30.minutes
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

  def to_do
    if status == :committing
      'ATTEMPT ACTION'
    elsif status == :attempting
      'CONFIRM ACTION'
    elsif status == :reviewed
      'UPDATE ACTION'
    else
      'DONE'
    end
  end

  def simple_time
    return '0:00' if !timeslot
    timeslot.strftime('%b-%d %H:%M')
  end

  def self.checkmark(int)
    int == 1 ? '✔︎' : '✘'
  end

  def status_full
    if ['reviewed', 'finished'].include?(status)
      status.capitalize + (completed? ? ' ✔︎' : ' ✘')
    else
      status.capitalize
    end
  end
  
  def summary
    focus? ? focus : 'Focus Missing'
  end

  def self.choice
    'I freely choose to play'
  end

  def self.intensities
    [ ['1 - Quasi Action', 1],
      ['2 - Split Focus', 2], 
      ['3 - Maintenance', 3],
      ['4 - Important', 4],
      ['5 - Urgent', 5]]
  end

  def self.focus_placeholder
    'Subjectively, how did you feel? Was your body comfortable? Were you able to stay focused the whole time?'
  end

  def self.focus_options
    [
      ['+3 (Amazing)', 3],
      ['+2 (Good)', 2],
      ['+1 (Decent)', 1],
      [' 0 (Neutral)', 0],
      ['-1 (Questionable)', -1],
      ['-2 (Poor)', -2],
      ['-3 (Terrible)', -3]
    ]
  end

  def self.value_placeholder
    'Objectively, what did you work on?  What did you complete or accomplish?  Is this the right strategy for your project?  Is this project a good use of your time?'
  end

  private

    def self.status_options
      # [[:committing, 0], [:attempting, 1], [:reviewed, 2], [:finished, 3]]
      [:committing, :attempting, :reviewed, :finished]
    end
    
    # def must_be_at_choice
    #   if choice == 0
    #     status = 0
    #     errors.add(:choice, "You must freely choose, otherwise you're slaving away instead of being Playfully Productive!")
    #   end
    # end
    #
    # def focus_or_verb
    #   if !focus || focus == '' || !verb || verb == ''
    #     status = :committing
    #     errors.add(:focus, "You must include either a focus or a verb to describe this Action.")
    #     errors.add(:verb, "You must include either a focus or a verb to describe this Action.")
    #   end
    # end
end
