<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="lifelong.model.*" %>
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
<%
    Admin admin = (Admin) session.getAttribute("admin");
    Member member = (Member) session.getAttribute("member");
    Lecturer lecturer = (Lecturer) session.getAttribute("lecturer");

    String flag = "";
    if (admin != null) {
        flag = "admin";
    } else if (lecturer != null) {
        flag = "lecturer";
    } else if (member != null) {
        flag = "member";
    } else {
        flag = "null";
    }
%>
<c:set var="flag" value="<%= flag %>"></c:set>
<c:choose>
    <c:when test="${flag.equals('lecturer')}">
        <jsp:include page="/WEB-INF/view/lecturer/nav_lecturer.jsp"/>
    </c:when>
    <c:when test="${flag.equals('member')}">
        <jsp:include page="/WEB-INF/view/member/nav_member.jsp"/>
    </c:when>
    <c:when test="${flag.equals('null')}">
        <jsp:include page="/WEB-INF/view/layouts/nav.jsp"/>
    </c:when>
</c:choose>
<c:choose>
    <c:when test="${flag.equals('admin')}">
        <% assert admin != null; %>
        <nav class="navbar navbar-expand-lg bg-white navbar-light shadow-sm py-3 py-lg-0 px-3 px-lg-0">
                <%--    <img src="${pageContext.request.contextPath}/assets/img/logo_navbar.png" style="height: 79px; margin-left: 57px; position: absolute;">--%>
                <%--    <div style="margin-left: 151px">--%>
                <%--        <a href="${pageContext.request.contextPath}/" class="navbar-brand ms-lg-5">--%>
                <%--            <h1 class="display-5 m-0 text-primary">LIFELONG<span class="text-secondary">LEARNING</span></h1>--%>
                <%--        </a>--%>
                <%--    </div>--%>
            <div style="margin: 0 0 5% 0">
                <a href="${pageContext.request.contextPath}/" class="navbar-brand ms-lg-5">
                    <img src="${pageContext.request.contextPath}/assets/img/logo_navbar.png"
                         style="height: 79px; margin-left: 57px; position: absolute;">
                </a>
            </div>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarCollapse" style="margin-right: 43px;">
                <div class="navbar-nav ms-auto py-0">
                    <a href="${pageContext.request.contextPath}/" class="nav-item nav-link">หน้าหลัก</a>
                    <a href="#" class="nav-item nav-link">เกี่ยวกับคณะ</a>
                        <%--            <div class="nav-item dropdown">--%>
                        <%--                <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">หลักสูตรการอบรม</a>--%>
                    <a href="${pageContext.request.contextPath}/course/<%=admin.getUsername()%>/list_all_course" class="nav-item nav-link active">หลักสูตรทั้งหมด</a>
                    <a href="${pageContext.request.contextPath}/course/public/list_activity" class="nav-item nav-link">ข่าวสารและกิจกรรม</a>
                    <a href="#" class="nav-item nav-link">Admin</a>
                    <a href="${pageContext.request.contextPath}/doLogout" class="nav-item nav-link">ออกจากระบบ</a>

                        <%--            <a href="${pageContext.request.contextPath}/login" class="nav-item nav-link">เข้าสู่ระบบ</a>--%>
                </div>
            </div>
        </nav>
        <!-- Navbar End -->
        <h2>${request_name.course.name}</h2>
        <h3>รายชื่อผู้สมัคร</h3>
        <%--<a href="${pageContext.request.contextPath}/course/add_course"><button>เพิ่มหลักสูตร</button></a>--%>
        <center>
            <table class="table table-striped table-hover" style="width: 70%">
                <tr style="color: black">
                    <td class="td_id_card">รหัสบัตรประชาชน</td>
                    <td class="td_name">ชื่อ - นามสกุล</td>
                    <td class="td_name">วันเวลาในการชำระเงิน</td>
                    <td class="td_name">เบอร์โทรศัพท์</td>
                    <td class="td_name"></td>
                </tr>

                <c:forEach var="registers" items="${register_detail}">
                    <tr style="color: black">
                        <td><p>${registers.member.idcard}</p></td>
                        <td><p>${registers.member.firstName} ${registers.member.lastName}</p></td>
                        <td align="center">
                            <c:forEach var="receipts" items="${receipt}">
                                <c:if test="${registers.invoice.invoice_id == receipts.invoice.invoice_id}">
                                    <p>${receipts.pay_time} ${receipts.pay_date}</p>
                                </c:if>
                            </c:forEach>
                        </td>
                        <td align="center">${registers.member.tel}</td>
                        <c:if test="${registers.invoice.approve_status == 'ผ่าน'}">
                            <td align="center" style="color: green">ผ่าน</td>
                        </c:if>
                        <c:if test="${registers.invoice.approve_status == 'ไม่ผ่าน'}">
                            <td align="center" style="color: red">ไม่ผ่าน</td>
                        </c:if>
                        <c:if test="${registers.invoice.approve_status == 'รอดำเนินการ'}">
                            <c:if test="${registers.invoice.pay_status == true}">
                                <td align="center"><input type="button" value="ดูข้อมูลการชำระเงิน"
                                                          onclick="window.location.href='${pageContext.request.contextPath}/course/${request_name.request_id}/view_payment_detail/${registers.invoice.invoice_id}'; return false;"/></td>
                            </c:if>
                            <c:if test="${registers.invoice.pay_status == false}">
                                <td align="center" style="color: orange">ยังไม่ได้ชำระเงิน</td>
                            </c:if>
                        </c:if>
                    </tr>
                </c:forEach>
            </table>
    </c:when>
    <c:when test="${flag.equals('null')}">
        <h1>กรุณา Log in ใหม่</h1>
        <a href="${pageContext.request.contextPath}/">กลับหน้าหลัก</a>
    </c:when>
    <c:otherwise>
        <h1>คุณไม่มีสิทธิในหน้านี้</h1>
    </c:otherwise>
</c:choose>
</body>
</html>
