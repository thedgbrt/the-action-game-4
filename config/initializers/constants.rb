# Be sure to restart your server when you modify this file.

PARTS_OF_DAY = ['Night (12-6am)', 'Morning (6am-noon)', 'Afternoon (12-6pm)', 'Evening(6pm-12am)']

COLORS = [
  ['green', '#CCFFCC'],
  ['red', '#FFCCCC'],
  ['yellow', '#F4FA58'],
  ['blue', '#5882FA'],
  ['orange', '#F5D0A9'],
  ['purple', '#D0A9F5'],
  ['salmon', '#F7819F'],
  ['cyan', '#81F7F3'],
  ['grey', '#BDBDBD']
]

CHOICE = 'I freely choose to play TAG.com'

INTENSITIES = [
  ['Attempted - Broke Key Rule (+3)', 2], 
  ['Loose - Barely Acceptable (+6)', 3],
  ['Solid - Followed All Rules (+8)', 4],
  ['Exceptional - Great Spirit (+10)', 5]
]

STATUS_OPTIONS = [
  ['Committing', :committing], 
  ['Attempting', :attempting], 
  ['Stopped', :stopped],
  ['Reviewed', :reviewed], 
  ['Finished', :finished], 
]

INTEGRITY_SCORES = {
  1 => 'Quasi',
  3 => 'Attempted',
  6 => 'Loose',
  8 => 'Solid',
  10 => 'Exceptional'
}

FLOW_VALUE_OPTIONS = [
  ['+3 (Amazing)', 3],
  ['+2 (Good)', 2],
  ['+1 (Decent)', 1],
  [' 0 (Average)', 0],
  ['-1 (Questionable)', -1],
  ['-2 (Poor)', -2],
  ['-3 (Terrible)', -3]
]

FLOW_PLACEHOLDER = 'Subjectively, how did you feel? Was your body comfortable? Were you able to stay focused the whole time?'
VALUE_PLACEHOLDER = 'Objectively, what did you work on?  What did you complete or accomplish?  Is this the right strategy for your project?  Is this project a good use of your time?'

INTENSITY_PROMPT = 'Self-Reported Integrity Score?'

DEFAULT_WARNING_VOLUME = 70
DEFAULT_TICKING_VOLUME = 30
MIN_NOTES_LENGTH = 10