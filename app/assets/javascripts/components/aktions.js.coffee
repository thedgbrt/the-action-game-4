# @Aktions = React.createClass
#     getInitialState: ->
#       aktions: @props.data
#     getDefaultProps: ->
#       aktions: []
#     render: ->
#       React.DOM.div
#         className: 'aktions'
#         React.DOM.h2
#           className: 'title'
#           'Actions'
#         React.DOM.table
#           className: 'table table-bordered'
#           React.DOM.thead null,
#             React.DOM.tr null,
#               React.DOM.td null, 'Time Slot'
#               React.DOM.td null, 'Verb'
#               React.DOM.td null, 'Focus'
#               React.DOM.td null, 'Intensity'
#               React.DOM.td null, 'Role'
#               React.DOM.td null, 'Project'
#               React.DOM.td null, 'Team'
#               React.DOM.td null, 'Player'
#               React.DOM.td null, 'Status'
#               React.DOM.td null, 'Flow'
#               React.DOM.td null, 'Flow Notes'
#               React.DOM.td null, 'Value'
#               React.DOM.td null, 'Value Notes'
#           React.DOM.tbody null,
#             for aktion in @state.aktions
#               React.createElement Aktion, key: aktion.id, aktion: aktion
#