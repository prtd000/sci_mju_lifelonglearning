<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="lifelong.model.Admin" %>
<%@ page import="lifelong.model.Member" %>
<%@ page import="lifelong.model.Lecturer" %>
<html>
<head>
    <title>${title}</title>
<%--    <link href="${pageContext.request.contextPath}/assets/css/list_open_course_style.css" rel="stylesheet">--%>
    <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/admin/listAllCourse.css" rel="stylesheet">

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
                            <a href="${pageContext.request.contextPath}/" class="nav-item nav-link" style="font-size: 17px">หน้าหลัก</a>
                            <a href="#" class="nav-item nav-link" style="font-size: 18px">เกี่ยวกับคณะ</a>
                            <a href="${pageContext.request.contextPath}/course/<%=admin.getUsername()%>/add_course" class="nav-item nav-link" style="font-size: 17px">เพิ่มหลักสูตร</a>
                            <a href="${pageContext.request.contextPath}/course/<%=admin.getUsername()%>/list_all_course" class="nav-item nav-link active" style="font-size: 17px">หลักสูตรทั้งหมด</a>
                            <a href="${pageContext.request.contextPath}/course/<%=admin.getUsername()%>/list_request_open_course" class="nav-item nav-link" style="font-size: 17px">รายการร้องขอ</a>
                            <a href="${pageContext.request.contextPath}/course/public/add_activity" class="nav-item nav-link" style="font-size: 17px">เพิ่มข่าวสารทั่วไป</a>
                            <a href="${pageContext.request.contextPath}/course/public/list_activity" class="nav-item nav-link" style="font-size: 17px">ข่าวสารและกิจกรรม</a>
                            <a href="#" class="nav-item nav-link" style="font-size: 17px">ผู้ดูแลระบบ</a>
                            <a href="${pageContext.request.contextPath}/doLogout" class="nav-item nav-link" style="font-size: 17px">ออกจากระบบ</a>
                        </div>
                    </div>
        </nav>
<!-- Navbar End -->
        <div align="center" class="main_container">
            <br>
            <br>
            <h1>${title}</h1>
            <table class="container">
                <tr align="center">
                    <td class="list_course" align="center">
                            <%--DIV แรก--%>
                        <div id="course" class="tabcontent" align="left">
                            <h3><b>หลักสูตรทั้งหมด</b></h3>
                            <hr>
                            <br>
                            <table style="width: 100%;">
                                <tr>
                                    <td align="left" style="width: 50%"><h5><b>หลักสูตรที่กำลังเปิดสอน</b></h5></td>
                                    <td align="right" style="width: 50%"></td>
                                </tr>
                            </table>
                            <table class="table table-striped table-hover">
                                <tr style="color: black">
                                    <td class="td_ap_course_name">ชื่อหลักสูตร</td>
                                    <td class="td_status" align="center">ระยะเวลาในการเรียน</td>
                                    <td class="td_list_member" align="center">รายชื่อผู้สมัคร</td>
                                </tr>

                                <c:forEach var="course" items="${courses}">
                                    <c:if test="${course.status == 'เปิดสอน'}">
                                        <tr style="color: black">
                                            <td><p>${course.name}</p></td>
                                                <c:forEach var="request" items="${requests_open_course}">
                                                    <fmt:formatDate value="${request.startStudyDate}" pattern="dd/MM/yyyy" var="startStudyDate" />
                                                    <fmt:formatDate value="${request.endStudyDate}" pattern="dd/MM/yyyy" var="endStudyDate" />
                                                    <c:if test="${course.course_id == request.course.course_id && request.requestStatus == 'ผ่าน'}">
                                                        <td align="center">
                                                            <p>${startStudyDate} - ${endStudyDate}</p><br>
                                                        </td>
                                                        <td align="center"><a href="${pageContext.request.contextPath}/course/${request.request_id}/list_member_to_course">
                                                            <button class="button-35" role="button">${request.numberOfAllRegistrations}/${request.quantity}</button>
                                                        </a></td>
                                                    </c:if>
                                                </c:forEach>
                                        </tr>
                                    </c:if>
                                </c:forEach>
                            </table>
                            <br>
                            <h5><b>หลักสูตรที่ยังไม่เปิดสอน</b></h5>
                            <table class="table table-striped table-hover">
                                <tr style="color: black">
                                    <td class="td_course_name">ชื่อหลักสูตร</td>
                                    <td class="td_type_learn"></td>
<%--                                    <td class="td_list_member"></td>--%>
                                    <td class="td_detail"></td>
                                </tr>

                                <c:forEach var="course" items="${courses}">
                                    <c:if test="${course.status == 'ยังไม่เปิดสอน'}">
                                        <tr style="color: black">
                                            <td><p>${course.name}</p></td>
                                            <td align="center"><p>${course.course_type}</p></td>
<%--                                            <td align="center"><a><button>ดูรายชื่อ</button></a></td>--%>
                                            <td align="center">
                                                <a href="${pageContext.request.contextPath}/course/${course.course_id}/edit_course">
                                                    <button type="button" class="btn btn-outline-warning">แก้ไข</button>
                                                </a>
                                            </td>
                                        </tr>
                                    </c:if>
                                </c:forEach>
                            </table>
                        </div>
                    </td>
                </tr>
            </table>
            <br>
            <br>
            <br>
            <br>
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
<br>
<br>
<br>
<br>
</body>
</html>
