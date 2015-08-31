@LocationForm = React.createClass
  getInitialState: ->
    name: ''
    address: ''
    latitude: ''
    longitude: ''
  handleChange: (e) ->
    name = e.target.name
    @setState "#{ name }": e.target.value
  valid: ->
    @state.name && @state.address
  handleSubmit: (e) ->
    e.preventDefault()
    $.post '', { location: @state }, (data) =>
      @props.handleNewLocation data
      @setState @getInitialState()
    , 'JSON'
  render: ->
      React.DOM.form
        className: 'form-inline'
        onSubmit: @handleSubmit
        React.DOM.div
          className: 'large-4 columns'
          React.DOM.input
            type: 'text'
            placeholder: 'Name'
            name: 'name'
            value: @state.name
            onChange: @handleChange
        React.DOM.div
          className: 'large-4 columns'
          React.DOM.input
            type: 'text'
            placeholder: 'Address'
            name: 'address'
            value: @state.address
            onChange: @handleChange
        React.DOM.button
          type: 'submit'
          className: 'large-4 columns button'
          disabled: !@valid()
          'Create Location'
