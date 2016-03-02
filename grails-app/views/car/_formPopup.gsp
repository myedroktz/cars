<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">Edit Car</h4> <small id="carId" attr-id=""></small>
            </div>

            <div class="modal-body" id="modal-body">
                <g:form id="submitCarFormAjax">
                   <g:render template="formFields"/>
                    <div class="form-group">
                        <label for="owner">Owner</label>
                        <div class="input-group">
                            <input disabled="true" id="owner" autocomplete="off" type="text" maxlength="50" name="owner" class="form-control" placeholder="Owner"/>
                            <span class="input-group-btn">
                                <button class="btn btn-primary" type="button" id="editOwner">Edit</button>
                            </span>
                        </div>
                    </div>
                    <div id="ownerList" class="btn-group">
                    </div>
                </g:form>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-default" onclick="cleanModal('#myModal','#carId')"
                        data-dismiss="modal">Close</button>

                <button id="saveButton" type="button" class="btn btn-primary"
                        onclick="saveCar($('#carId').attr('attr-id'))"
                        data-trigger="manual"
                        data-container="body"
                        data-toggle="popover"
                        data-placement="top"
                        data-content="There was a problem saving, check your inputs">Save changes</button>

                <button type="button" class="btn btn-danger" onclick="deleteCar($('#carId').attr('attr-id'))"
                        id="btnDelete">Delete Car</button>
            </div>
        </div>
    </div>
</div>