<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 8/2/2023
  Time: 1:31 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <jsp:include page="/WEB-INF/view/layouts/detail-all-style.jsp"/>
</head>
<body>
<jsp:include page="/WEB-INF/view/layouts/nav.jsp"/>

<h1>My list Public Activity</h1>
<table>
    <c:forEach var="list" items="${list_activities}">
        <tr>
            <td>${list.date}</td>
            <td>${list.name}</td>
            <td>${list.type}</td>
            <td>${list.img}</td>
            <td>${list.detail}</td>
            <td>
                <a href="${pageContext.request.contextPath}/activity/public/${list.ac_id}/view_page"><button>ดูรายละเอียด</button></a>
            </td>
            <td>
                <input type="button" value="ยกเลิก"
                       onclick="if((confirm('คุณแน่ใจหรือว่าต้องการลบข่าวสารนี้?'))) { window.location.href='${pageContext.request.contextPath}/activity/${list.ac_id}/delete'; return false; }"
                       class="cancel-button"/>
            </td>
        </tr>
    </c:forEach>
</table>
</body>
</html>