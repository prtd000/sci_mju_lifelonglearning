<%@ page import="lifelong.model.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>${title}</title>
    <link href="${pageContext.request.contextPath}/assets/css/list_open_course_style.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/list_all_course.css" rel="stylesheet">
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
    <table class="container">
        <tr align="center">
            <td class="lec_detail" align="left">
                <div class="list_course_detail">
                    <h1>รายการการร้องขอ</h1>
                </div>
            </td>
            <td class="list_course" align="left">
                <div class="list_course_detail" align="center">
                    <h1 align="left">รายการการร้องขอ</h1>
                    <div class="hr_line"></div>
                    <button id="FClick" class="tablinks" onclick="openList(event, 'course')">หลักสูตร</button>
                    <button class="tablinks" onclick="window.location.href='${pageContext.request.contextPath}/lecturer/${lecturer_id}/add_roc'; return false;"class="add-button">ร้องขอ</button>
                    <button class="tablinks" onclick="openList(event, 'list_request')">รายการร้องขอ</button>

                </div>

                <div id="course" class="tabcontent">
                    <table class="table table-striped table-hover">
                        <tr style="color: black">
                            <td class="td_request">รายละเอียดหลักสูตร</td>
                            <td class="td_certificate" align="center">ตัวอย่างเกียรติบัตร</td>
                            <td class="td_cancel" align="center">ผู้สมัคร</td>
                            <td class="td_edit" align="center">ข่าวสาร</td>
                            <td class="td_edit" align="center"></td>
                        </tr>

                        <c:forEach var="request_course" items="${requests_open_course}">
                            <c:if test="${request_course.requestStatus == 'ผ่าน'}">
                                <tr style="color: black">
                                    <td><p>${request_course.course.name}</p></td>
                                    <td><p>ดูตัวอย่าง</p></td>
                                    <td align="center">
                                        <input type="button" value="1/${request_course.quantity}"
                                               onclick="window.location.href='${pageContext.request.contextPath}/lecturer/${lecturer_id}/${request_course.request_id}/list_member_to_approve'; return false;"
                                        />
                                    </td>
                                    <td align="center">
                                        <input type="button" value="เพิ่มข่าวสาร"
                                               onclick="window.location.href='${pageContext.request.contextPath}/lecturer/${request_course.request_id}/add_course_activity'; return false;"
                                        />
                                        <input type="button" value="รายการข่าวสาร"
                                               onclick="window.location.href='${pageContext.request.contextPath}/lecturer/${request_course.request_id}/list_course_activity_news'; return false;"
                                        />
                                    </td>
                                    <td align="center">
                                        <input type="button" value="ยกเลิก"
                                               onclick="if((confirm('คุณแน่ใจหรือว่าต้องการลบหลักสูตรนี้?'))) { window.location.href='${pageContext.request.contextPath}/lecturer/<%=lecturer.getUsername()%>/${request_course.request_id}/delete_request_open_course'; return false; }"
                                               class="cancel-button"/>
                                    </td>
                                </tr>
                            </c:if>
                        </c:forEach>
                    </table>
                </div>

                <div id="request" class="tabcontent">
                    <h3>Paris</h3>
                    <p>Paris is the capital of France.</p>
                </div>

                <div id="list_request" class="tabcontent">
                    <table class="table table-striped table-hover">
                        <tr style="color: black">
                            <td class="td_request">รายละเอียดการร้องขอ</td>
                            <td class="td_edit" align="center">รายละเอียดคำร้อง</td>
                            <td class="td_cancel" align="center">ยกเลิกการร้องขอ</td>
                        </tr>

                        <c:forEach var="request_course" items="${requests_open_course}">
                            <c:if test="${request_course.requestStatus == 'รอดำเนินการ'}">
                                <tr style="color: black">
                                    <td><p>${request_course.course.name}</p></td>
                                    <td align="center"><a href="${pageContext.request.contextPath}/lecturer/<%=lecturer.getUsername()%>/${request_course.request_id}/update_page">แก้ไข</a></td>
                                    <td align="center">
                                        <input type="button" value="ยกเลิก"
                                               onclick="if((confirm('คุณแน่ใจหรือว่าต้องการลบการร้องขอนี้?'))) { window.location.href='${pageContext.request.contextPath}/lecturer/${lecturer_id}/${request_course.request_id}/delete_request_open_course'; return false; }"
                                               class="cancel-button"/>
                                    </td>
                                </tr>
                            </c:if>
                            <c:if test="${request_course.requestStatus == 'ไม่ผ่าน'}">
                                <tr style="color: black">
                                    <td><p>${request_course.course.name}</p></td>
                                    <td align="center"><p style="color: red">ไม่ผ่าน</p></td>
                                    <td align="center">
                                        <input type="button" value="ยกเลิก"
                                               onclick="if((confirm('คุณแน่ใจหรือว่าต้องการลบการร้องขอนี้?'))) { window.location.href='${pageContext.request.contextPath}/lecturer/${lecturer_id}/${request_course.request_id}/delete_request_open_course'; return false; }"
                                               class="cancel-button"/>
                                    </td>
                                </tr>
                            </c:if>
                        </c:forEach>
                    </table>
                </div>

            </td>
        </tr>

    </table>

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
<%-- เรียกใช้คำสั่ง Java เพื่อตรวจสอบว่ามีพารามิเตอร์ "error" หรือไม่ --%>
<% String errorParam = request.getParameter("error"); %>

<%-- ตรวจสอบว่ามีพารามิเตอร์ "error" และมีค่าเป็น "true" หรือไม่ --%>
<% if (errorParam != null && errorParam.equals("true")) { %>
<script>
    // แสดง alert ใน JavaScript
    alert("ไม่สามารถลบข้อมูลได้ เพราะมีผู้ที่สมัครหลักสูตรนี้อยู่");
</script>
<% } %>
</html>
