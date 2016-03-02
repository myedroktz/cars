/**
 *  GENERAL APPLICATION FUNCTIONS
 */



/***
 * Shows or hiddes spinner
 * @param visible
 */
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


/***
 * Opens a modal form for a New operation
 * @param modalId
 * @param modalKeyElement
 */
function loadNewForm(modalId,modalKeyElement){
	$('#btnDelete').hide();
	cleanModal(modalId,modalKeyElement);
	document.getElementById("myModalLabel").innerHTML = 'New';
	$(modalId).modal();
}

/***
 * Delete an object via ajax
 * @param objectId
 * @param url
 * @param successCallback
 */
function deleteObject(objectId,url,successCallback){
	$.ajax({
		type: 'DELETE',
		url: url + objectId,
		dataType: 'json',
		success: successCallback
		}
	);
}

/***
 * Saves/updates an object via ajax
 * @param objectId
 * @param url
 * @param objectData
 * @param successCallback
 */
function saveObject(objectId, url, objectData, successCallback, errorCallback){
	if (typeof(errorCallback)==='undefined') errorCallback = function(){alert("Error saving/updating");};

	var method = ((objectId == '') ? 'save' : 'update');
	$.ajax({
		type: 'POST', //DOES NOT WORK WITH PUT
		url: url + method + '/' + objectId,
		dataType: 'json',
		data: objectData,
		success: successCallback,
		error: errorCallback
	});
}

/**
 * Shows table header if there is data in the table, hides if not
 */
function updateTableHeader(tableId, tableHeadId){
	var table = document.getElementById(tableId.substring(1));
	var rows = table.getElementsByTagName("tr");

	if(rows.length <= 1){
		$(tableHeadId).hide();
	}else{
		$(tableHeadId).show();
	}
}

/**
 * Add onClick event to carsTable rows
 */
function addRowHandlers(tableId, modalId, myCallback) {
	$(tableId).find("tr").bind("click", function(e){
		e.preventDefault();
		var row = $(this);
		var objectId = row.attr("attr-id");
		myCallback(objectId, modalId);
	});
}

