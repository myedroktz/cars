
var carId;
window.onload = addRowHandlers();

if (typeof jQuery !== 'undefined') {
	(function($) {
		$('#spinner').ajaxStart(function() {
			$(this).fadeIn();
		}).ajaxStop(function() {
			$(this).fadeOut();
		});
	})(jQuery);
}

function showSpinner(visible) {
	if (visible) $('#spinner').show();
	else $('#spinner').hide();
}

function cleanModal(){
	$(".modal-body [name='model']").val('');
	$(".modal-body [name='make']").val('');
	$(".modal-body [name='year']").val('');
	document.getElementById("carId").innerHTML = '';
}

function newCar(){
	carId = '';
	$('#btnDelete').hide();
	cleanModal();
	document.getElementById("myModalLabel").innerHTML = 'New Car';
	$('#myModal').modal();
}


function getCar(){
	$.ajax({
		type: 'GET',
		url: '/cars/carRest/show/',
		dataType: 'json',
		data: {id: carId},
		success: function(response){
			//alert(JSON.stringify(response));
			//alert(response.model);
			$(".modal-body [name='model']").val(response.model);
			$(".modal-body [name='year']").val(response.year);
			$(".modal-body [name='make']").val(response.make);
			document.getElementById("carId").innerHTML = '#ID '+carId;
			document.getElementById("myModalLabel").innerHTML = 'Edit Car';
			$('#btnDelete').show();
			$('#myModal').modal();
		}
	});
}
function deleteCar(){
	$.ajax({
		type: 'DELETE',
		url: '/cars/carRest/delete/' + carId,
		dataType: 'json',

		success: function(response){
			$('#myModal').modal('hide');
			$('#searchButton').trigger('click');
			//alert(JSON.stringify(response));
			//document.getElementById("carId").textContent
		}
	});
}

function saveCar(){
	var method = ((carId == '') ? 'save' : 'update');
	$.ajax({
		type: 'POST', //DOES NOT WORK WITH PUT
		url: '/cars/carRest/' + method + '/' + carId,
		dataType: 'json',
		data: {
			model: $(".modal-body [name='model']").val(),
			year: $(".modal-body [name='year']").val(),
			make: $(".modal-body [name='make']").val()
		},
		//beforeSend: function(){alert($(".modal-body [name='model']").val();},
		success: function(response){
			$('#myModal').modal('hide');
			$('#searchButton').trigger('click');
			//alert(JSON.stringify(response));
			//document.getElementById("carId").textContent
		}
	});
}

/**
 * Shows table header if there is data in the table, hides if not
 */
function updateTableHeader(){
	var table = document.getElementById("carsTable");
	var rows = table.getElementsByTagName("tr");

	if(rows.length <= 1){
		$('#carTableHead').hide();
	}else{
		$('#carTableHead').show();
	}
}

/**
 * Add onClick event to carsTable rows
 */
function addRowHandlers() {

	$("#carsTable").find("tr").bind("click", function(e){
		e.preventDefault();
		var row = $(this);
		carId = row.attr("attr-id");
		getCar();
	});
}
/**
 *  Another way to add click handlers
 */
/* function addRowHandlers() {
	 var table = document.getElementById("carsTable");
	 var rows = table.getElementsByTagName("tr");

	for (i = 0; i < rows.length; i++) {
		var currentRow = table.rows[i];
		var createClickHandler =
			function(row)
			{
				return function() {
					var cell = row.getElementsByTagName("td")[0];
					carId = cell.innerHTML;
					alert("id: " + currentRow.attr('id'));
					getCar();

				};
			};

		currentRow.onclick = createClickHandler(currentRow);
	}
}*/

/**
 * OnClick event for search form inputs
 */
$("#searchForm").find("[name='year'],[name='model'],[name='make']").keyup(function(event){
	if(event.keyCode == 13){
		$("#searchButton").click();
	}
});

$("#searchForm").find("[name='year'],[name='model'],[name='make']").keyup(function(event){
		$("#searchButton").click();
});

