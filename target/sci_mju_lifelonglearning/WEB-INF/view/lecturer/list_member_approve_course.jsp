<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="lifelong.model.*" %>
<html>
<head>
    <title>${title}</title>
    <link href="${pageContext.request.contextPath}/assets/css/list_open_course_style.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet">
    <jsp:include page="/WEB-INF/view/layouts/detail-all-style.jsp"/>
    <style>
        h1{
            font-family: 'Prompt', sans-serif;
            font-weight: 700 !important;
        }
    </style>
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
    <c:when test="${flag.equals('admin')}">
        <jsp:include page="/WEB-INF/view/admin/nav_admin.jsp"/>
    </c:when>
    <c:when test="${flag.equals('member')}">
        <jsp:include page="/WEB-INF/view/member/nav_member.jsp"/>
    </c:when>
    <c:when test="${flag.equals('null')}">
        <jsp:include page="/WEB-INF/view/layouts/nav.jsp"/>
    </c:when>
</c:choose>
<c:choose>
    <c:when test="${flag.equals('lecturer')}">
        <% assert admin != null; %>
        <!-- Navbar Start -->
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
        <a href="${pageContext.request.contextPath}/" class="nav-item nav-link active">หน้าหลัก</a>
        <a href="#" class="nav-item nav-link">เกี่ยวกับคณะ</a>
        <%--            <div class="nav-item dropdown">--%>
        <%--                <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">หลักสูตรการอบรม</a>--%>
        <a href="${pageContext.request.contextPath}/search_course" class="nav-item nav-link">หลักสูตรการอบรม</a>
        <a href="${pageContext.request.contextPath}/lecturer/<%=lecturer.getUsername()%>/list_request_open_course" class="nav-item nav-link">รายการร้องขอ</a>
        <%--                <div class="dropdown-menu m-0">--%>
        <%--                    <a href="#" class="dropdown-item">Reskill/Upskill</a>--%>
        <%--                    <a href="#" class="dropdown-item">อบรมระยะสั้น</a>--%>

        <%--                </div>--%>
        <%--            </div>--%>
        <a href="#" class="nav-item nav-link">ข่าวสารและกิจกรรม</a>
        <a href="#" class="nav-item nav-link">เกี่ยวกับเรา</a>
        <a href="#" class="nav-item nav-link">Lecturer</a>
        <a href="${pageContext.request.contextPath}/doLogout" class="nav-item nav-link">ออกจากระบบ</a>

        <%--            <a href="${pageContext.request.contextPath}/login" class="nav-item nav-link">เข้าสู่ระบบ</a>--%>
        </div>
        </div>
        </nav>
        <!-- Navbar End -->
<div align="center">
    <h1>${title}</h1>
    <h3>รายชื่อผู้ที่ผ่านการสมัคร</h3>
        <table class="table table-striped table-hover">
        <tr style="color: black">
            <td class="td_request">รหัสบัตรประชาชน</td>
            <td class="td_edit">ชื่อ - นามสกุล</td>
            <td class="td_cancel" align="center">สถานะการอบรม</td>
            <td class="td_cancel" align="center"></td>
            <td class="td_cancel" align="center"></td>
        </tr>
        <c:forEach var="list" items="${registers}">
            <form action="${pageContext.request.contextPath}/lecturer/${request_id}/update_Status_Member_Result/${list.register_id}" method="POST" onsubmit="return confirmAction();">
                <tr>
                <c:if test="${list.invoice.approve_status == 'ผ่าน'}">
                    <td>${list.member.idcard}</td>
                    <td>${list.member.firstName} ${list.member.lastName}</td>
                    <td align="center">
                        <c:set var="color" value="orange"></c:set>
                        <c:if test="${list.study_result == 'ผ่าน'}">
                            <c:set var="color" value="green"></c:set>
                        </c:if>
                        <c:if test="${list.study_result == 'ไม่ผ่าน'}">
                            <c:set var="color" value="red"></c:set>
                        </c:if>
                        <p style="color: ${color}">${list.study_result}</p>
                    </td align="center">
                        <%--                <td>--%>
                        <%--                    ${list.invoice.pay_status}--%>
                        <%--                </td>--%>
                    <c:choose>
                        <c:when test="${list.study_result == 'ผ่าน'}">
                            <td align="center">
                                <input type="submit" name="studyResult" value="ไม่ผ่านหลักสูตร"/>
                            </td>
                            <td align="center">
                                <input type="submit" name="studyResult" value="ผ่านหลักสูตร" style="display: none;"/>
                            </td>
                        </c:when>
                        <c:otherwise>
                            <td align="center">
                                <input type="submit" name="studyResult" value="ผ่านหลักสูตร"/>
                            </td>
                            <td align="center">
                                <input type="submit" name="studyResult" value="ไม่ผ่านหลักสูตร" style="display: none;"/>
                            </td>
                        </c:otherwise>
                    </c:choose>
                </tr>
                </c:if>
            </form>
        </c:forEach>
    </table>
    <input type="button" value="ย้อนกลับ"
           onclick="window.location.href='${pageContext.request.contextPath}/lecturer/${lecturer_id}/list_request_open_course'; return false;"
           class="cancel-button"/>
</div>
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

<script>
    window.addEventListener('DOMContentLoaded', (event) => {
        var button = document.getElementById('FClick');
        button.click()
    });
    function openList(evt, list_name) {
        var i, tabcontent, tablinks;
        tabcontent = document.getElementsByClassName("tabcontent");
        for (i = 0; i < tabcontent.length; i++) {
            tabcontent[i].style.display = "none";
        }
        tablinks = document.getElementsByClassName("tablinks");
        for (i = 0; i < tablinks.length; i++) {
            tablinks[i].className = tablinks[i].className.replace(" active", "");
        }
        document.getElementById(list_name).style.display = "block";
        evt.currentTarget.className += " active";
    }
</script>
<script>
    function confirmAction() {
        var result = confirm("คุณแน่ใจหรือไม่ว่าต้องการดำเนินการขั้นตอนต่อไปนี้?");
        if (result) {
            return true; // ถ้าผู้ใช้กด OK ให้ทำงานตามปกติ
        } else {
            return false; // ถ้าผู้ใช้กด Cancel ให้ยกเลิกการส่งฟอร์ม
        }
    }
</script>
</html>
