@Location = React.createClass
  render: ->
    React.DOM.tr null,
      React.DOM.td null, @props.location.name
      React.DOM.td null, @props.location.address
      React.DOM.td null, @props.location.latitude
      React.DOM.td null, @props.location.longitude
