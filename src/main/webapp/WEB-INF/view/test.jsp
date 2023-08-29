<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 8/28/2023
  Time: 9:00 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Upload Image</title>
</head>
<body>
<form action="${pageContext.request.contextPath}/course/add_Test_ListImg" method="post" enctype="multipart/form-data">
    <input type="file" name="imageFile" multiple>
    <input type="submit" value="Upload Image">
</form>
</body>
</html>

