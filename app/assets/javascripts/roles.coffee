$(document).ready ->
  $('#add-role').on 'click', ->
    team_id = $('#aktion_team_id').val()
    if !team_id
      alert 'You must first choose a team before adding a role'
      return
    input_role = prompt('Please enter your role', 'New Role Name?')
    console.log 'team_id', team_id
    $.ajax({
      type: "POST",
      url: "/roles",
      data: { role: { name: input_role, team_id: team_id } },
      success:(data) ->
        console.log 'data', data
        $('#aktion_role_id').html("<option value='" + data.id + " '>" + input_role + "</option>")
        return false
      error:(data) ->
        alert 'Unable to add your role'
        return false
    })
