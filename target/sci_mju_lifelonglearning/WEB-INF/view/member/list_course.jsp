<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: asus
  Date: 11/7/2566
  Time: 16:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
    <h1>My list Course</h1>
    <table>
        <c:forEach var="list" items="${list_course}">
            <tr>
                <td>${list.requestOpenCourse.course.name}</td>
            </tr>
        </c:forEach>
    </table>
</body>
</html>
