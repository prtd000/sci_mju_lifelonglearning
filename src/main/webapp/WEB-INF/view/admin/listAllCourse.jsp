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
    <link href="${pageContext.request.contextPath}/assets/css/list_all_course.css" rel="stylesheet">
    <style>
        h1{
            font-family: 'Prompt', sans-serif;
            font-weight: 700 !important;
        }
        .bottom{
            height: 20%;
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
        <div align="center" class="main_container">
            <br>
            <br>
            <h1>${title}</h1>
            <table class="container">
                <tr align="center">
                        <%--            <td class="lec_detail" align="left">--%>
                        <%--                <div class="list_course_detail">--%>
                        <%--                    <h1>รายการการร้องขอ</h1>--%>
                        <%--                </div>--%>
                        <%--            </td>--%>
                    <td class="list_course" align="left">
                        <div class="list_course_detail" align="center">
                                <%--                    <h1 align="left">รายการการร้องขอ</h1>--%>
                            <div class="hr_line"></div>
                            <button id="FClick" class="tablinks" onclick="openList(event, 'course')">หลักสูตร</button>
                            <button class="tablinks" onclick="openList(event, 'list_request')">รายการร้องขอ</button>
                            <button class="tablinks" onclick="openList(event, 'Activity_News')">ข่าวสารและกิจกรรม</button>

                        </div>
                            <%--DIV แรก--%>
                        <div id="course" class="tabcontent">
                            <h3><b>หลักสูตรทั้งหมด</b></h3>
                            <hr>
                            <br>
                            <table style="width: 100%;">
                                <tr>
                                    <td align="left" style="width: 50%"><h5><b>หลักสูตรที่กำลังเปิดสอน</b></h5></td>
                                    <td align="right" style="width: 50%"><a href="${pageContext.request.contextPath}/course/<%=admin.getUsername()%>/add_course"><button>เพิ่มหลักสูตร</button></a></td>
                                </tr>
                            </table>
                            <table class="table table-striped table-hover">
                                <tr style="color: black">
                                    <td class="td_course_name">ชื่อหลักสูตร</td>
                                    <td class="td_status">ระยะเวลาในการเรียน</td>
                                    <td class="td_list_member"></td>
                                    <td class="td_detail"></td>
                                </tr>

                                <c:forEach var="course" items="${courses}">
                                    <c:if test="${course.status == 'เปิดสอน'}">
                                    <tr style="color: black">
                                        <td><p>${course.name}</p></td>
                                            <c:forEach var="request" items="${requests_open_course}">
                                                <c:if test="${course.course_id == request.course.course_id && request.requestStatus == 'ผ่าน'}">
                                                    <td>
                                                        <p>${request.startStudyDate} - ${request.endStudyDate}</p><br>
                                                    </td>
                                                    <td align="center"><a href="${pageContext.request.contextPath}/course/${request.request_id}/list_member_to_course"><button>ดูรายชื่อ</button></a></td>
                                                </c:if>
                                            </c:forEach>

                                        <td align="center"><a href="${pageContext.request.contextPath}/course/${course.course_id}/edit_course"><button>แก้ไข</button></a></td>
                                    </tr>
                                    </c:if>
                                </c:forEach>
                            </table>
                            <br>
                            <h5><b>หลักสูตรที่ยังไม่เปิดสอน</b></h5>
                            <table class="table table-striped table-hover">
                                <tr style="color: black">
                                    <td class="td_course_name">ชื่อหลักสูตร</td>
                                    <td class="td_status"></td>
<%--                                    <td class="td_list_member"></td>--%>
                                    <td class="td_detail"></td>
                                </tr>

                                <c:forEach var="course" items="${courses}">
                                    <c:if test="${course.status == 'ยังไม่เปิดสอน'}">
                                        <tr style="color: black">
                                            <td><p>${course.name}</p></td>
                                            <td><p>${course.course_type}</p></td>
<%--                                            <td align="center"><a><button>ดูรายชื่อ</button></a></td>--%>
                                            <td align="center"><a href="${pageContext.request.contextPath}/course/${course.course_id}/edit_course"><button>แก้ไข</button></a></td>
                                        </tr>
                                    </c:if>
                                </c:forEach>
                            </table>
                        </div>
                            <%--DIV ที่ 2--%>
                        <div id="list_request" class="tabcontent">
                            <h3>รายการร้องขอ</h3>
                            <table class="table table-striped table-hover">
                                <tr style="color: black">
                                    <td class="td_request">รายละเอียดการร้องขอ</td>
                                    <td class="td_edit" align="center">วันที่ร้องขอ</td>
                                    <td class="td_cancel" align="center"></td>
                                </tr>

                                <c:forEach var="request_course" items="${requests_open_course}">
                                    <c:if test="${request_course.requestStatus == 'รอดำเนินการ'}">
                                        <tr style="color: black">
                                            <td><p>${request_course.course.name}</p></td>
                                            <td align="center">${request_course.requestDate}</td>
                                            <td align="center">
                                                <input type="button" value="ดูรายละเอียด"
                                                       onclick="window.location.href='${pageContext.request.contextPath}/course/${admin_id}/view_request_open_course/${request_course.request_id}'; return false;"/>
                                            </td>
                                        </tr>
                                    </c:if>
                                </c:forEach>
                            </table>
                        </div>
                            <%--DIV ที่ 3--%>
                        <div id="Activity_News" class="tabcontent">
                            <h3>ข่าวสารและกิจกรรม</h3>
                            <input type="button" value="ข่าวสาร"onclick="window.location.href='${pageContext.request.contextPath}/course/public/add_activity'; return false;"class="add-button"/>
                            <table class="table table-striped table-hover">
                                <tr style="color: black">
                                    <td class="td_request">รายการข่าว</td>
                                    <td class="td_edit" align="center">วันที่ออกข่าว</td>
                                    <td class="td_cancel" align="center"></td>
                                    <td class="td_cancel" align="center"></td>
                                </tr>
                                <c:forEach var="list" items="${list_activities}">
                                    <tr>
                                        <td>${list.name}</td>
                                        <td>${list.date}</td>
                                        <td>
                                            <a href="${pageContext.request.contextPath}/course/public/${list.ac_id}/edit_page"><button>แก้ไข</button></a>
                                        </td>
                                        <td>
                                            <input type="button" value="ยกเลิก"
                                                   onclick="if((confirm('คุณแน่ใจหรือว่าต้องการลบข่าวสารนี้?'))) { window.location.href='${pageContext.request.contextPath}/course/${admin_id}/${list.ac_id}/delete'; return false; }"
                                                   class="cancel-button"/>
                                        </td>
                                    </tr>
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
</html>
