/***
 *  CAR SEARCH FORM FUNCTIONS
 */

/***
 * Execute when document is ready
 */
$(document).ready(
    addRowHandlers("#carsTable", '#myModal',loadCarInModal),
    updateTableHeader("#carsTable",'#carTableHead')
    //populateSelectOwner()
);

/***
 * Load car data in a modal form
 * @param carId: database car id
 * @param modalId: modal id (with sharp) when the car will be loaded
 */
function loadCarInModal(carId, modalId){
    $.getJSON('/cars/carRest/show/'+carId, function(car){
        $(modalId + " [name='model']").val(car.model);
        $(modalId + " [name='year']").val(car.year);
        $(modalId + " [name='make']").val(car.make);
        $(modalId + " [name='carPlate']").val(car.carPlate);

        document.getElementById("carId").innerHTML = '#ID '+ carId;
        $("#carId").attr('attr-id', carId);
        document.getElementById("myModalLabel").innerHTML = 'Edit Car';

        $('#btnDelete').show();
        $(modalId).modal();
    });
}

/***
 * Delete a car given it's Id
 * @param objectId
 */
function deleteCar(objectId){
    deleteObject(objectId,'/cars/carRest/delete/',
        function onSuccess(){
            $('#myModal').modal('hide');
            $('#searchButton').trigger('click');
        })
}

/***
 * Updates a car given its Id. Empty Id ('') creates a new car
 * @param objectId: car Id or empty string
 */
function saveCar(objectId){
    saveObject(	objectId,
        '/cars/carRest/',
        {
            model: $(".modal-body [name='model']").val(),
            year: $(".modal-body [name='year']").val(),
            make: $(".modal-body [name='make']").val(),
            carPlate: $(".modal-body [name='carPlate']").val()
        },
        function(response){
            $('#myModal').modal('hide');
            $('#searchButton').trigger('click');
        });
}

/***
 * Clean modal fields given it Id
 * @param modalId: modal Id
 * @param modalKeyElement: id of the html element of the modal containing the attr-id attribute
 */
function cleanModal(modalId, modalKeyElement){
    $(modalId + " [name='model']").val('');
    $(modalId + " [name='make']").val('');
    $(modalId + " [name='year']").val('');
    $(modalId + " [name='carPlate']").val('');
    document.getElementById(modalKeyElement.substring(1)).innerHTML = '';
    $(modalKeyElement).attr('attr-id', '');
}