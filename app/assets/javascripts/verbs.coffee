$(document).ready ->
  $('#add-verb').on 'click', ->
    input_verb = prompt('Please enter your verb', 'Doing what?')
    $.ajax({
      type: "POST",
      url: "/verbs",
      data: { verb: { name: input_verb } },
      success:(data) ->
        console.log 'data', data
        $('#aktion_verb_id').html("<option value='" + data.id + " '>" + input_verb + "</option>")
        return false
      error:(data) ->
        alert 'Unable to add your verb'
        return false
    })
