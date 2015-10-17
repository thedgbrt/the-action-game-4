$(document).ready ->
  $('#players-table').DataTable
    autoWidth: false
    searching: false
    order: [0, 'asc']
    pageLength: 25
    lengthMenu: [ [10, 25, 50, -1], [10, 25, 50, 'All'] ]
    language: lengthMenu: 'Display _MENU_ Actions'
