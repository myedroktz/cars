<%--
  Created by IntelliJ IDEA.
  User: myedro
  Date: 17/02/16
  Time: 14:05
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta name="layout" content="main"/>
        <title>Query Car</title>
        <g:javascript library='jquery' />
    </head>

    <body>

        <div class="row">
            <div class="col-sm-offset-1 col-sm-10">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <h2 class="text-center">Car Search</h2>
                    </div>
                    <div class="panel-body">
                        <div class="col-md-offset-0 col-md-12">
                            <g:form class="form-inline" action="searchAjax">

                                %{--<div class="form-group">
                                <label for="id">ID</label>
                                <g:textField name="id" class="form-control" placeholder="Car Id"/>
                                </div>--}%

                                <g:render template="formFields" bean="${car}"/>

                                <label class="radio-inline">
                                    <input type="radio" name="inlineRadioOptions" id="inlineRadio1" value="JSON"> JSON
                                </label>
                                <label class="radio-inline">
                                    <input type="radio" name="inlineRadioOptions" id="inlineRadio2" value="View" checked> View
                                </label>

                                <div class="form-group">
                                    %{--<g:submitButton name="searchButton" value="Search" class="btn btn-primary"/>--}%
                                    <g:submitToRemote   value="Search"
                                                        url="[controller: 'Car', action: 'searchAjax']"
                                                        update="carListTable"
                                                        onComplete="addRowHandlers()"
                                                        class="btn btn-primary"/>

                                    %{--Add the spinner image--}%
                                    %{--<g:img id="spinner" style="display: none" uri="/images/spinner.gif"/>--}%
                                </div>
                            </g:form>
                        </div>
                    </div>
                    <div class="panel-footer">
                        <h6 class="text-center">Cars Query Project</h6>
                    </div>
                </div>
            </div>
        </div>

    <div class="row">
        <div class="col-md-offset-1 col-md-10">
            <table class="table table-hover" id="carsTable">

                    <tr>
                        <th>Id</th>
                        <th>Make</th>
                        <th >Model</th>
                        <th>Year</th>

                    </tr>

                <tbody id="carListTable">
                    <g:render template="carTableRow" collection="${carList}" var="car"/>
                </tbody
            </table>
        </div>
    </div>

    <g:javascript>
        function addRowHandlers() {
            var table = document.getElementById("carsTable");
            var rows = table.getElementsByTagName("tr");

            for (i = 0; i < rows.length; i++) {
                var currentRow = table.rows[i];
                var createClickHandler =
                        function(row)
                        {
                            return function() {
                                var cell = row.getElementsByTagName("td")[0];
                                var id = cell.innerHTML;
                                //alert("id:" + id);

                                $.ajax({
                                    type: 'GET',
                                    url: '/cars/carRest/show/',
                                    dataType: 'json',
                                    data: {id: id},
                                    success: function(response){
                                        //alert(JSON.stringify(response));
                                        //alert(response.model);

                                        $("[name='model']").val(response.model);
                                        $("[name='year']").val(response.year);
                                        $("[name='make']").val(response.make);

                                        $('#myModal').modal();
                                    }
                                });
                            };
                        };

                currentRow.onclick = createClickHandler(currentRow);
            }
        }
        window.onload = addRowHandlers();

    </g:javascript>

    <g:render template="formPopup"/>

    </body>
</html>