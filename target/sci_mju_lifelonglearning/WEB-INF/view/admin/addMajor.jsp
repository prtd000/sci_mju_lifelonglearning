<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 5/30/2023
  Time: 10:19 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<form:form action="${pageContext.request.contextPath}/course/save" modelAttribute="add_major" method="POST">
    <table>
        <tr>
            <td>
                <label>รหัสสาขา:</label>
            </td>
            <td><form:input path="major_id"/>
        </tr>
        <tr>
            <td>
                <label>=ชื่อสาขา:</label>
            </td>
            <td><form:input path="name"/>
            <td><input type="submit" value="บันทึก" class="save"/>
        </tr>
    </table>
</form:form>
</body>
</html>
