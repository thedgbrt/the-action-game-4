@Locations = React.createClass
    getInitialState: ->
      locations: @props.data
    getDefaultProps: ->
      locations: []
    render: ->
      React.DOM.div
        className: 'locations'
        React.DOM.h2
          className: 'title'
          'Locations'
        React.DOM.table
          className: 'table compact'
          React.DOM.thead null,
            React.DOM.tr null,
              React.DOM.td null, 'Name'
              React.DOM.td null, 'Address'
              React.DOM.td null, 'Latitude'
              React.DOM.td null, 'Longitude'
          React.DOM.tbody null,
            for locations in @state.locations
              React.createElement Location, key: location.id, location: location
    