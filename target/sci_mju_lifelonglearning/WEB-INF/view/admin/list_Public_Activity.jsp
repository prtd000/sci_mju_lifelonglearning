<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="lifelong.model.*" %>
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
    <title>ข่าวสารทั่วไป</title>
    <jsp:include page="/WEB-INF/view/layouts/detail-all-style.jsp"/>
    <style>
        body{
            font-family: 'Prompt', sans-serif;
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
                            <a href="${pageContext.request.contextPath}/" class="nav-item nav-link" style="font-size: 17px">หน้าหลัก</a>
                            <a href="${pageContext.request.contextPath}/course/<%=admin.getUsername()%>/add_course" class="nav-item nav-link" style="font-size: 17px">เพิ่มหลักสูตร</a>
                            <a href="${pageContext.request.contextPath}/course/<%=admin.getUsername()%>/list_all_course" class="nav-item nav-link" style="font-size: 17px">หลักสูตรทั้งหมด</a>
                            <a href="${pageContext.request.contextPath}/course/<%=admin.getUsername()%>/list_request_open_course" class="nav-item nav-link" style="font-size: 17px">รายการร้องขอ</a>
                            <a href="${pageContext.request.contextPath}/course/public/add_activity" class="nav-item nav-link" style="font-size: 17px">เพิ่มข่าวสารทั่วไป</a>
                            <a href="${pageContext.request.contextPath}/course/public/list_activity" class="nav-item nav-link active" style="font-size: 17px">ข่าวสารและกิจกรรม</a>
                            <a href="#" class="nav-item nav-link" style="font-size: 17px">ผู้ดูแลระบบ</a>
                            <a href="${pageContext.request.contextPath}/doLogout" class="nav-item nav-link" style="font-size: 17px">ออกจากระบบ</a>
                        </div>
                    </div>
        </nav>
        <!-- Navbar End -->
        <div align="center" style="width: 100%; margin-top: 30px">
            <div class="tabcontent" align="left" style="width: 90%">
                <div style="display: flex; width: 100%" >
                    <div align="left" style="width: 50%"><h3>ข่าวสารและกิจกรรม</h3></div>
                    <div align="right" style="width: 50%"></div>
                </div>
                <hr>

                <div align="center" class="main_container">
                    <div id="Activity_News" class="tabcontent">
                        <table class="table table-striped table-hover" style="font-size: 12px">
                            <tr style="color: black">
                                <td style="width: 50%">รายการข่าว</td>
                                <td style="width: 15%" align="center">วันที่ออกข่าว</td>
                                <td style="width: 15%" align="center">ประเภทข่าวสาร</td>
                                <td style="width: 10%" align="center"></td>
                                <td style="width: 10%" align="center"></td>
                            </tr>
                            <c:choose>
                                <c:when test="${list_activities.size() == 0}">
                                    <tr>
                                        <td colspan="5" align="center">ไม่มีข้อมูล</td>
                                    </tr>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach var="list" items="${list_activities}">
                                        <tr>
                                            <td>${list.name}</td>
                                            <fmt:formatDate value="${list.date}" pattern="dd/MM/yyyy HH:mm:ss" var="date" />
                                            <td align="center">${date}</td>
                                            <td align="center">${list.type}</td>
                                            <td align="center">
                                                <a href="${pageContext.request.contextPath}/course/public/${list.ac_id}/edit_page">
                                                    <button style="font-size: 12px" type="button" class="btn btn-outline-warning">
                                                        <i class='fa fa-edit'></i>แก้ไข</button>
                                                </a>
                                            </td>
                                            <td align="center">
                                                <button style="font-size: 12px" type="button" class="btn btn-outline-danger" onclick="if((confirm('คุณแน่ใจหรือว่าต้องการลบข่าวสารนี้?'))) { window.location.href='${pageContext.request.contextPath}/course/<%=admin.getUsername()%>/${list.ac_id}/delete'; return false; }">
                                                    <i class="fas fa-window-close fa-lg"></i> ลบข่าวสาร
                                                </button>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                        </table>
                    </div>
                </div>
            </div>
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
    // ดึงค่าพารามิเตอร์ success จาก URL
    const urlParams = new URLSearchParams(window.location.search);
    const addParam = urlParams.get('addStatus');
    const editParam = urlParams.get('editStatus');
    const deleteParam = urlParams.get('deleteStatus');

    // ถ้ามีค่าเป็น 'true', แสดง Alert
    if (addParam === 'true') {
        alert("เพิ่มข้อมูลข่าวสารสำเร็จ");
    } else if (editParam === 'true') {
        alert("แก้ไขข้อมูลข่าวสารสำเร็จ");
    } else if (deleteParam === 'true') {
        alert("ลบข้อมูลข่าวสารสำเร็จ");
    }
</script>
</html>