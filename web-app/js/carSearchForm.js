/******************************
 *  CAR SEARCH FORM FUNCTIONS *
 ******************************/

/***
 * Stuff to execute when document is ready
 */
$(document).ready(
    addRowHandlers("#carsTable", '#myModal',loadCarInModal),
    updateTableHeader("#carsTable",'#carTableHead'),
    updatePaginateButtons("#carsTable",'#paginateButtons')
);


/**
 * OnClick event for search form inputs
 */
$("#searchForm").find("[name='year'],[name='model'],[name='make']").keyup(function(event){
    if(event.keyCode == 13){ //Capture Enter
        $("#searchButton").click();
    }else if(event.keyCode != 9){ // Capture Tab
        $("#searchButton").click();
    }
});

/***
 * OnClick event for owner edit button
 */
$("#editOwner").click(function(){
    $("#owner").prop('disabled',false);
    $("#owner").val('');
    $("#owner").trigger('keyup',13);
});

/***
 * OnClick event for owner text box
 */
$("#owner").keyup(function(event){
  loadOwnerList($("#owner"),$("#ownerList"));
});

/**
 * Keyup event for carPlate (Input validation)
 * */
$(".modal-body").find("#carPlate").keyup(function(){
    var regexp = /^[A-Z]{3}[0-9]{3}$/;
    var isCarPlate = regexp.test($(this).val());
    if(isCarPlate){
        $(".modal-body #carPlateFormGroup").removeClass('has-error');
    }else{
        $(".modal-body #carPlateFormGroup").addClass('has-error');
    }
});

/**
 * Keyup event for year (Input validation)
 */
$(".modal-body").find("#year").keyup(function(){
    var regexp = /^[0-9]{4}$/;
    var isFourDigits = regexp.test($(this).val());
    if(isFourDigits){
        $(".modal-body #yearFormGroup").removeClass('has-error');
    }else{
        $(".modal-body #yearFormGroup").addClass('has-error');
    }
})

/***
 * Focusout event for popover on failed save
 */
$("#saveButton").focusout(function(){
    $("#saveButton").popover('hide');
});

/***
* Update hidden form for pagination
*/
function increaseOffset(offsetElementId){
    $(offsetElementId).val(parseInt($(offsetElementId).val()) + 10);
    $("#searchButton").trigger('click');
}
function decreaseOffset(offsetElementId){
    $(offsetElementId).val(parseInt($(offsetElementId).val()) - 10);
    (($(offsetElementId).val() < 0) ? $(offsetElementId).val(0) : 1);
    $("#searchButton").trigger('click');
}

function updatePaginateButtons(tableId, paginateButtonsDivId){
    var table = document.getElementById(tableId.substring(1));
    var rows = table.getElementsByTagName("tr");

    if(rows.length <= 1){

        $(paginateButtonsDivId).hide();
    }else{

        $(paginateButtonsDivId).show();
    }
}

/***
 * @param ownerInputElement
 * @param ownerListElement
 */
function loadOwnerList(ownerInputElement, ownerListElement){

    $(ownerListElement).empty();
    var queryString = "/cars/ownerRest/" + "?name=" + ownerInputElement.val();
    ownerListElement.show();

    $.getJSON(queryString, function(data){
        var len = ((data.length <= 8)? data.length : 8);
        for (var i = 0; i < len; i++){
            var item=data.content.owner[i];
            ownerListElement.append($('<a>')
                .attr('attr-id',item.id)
                .attr('class','btn btn-success btn-sm')
                .text(item.name + ' ' + item.lastName));
        }

        ownerListElement.find("a").bind("click", function(e){
            e.preventDefault();
            var row = $(this);
            $("#owner").val(row.text());
            $("#owner").attr('attr-ownerId',row.attr('attr-id'));
            $("#owner").prop('disabled',true);
            ownerListElement.hide();
        });
    });
}

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
        $(modalId + " [name='owner']").val(car.owner.name + ' ' + car.owner.lastName);
        $(modalId + " [name='owner']").attr('attr-ownerId',car.owner.id);

        document.getElementById("carId").innerHTML = '#ID '+ carId;
        $("#carId").attr('attr-id', carId);
        document.getElementById("myModalLabel").innerHTML = 'Edit Car';

        $('#btnDelete').show();
        $(modalId).modal();
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
    $(modalId + " [name='owner']").val('');
    $(modalId + " #ownerList").hide();
    document.getElementById(modalKeyElement.substring(1)).innerHTML = '';
    $(modalKeyElement).attr('attr-id', '');
    $(".modal-body #carPlateFormGroup").removeClass("has-error");
    $(".modal-body #yearFormGroup").removeClass("has-error");
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
            carPlate: $(".modal-body [name='carPlate']").val(),
            owner: $(".modal-body [name='owner']").attr('attr-ownerId')
        },
        function(response){
            $('#myModal').modal('hide');
            $('#searchButton').trigger('click');
        },
        function(response){
            $("#saveButton").popover('show');
        }
    );
}