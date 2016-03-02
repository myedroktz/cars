/************************************
 *  OWNER SEARCH FORM FUNCTIONS     *
 ************************************/

/***
 * Stuff to execute when document is ready
 */
$(document).ready(
    $('#searchButton').trigger('click')
);

/***
 * Keyup listener for fields
 */
$("#searchForm").find("[name='name'],[name='lastName'],[name='dni'],[name='nationality']").keyup(function(event){
    if(event.keyCode == 13){ //Capture Enter
        $("#searchButton").click();
    }else if(event.keyCode != 9){ // Capture Tab
        $("#searchButton").click();
    }
});

/***
 * Updates table rows using the REST API
 * @param tableBodyId: id of the table body (with sharp). Example: "#MyTableBody"
 */
function updateTableContent(tableBodyId){
    $(tableBodyId).empty();
    var queryString = "/cars/ownerRest/" +
        "?name=" + $("#name").val() +
        "&lastName=" + $("#lastName").val() +
        "&nationality=" + $("#nationality").val() +
        "&dni=" + $("#dni").val()

    $.getJSON(queryString, function(data){
        var tableBody = $(tableBodyId)
        for (var i = 0, len = data.length; i < len; i++) {
            //alert(tableElement);
            var item=data[i];
            tableBody.append($('<tr>')
                    .attr('attr-id',item.id)
                    .append($('<td>')
                        .text(item.id)
                        .attr('class','active'))
                    .append($('<td>')
                        .text(item.name)
                        .attr('class','success'))
                    .append($('<td>')
                        .text(item.lastName)
                        .attr('class','success'))
                    .append($('<td>')
                        .text(item.dni)
                        .attr('class','success'))
                    .append($('<td>')
                        .text(item.nationality)
                        .attr('class','success'))
            );
        };

        //After appending
        addRowHandlers("#ownersTable", '#myModal',loadOwnerInModal);
        updateTableHeader("#ownersTable",'#ownerTableHead');
    });
}

/***
 * Load owner data in a modal form
 * @param ownerId: database owner id
 * @param modalId: modal id (with sharp) when the car will be loaded
 */
function loadOwnerInModal(ownerId, modalId){
    $.getJSON('/cars/ownerRest/show/'+ownerId, function(owner){
        $(modalId + " [name='name']").val(owner.name);
        $(modalId + " [name='lastName']").val(owner.lastName);
        $(modalId + " [name='dni']").val(owner.dni);
        $(modalId + " [name='nationality']").val(owner.nationality);

        document.getElementById("ownerId").innerHTML = '#ID '+ ownerId;
        $("#ownerId").attr('attr-id', ownerId);
        document.getElementById("myModalLabel").innerHTML = 'Edit Owner';

        $('#btnDelete').show();
        $(modalId).modal();
    });
}

/***
 * Updates a owner given its Id. Empty Id ('') creates a new owner
 * @param objectId: owner Id or empty string
 */
function saveOwner(objectId){
    saveObject(	objectId,
        '/cars/ownerRest/',
        {
            name: $(".modal-body [name='name']").val(),
            lastName: $(".modal-body [name='lastName']").val(),
            dni: $(".modal-body [name='dni']").val(),
            nationality: $(".modal-body [name='nationality']").val()
        },
        function(response){
            $('#myModal').modal('hide');
            $('#searchButton').trigger('click');
        });
}

/***
 * Delete a owner given it's Id
 * @param objectId
 */
function deleteOwner(objectId){
    deleteObject(objectId,'/cars/ownerRest/delete/',
        function onSuccess(){
            $('#myModal').modal('hide');
            $('#searchButton').trigger('click');
        })
}

/***
 * Clean modal fields given it Id
 * @param modalId: modal Id
 * @param modalKeyElement: id of the html element of the modal containing the attr-id attribute
 */
function cleanModal(modalId, modalKeyElement){
    $(modalId + " [name='name']").val('');
    $(modalId + " [name='lastName']").val('');
    $(modalId + " [name='dni']").val('');
    $(modalId + " [name='nationality']").val('');
    document.getElementById(modalKeyElement.substring(1)).innerHTML = '';
    $(modalKeyElement).attr('attr-id', '');
}