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
        <r:require module="carSearchForm"/>
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
                        <div class="form-inline" id="searchForm">
                            <g:form action="searchAjax">

                                <g:render template="formFields"/>

                                <input type="hidden" name="offset" id="offset" value="0"/>

                                <label class="radio-inline">
                                    <input type="radio" name="inlineRadioOptions" id="inlineRadio1" value="JSON"> JSON
                                </label>
                                <label class="radio-inline">
                                    <input type="radio" name="inlineRadioOptions" id="inlineRadio2" value="View" checked> View
                                </label>

                                <div class="form-group">
                                    <button type="button" class="btn btn-primary" onclick="loadNewForm('#myModal','#carId')">New Car</button>
                                </div>

                                <div class="form-group">
                                    %{--<g:submitButton name="searchButton" value="Search" class="btn btn-primary"/>--}%
                                    <g:submitToRemote   id="searchButton"
                                                        value="Search"
                                                        url="[controller: 'Car', action: 'searchAjax']"
                                                        update="carListTable"
                                                        onLoading="showSpinner(true)"
                                                        onComplete="addRowHandlers('#carsTable', '#myModal',loadCarInModal),
                                                                    updateTableHeader('#carsTable','#carTableHead'),
                                                                     showSpinner(false)"
                                                        class="btn btn-success"/>
                                </div>

                            %{--Add the spinner image--}%
                                <g:img id="spinner" style="display: none" uri="/images/spinner.gif"/>
                            </g:form>

                        </div>
                    </div>
                </div>
                <div class="panel-footer">
                    <h6 class="text-center">Cars Query Project | <a href="${createLink(controller: 'owner', action: 'searchForm')}">Go to Owners</a>
                    </h6>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-md-offset-1 col-md-10">
            <table class="table table-hover" id="carsTable">
                <thead>
                <tr id="carTableHead" class="active">
                    <th class="col-md-2">Id</th>
                    <th class="col-md-2">Make</th>
                    <th class="col-md-2">Model</th>
                    <th class="col-md-2">Year</th>
                    <th class="col-md-2">Car Plate</th>
                    <th class="col-md-2">Owner</th>
                </tr>
                </thead>
                <tbody id="carListTable">
                <g:render template="carTableRow" collection="${carList}" var="car"/>
                </tbody>
            </table>
        </div>
    </div>

    <div class="row">
        <div class="col-md-offset-1 col-md-10">
            <div class="panel panel-primary" id="#paginateButtons">
                <div class="panel-body">
                    <div class="col-md-offset-5 col-md-2">
                        <button id="buttonBack" onclick="decreaseOffset('#offset')" type="button" class="btn-default btn-lg">
                            <
                        </button>
                        <button id="buttonNext" onclick="increaseOffset('#offset')" type="button" class="btn-default btn-lg">
                            >
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>


    <g:render template="formPopup"/>

    </body>
</html>