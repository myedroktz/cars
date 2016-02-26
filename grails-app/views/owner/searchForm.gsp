<%--
  Created by IntelliJ IDEA.
  User: myedro
  Date: 25/02/16
  Time: 10:18
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
                        <h2 class="text-center">Owner Search</h2>
                    </div>
                    <div class="panel-body">
                        <div class="col-md-offset-0 col-md-12">
                            <div class="form-inline" id="searchForm">
                                %{--<g:form>--}%

                                    <g:render template="formFields"/>

                                    <label class="radio-inline">
                                        <input type="radio" name="inlineRadioOptions" id="inlineRadio1" value="JSON"> JSON
                                    </label>
                                    <label class="radio-inline">
                                        <input type="radio" name="inlineRadioOptions" id="inlineRadio2" value="View" checked> View
                                    </label>

                                    %{--<div class="form-group">--}%
                                        %{--<button type="button" class="btn btn-primary" onclick="newCar()">New Car</button>--}%
                                    %{--</div>--}%

                                    <div class="form-group">
                                        <button id="searchButton" value="Search" class="btn btn-primary" onclick="updateTableContent('#ownerListTable')">Search</button>
                                    </div>

                                %{--Add the spinner image--}%
                                    <g:img id="spinner" style="display: none" uri="/images/spinner.gif"/>
                                %{--</g:form>--}%

                            </div>
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
                <table class="table table-hover" id="ownersTable">
                    <thead>
                        <tr id="ownerTableHead" class="active">
                            <th class="col-md-2">Id</th>
                            <th class="col-md-2">Name</th>
                            <th class="col-md-2">Last Name</th>
                            <th class="col-md-2">DNI</th>
                            <th class="col-md-2">Nationality</th>
                        </tr>
                    </thead>
                    <tbody id="ownerListTable">
                        %{--<g:render template="ownerTableRow"/>--}%
                    </tbody>
                </table>
            </div>
        </div>

        <g:render template="formPopup"/>

        <g:javascript>

            $("#searchForm").find("[name='name'],[name='lastName'],[name='dni'],[name='nationality']").keyup(function(event){
                if(event.keyCode == 13){ //Capture Enter
                    $("#searchButton").click();
                }else if(event.keyCode != 9){ // Capture Tab
                    $("#searchButton").click();
                }
            });

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
                                .append($('<td>').text(item.id))
                                .append($('<td>').text(item.name))
                                .append($('<td>').text(item.lastName))
                                .append($('<td>').text(item.dni))
                                .append($('<td>').text(item.nationality))
                        );
                    }
                });
            }
        </g:javascript>



    </body>
</html>