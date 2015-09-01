$(document).ready(function(){
    $('#aktions-table').DataTable({
        autoWidth: false,
        ordering: false,
        searching: false,
        order: [0, 'desc'],
        pageLength: 25,
        lengthMenu: [ [10, 25, 50, -1], [10, 25, 50, 'All'] ],
        language: { lengthMenu: "Display _MENU_ Actions" }
    });
});
