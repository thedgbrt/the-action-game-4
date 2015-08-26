$('#projects-table').DataTable({
    paging: false,
    searching: false,
    order: [1, 'asc'],
    orderClasses: true,
    columnDefs: [
        { targets: 'nosort', orderable: false}
    ]
});