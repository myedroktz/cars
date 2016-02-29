<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">Edit Car</h4> <small id="carId" attr-id=""></small>
            </div>

            <div class="modal-body" id="modal-body">
                <g:form>
                   <g:render template="formFields"/>
                </g:form>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary" onclick="saveCar($('#carId').attr('attr-id'))">Save changes</button>
                <button type="button" class="btn btn-danger" onclick="deleteCar($('#carId').attr('attr-id'))" id="btnDelete">Delete Car</button>
            </div>
        </div>
    </div>
</div>