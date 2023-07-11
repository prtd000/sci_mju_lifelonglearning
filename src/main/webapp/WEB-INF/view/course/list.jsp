<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>${title}</title>
    <link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet">
</head>
<body>
<h1>${title}</h1>
<div class="container">
    <jsp:include page="/WEB-INF/view/layouts/nav.jsp"/>
    <table>
        <thead>
        <tr>
            <th>รหัสหลักสูตร</th>
            <th>ชื่อหลักสูตร</th>
            <th>ราคา</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="course" items="${courses}">
            <tr>
                <td>${course.course_id}</td>
                <td>${course.name}</td>
                <td class="number">
                    <fmt:formatNumber type="number" value="${course.fee}"/>
                </td>
            </tr>
        </c:forEach>
        </tbody>
<%--        <c:forEach var="course" items="${courses}">--%>
    </table>
</div>
<jsp:include page="/WEB-INF/view/layouts/footer.jsp"/>
</body>
</html>