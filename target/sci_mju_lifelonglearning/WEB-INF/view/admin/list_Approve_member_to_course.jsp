<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 8/9/2023
  Time: 4:24 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <%--    <link href="${pageContext.request.contextPath}/assets/css/list_open_course_style.css" rel="stylesheet">--%>
    <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/list_all_course.css" rel="stylesheet">
    <style>
        h1{
            font-family: 'Prompt', sans-serif;
            font-weight: 700 !important;
        }
    </style>
    <jsp:include page="/WEB-INF/view/layouts/detail-all-style.jsp"/>
</head>
<body>
<jsp:include page="/WEB-INF/view/layouts/nav.jsp"/>
<h2>${request_name.course.name}</h2>
<h3>รายชื่อผู้สมัคร</h3>
<%--<a href="${pageContext.request.contextPath}/course/add_course"><button>เพิ่มหลักสูตร</button></a>--%>
<center>
<table class="table table-striped table-hover" style="width: 70%">
    <tr style="color: black">
        <td class="td_id_card">รหัสบัตรประชาชน</td>
        <td class="td_name">ชื่อ - นามสกุล</td>
        <td class="td_view"></td>
    </tr>

    <c:forEach var="registers" items="${register_detail}">
        <tr style="color: black">
            <td><p>${registers.member.idcard}</p></td>
            <td><p>${registers.member.firstName} ${registers.member.lastName}</p></td>
            <td align="center"><input type="button" value="ดูข้อมูลการชำระเงิน"
                                      onclick="window.location.href='${pageContext.request.contextPath}/course/${request_name.request_id}/view_payment_detail/${registers.invoice.invoice_id}'; return false;"/></td>
<%--            <td align="center"><a href="${pageContext.request.contextPath}/course/${course.course_id}/course_detail"><button>ดูรายละเอียด</button></a></td>--%>
        </tr>
    </c:forEach>
</table>
</center>
</body>
</html>
