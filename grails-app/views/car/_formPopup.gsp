<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">Edit Car Nro </h4> <small id="carId"></small>
            </div>
            <div class="modal-body" id="modal-body">
                <g:form class="form-horizontal">
                   <g:render template="formFields"/>
                </g:form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary" onclick="save()">Save changes</button>
            </div>
        </div>
    </div>
</div>

<g:javascript>
    function save(){
        $.ajax({
            type: 'POST', //DOES NOT WORK WITH PUT
            url: '/cars/carRest/update/'+carId,
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
</g:javascript>