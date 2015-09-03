$(document).ready ->
  $('#add-role').on 'click', ->
    input_role = prompt('Please enter your role', 'New Role Name?')
    $.ajax({
      type: "POST",
      url: "/roles",
      data: { role: { name: input_role } },
      success:(data) ->
        console.log 'data', data
        $('#aktion_role_id').html("<option value='" + data.id + " '>" + input_role + "</option>")
        return false
      error:(data) ->
        alert 'Unable to add your role'
        return false
    })
