@Location = React.createClass
  handleDelete: (e) ->
    e.preventDefault()
    # yeah... jQuery doesn't have a $.delete shortcut method
    $.ajax
      method: 'DELETE'
      url: "/locations/#{ @props.location.id }"
      dataType: 'JSON'
      success: () =>
        @props.handleDeleteLocation @props.location
  render: ->
    React.DOM.tr null,
      React.DOM.td null, @props.location.name
      React.DOM.td null, @props.location.address
      React.DOM.td null, @props.location.latitude
      React.DOM.td null, @props.location.longitude
      React.DOM.td null,
        React.DOM.a
          className: 'button'
          onClick: @handleDelete
          'Delete'
