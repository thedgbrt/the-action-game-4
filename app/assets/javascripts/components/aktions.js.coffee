@Aktions = React.createClass
    getInitialState: ->
      aktions: @props.data
    getDefaultProps: ->
      aktions: []
    render: ->
      React.DOM.div
        className: 'aktions'
        React.DOM.h2
          className: 'title'
          'Actions'
        React.DOM.table
          className: 'table table-bordered'
          React.DOM.thead null,
            React.DOM.tr null,
              React.DOM.th null, 'Time Slot'
              React.DOM.th null, 'Focus'
          React.DOM.tbody null,
            for aktion in @state.aktions
              React.createElement Aktion, key: aktion.id, aktion: aktion
    