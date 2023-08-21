<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 8/16/2023
  Time: 9:33 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
    <form action="${pageContext.request.contextPath}/course/addPDF" method="post" enctype="multipart/form-data">
        <input type="text" name="detail" placeholder="Image Detail"><br>
        <input type="file" name="file"><br>
        <button type="submit">Upload Image</button>
    </form>
    <c:forEach var="list" items="${list_img}">
        <label>รูปภาพ :
            <img src="${pageContext.request.contextPath}/assets/img/addImg/${list.img}" alt="course_image" class="c_img" style="width: 20%">
        </label><br>
<%--        <c:set var="path" value="${pageContext.request.contextPath}/${list.img}"></c:set>--%>
<%--        path : ${path}<br>--%>
        <label>รายละเอียด : ${list.detail}</label><br>
    </c:forEach>

</body>
</html>
