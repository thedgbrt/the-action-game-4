@Aktion = React.createClass
  render: ->
    React.DOM.tr null,
      React.DOM.td null, @props.aktion.timeslot
      React.DOM.td null, @props.aktion.focus
