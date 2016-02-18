<%--
  Created by IntelliJ IDEA.
  User: myedro
  Date: 17/02/16
  Time: 14:05
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <!-- Latest compiled and minified CSS -->
        %{--<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous">--}%
        <!-- Latest compiled and minified JavaScript -->
        %{--<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous"></script>--}%
        <meta name="layout" content="main"/>
        <title>Query Car</title>
    </head>

    <body>

        <div class="row">
            <div class="col-sm-offset-3 col-sm-6">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <h2 class="text-center">Car Search</h2>
                    </div>
                    <div class="panel-body">
                        <g:form action="search">
                            <div class="form-group">
                                <label for="id">ID</label>
                                <g:textField name="id" class="form-control" placeholder="Car Id"/>
                            </div>

                            <div class="form-group">
                                <label for="year">Year</label>
                                <g:textField name="year" class="form-control" placeholder="Year"/>
                            </div>

                            <div class="form-group">
                                <label for="make">Make</label>
                                <g:textField name="make" class="form-control" placeholder="Year"/>
                            </div>

                            <div class="form-group">
                                <label for="model">Model</label>
                                <g:textField name="model" class="form-control" placeholder="Model"/>
                            </div>
                            <div class="col-sm-6 col-sm-offset-3">
                                <g:submitButton name="searchButton" value="Search" class="btn btn-primary btn-block"/>
                            </div>

                        </g:form>
                    </div>
                    <div class="panel-footer">
                        <h6 class="text-center">Cars Query Project</h6>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>