@Locations = React.createClass
    getInitialState: ->
      locations: @props.data
    getDefaultProps: ->
      locations: []
    addLocation: (location) ->
        locations = @state.locations.slice()
        locations.push location
        @setState locations: locations
    deleteLocation: (location) ->
      locations = @state.locations.slice()
      index = locations.indexOf location
      locations.splice index, 1
      @replaceState locations: locations
    render: ->
      React.DOM.div
        className: 'locations'
        React.DOM.h2
          className: 'title'
          'Locations'
        React.createElement LocationForm, handleNewLocation: @addLocation
        React.DOM.hr null
        React.DOM.table
          className: 'table compact'
          id: 'records-table'
          React.DOM.thead null,
            React.DOM.tr null,
              React.DOM.td null, 'Name'
              React.DOM.td null, 'Address'
              React.DOM.td null, 'Latitude'
              React.DOM.td null, 'Longitude'
              React.DOM.th null, 'Actions'
          React.DOM.tbody null,
            for location in @state.locations
              React.createElement Location, key: location.id, location: location, handleDeleteLocation: @deleteLocation
    