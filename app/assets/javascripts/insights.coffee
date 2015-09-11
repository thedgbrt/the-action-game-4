# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  $('#add-insight').on 'click', ->
    input_insight = prompt('Please enter your insight', 'e = mc^2')
    $.ajax({
      type: "POST",
      url: "/insights",
      data: { insight: { text: input_insight, aktion_id: 66, player_id: 666 } },
      success:(data) ->
        $('#insights').append(input_insight + "<br>")
        return false
      error:(data) ->
        alert 'Unable to add your insight'
        return false
    })
