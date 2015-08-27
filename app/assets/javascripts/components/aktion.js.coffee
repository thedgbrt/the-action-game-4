@Aktion = React.createClass
  render: ->
    React.DOM.tr null,
      React.DOM.td null, @props.aktion.simple_time
      React.DOM.td null, @props.aktion.verb
      React.DOM.td null, @props.aktion.focus
      React.DOM.td null, @props.aktion.intensity
      React.DOM.td null, @props.aktion.role
      React.DOM.td null, @props.aktion.project
      React.DOM.td null, @props.aktion.team
      React.DOM.td null, @props.aktion.player
      React.DOM.td null, @props.aktion.status
      React.DOM.td null, @props.aktion.flow
      React.DOM.td null, @props.aktion.flow_notes
      React.DOM.td null, @props.aktion.value
      React.DOM.td null, @props.aktion.value_notes
