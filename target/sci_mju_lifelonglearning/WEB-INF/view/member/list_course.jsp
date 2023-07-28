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
    <jsp:include page="/WEB-INF/view/layouts/detail-all-style.jsp"/>
</head>
<body>
<jsp:include page="/WEB-INF/view/layouts/nav.jsp"/>

    <h1>My list Course</h1>
    <h1>${mem_username.firstName}</h1>
    <table>
        <c:forEach var="list" items="${list_course}">
            <tr>
                <td>${list.requestOpenCourse.course.name}</td>
                <c:set var="txtstt" value="${list.study_result}"></c:set>
                <c:if var="stt" test="${txtstt == false}">
                    <c:set var="txtstt" value="อยู่ระหว่างเรียน"></c:set>
                </c:if>
                <c:if var="stt" test="${txtstt == true}">
                    <c:set var="txtstt" value="ผ่านหลักสูตร"></c:set>
                </c:if>
                <td>${txtstt}</td>
                <td>
                    <button>ดูเกียรติบัตร</button>
                </td>
            </tr>
        </c:forEach>
    </table>
</body>
</html>
