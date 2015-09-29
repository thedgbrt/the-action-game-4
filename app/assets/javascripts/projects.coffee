$(document).ready ->
  $('#add-project').on 'click', ->
    input_project = prompt('Please enter your project', 'Outcome Achieved?')
    current_player_id = document.getElementById('time').dataset.current_player_id
    current_team_id = $('#aktion_team_id').val()
    console.log 'current_team_id', current_team_id
    $.ajax({
      type: "POST",
      url: "/projects",
      data: { project: { name: input_project, team_id: current_team_id, creator_id: current_player_id, commitment: true, active: true } },
      success:(data) ->
        $('#aktion_project_id').html("<option value='" + data.id + " '>" + input_project + "</option>")
        return false
      error:(data) ->
        console.log 'error data:', data
        alert 'Unable to add your project'
        return false
    })
