<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<form:form method="POST" action="/upload" enctype="multipart/form-data">
    <input type="file" name="imageFile" accept="image/*" />
    <input type="submit" value="Upload" />
</form:form>
</body>
</html>
