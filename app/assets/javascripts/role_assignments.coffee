# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$(document).ready ->
  $('#role-assignments-table').DataTable
    autoWidth: false
    searching: false
    order: [0, 'desc']
    pageLength: -1
    lengthMenu: [ [10, 25, 50, -1], [10, 25, 50, 'All'] ]
    language: lengthMenu: '_MENU_'
