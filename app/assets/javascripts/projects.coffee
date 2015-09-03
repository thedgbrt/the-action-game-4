$(document).ready ->
  $('#add-project').on 'click', ->
    input_project = prompt('Please enter your project', 'Outcome Achieved?')
    $.ajax({
      type: "POST",
      url: "/projects",
      data: { project: { name: input_project } },
      success:(data) ->
        console.log 'data', data
        $('#aktion_project_id').html("<option value='" + data.id + " '>" + input_project + "</option>")
        return false
      error:(data) ->
        alert 'Unable to add your project'
        return false
    })
