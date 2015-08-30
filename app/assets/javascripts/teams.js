$(document).ready(function(){
    $('#my-teams').DataTable({
        paging: false,
        searching: false,
        order: [1, 'asc']
    });
});

$(document).ready(function(){
    $('#other-teams').DataTable({
        paging: false,
        searching: false,
        order: [1, 'asc']
    });
});