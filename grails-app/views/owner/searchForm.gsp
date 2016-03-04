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
    <r:require module="ownerSearchForm"/>
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
                        <g:form>
                            <g:render template="formFields"/>

                            <input type="hidden" name="offset" id="offset" value="0"/>

                            <label class="radio-inline">
                                <input type="radio" name="inlineRadioOptions" id="inlineRadio1" value="JSON"> JSON
                            </label>

                            <label class="radio-inline">
                                <input type="radio" name="inlineRadioOptions" id="inlineRadio2" value="View" checked> View
                            </label>

                            <div class="form-group">
                                <button type="button" class="btn btn-primary" onclick="loadNewForm('#myModal','#ownerId')">New Owner</button>
                            </div>
                            %{--Add the spinner image--}%
                            <g:img id="spinner" style="display: none" uri="/images/spinner.gif"/>
                        </g:form>

                        <div class="form-group">
                            <button id="searchButton" value="Search" class="btn btn-success"
                                    onclick="updateTableContent('#ownerListTable')">Search</button>
                        </div>

                    </div>
                </div>
            </div>
            <div class="panel-footer">
                <h6 class="text-center">Cars Query Project | <a href="${createLink(controller: 'car', action: 'searchForm')}">Go to Cars</a></h6>
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
                <g:render template="ownerTableRow" collection="${ownerList}" var="owner"/>
            </tbody>
        </table>
    </div>
</div>

<!--Added pagination for owners-->
<div class="row">
    <div class="col-md-offset-1 col-md-10">
        <div class="panel panel-primary" id="paginateButtons">
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