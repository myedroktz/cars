<%--
  Created by IntelliJ IDEA.
  User: myedro
  Date: 17/02/16
  Time: 14:05
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <title>Query Car</title>
    </head>

    <body>
        <g:form controller="CarRest" action="searchResult">
            <fieldset>

                <div>
                    <label for="id">ID</label>
                    <g:textField name="id"/>
                </div>

                <div>
                    <label for="year">Year</label>
                    <g:textField name="year"/>
                </div>

                <div>
                    <label for="make">Make</label>
                    <g:textField name="make"/>
                </div>

                <div>
                    <label for="model">Model</label>
                    <g:textField name="model"/>
                </div>

            </fieldset>

            <fieldset>
                <g:submitButton name="search" value="Search"/>
            </fieldset>

        </g:form>

    </body>
</html>