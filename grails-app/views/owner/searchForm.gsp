<%--
  Created by IntelliJ IDEA.
  User: myedro
  Date: 25/02/16
  Time: 10:18
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Owner List</title>
</head>

<body>
    <g:each in="${ownerList}" var="owner">
        ${'id: ' +owner.id + ' dni:' + owner.dni + owner.name + owner.lastName}
        <br/>
    </g:each>
</body>
</html>