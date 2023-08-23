<%@ page import="lifelong.model.Lecturer" %>
<%@ page import="lifelong.model.Admin" %>
<%@ page import="lifelong.model.Member" %>
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
                    <a href="#" class="nav-item nav-link">ข่าวสารและกิจกรรม</a>
                    <a href="#" class="nav-item nav-link">Admin</a>
                    <a href="${pageContext.request.contextPath}/doLogout" class="nav-item nav-link">ออกจากระบบ</a>

                        <%--            <a href="${pageContext.request.contextPath}/login" class="nav-item nav-link">เข้าสู่ระบบ</a>--%>
                </div>
            </div>
        </nav>
        <!-- Navbar End -->
        <h3>ตรวจสอบการชำระเงิน</h3>
        <c:if test="${payment != null}">
            <form action="${pageContext.request.contextPath}/course/${request_id}/<%=admin.getUsername()%>/view_payment_detail/${payment.invoice.invoice_id}/approve" method="POST">
                <h4>${payment.invoice.register.requestOpenCourse.course.name}</h4>
                <p>${payment.invoice.register.requestOpenCourse.course.major.name}</p>
                <hr>
                <table>
                    <tr>
                        <td colspan="2">หลักฐานการชำระเงิน</td>
                        <td rowspan="3">${payment.slip}</td>
                    </tr>
                    <tr>
                        <td>${payment.invoice.register.member.idcard}</td>
                        <td>${payment.invoice.register.member.firstName} ${payment.invoice.register.member.lastName}</td>
                    </tr>
                    <tr>
                        <td>ยอดชำระเงินทั้งหมด</td>
                        <td>${payment.invoice.register.requestOpenCourse.course.fee}0 บาท</td>
                    </tr>
                </table>
                <hr>
                <table>
                    <tr>
                        <td>วันที่โอนตามหลักฐานการชำระเงิน</td>
                        <td>${payment.pay_date}</td>
                    </tr>
                    <tr>
                        <td>เวลาที่โอนตามหลักฐานการชำระเงิน</td>
                        <td>${payment.pay_time}</td>
                    </tr>
                    <tr>
                        <td>โอนจากธนาคาร</td>
                        <td>${payment.banking}</td>
                    </tr>
                    <tr>
                        <td>จำนวนเงินที่ถูกโอน (ฺ฿)</td>
                        <td>${payment.total}</td>
                    </tr>
                    <tr>
                        <td>เงินโอนจากบัญชีธนาคารเลขที่ (4 หลักสุดท้าย)</td>
                        <td>${payment.last_four_digits}</td>
                    </tr>

                </table>
                <td align="center"><input type="submit" value="ยืนยันการสมัคร"/></td>
            </form>
        </c:if>
        <c:if test="${payment == null}">
            <h1>ยังไม่มีการชำระเงิน</h1>
        </c:if>
        <td align="center"><input type="button" value="ย้อนกลับ"
                                  onclick="window.location.href='${pageContext.request.contextPath}/course/${request_id}/list_member_to_course'; return false;"/></td>
        <td align="center"><input type="button" value="ยกเลิก"/></td>
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
