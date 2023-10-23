<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="lifelong.model.*" %>
<html>
<head>
    <title>ข่าวสารประจำหลักสูตร</title>
    <link href="${pageContext.request.contextPath}/assets/css/list_open_course_style.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/admin/list_approve_member.css" rel="stylesheet">
    <jsp:include page="/WEB-INF/view/layouts/detail-all-style.jsp"/>
    <style>
        body{
            font-family: 'Prompt', sans-serif;
        }
        h1{
            font-family: 'Prompt', sans-serif;
            font-weight: 700 !important;
        }
        label{
            font-size: 12px;
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
                    <a href="${pageContext.request.contextPath}/" class="nav-item nav-link" style="font-size: 18px">หน้าหลัก</a>
                    <a href="${pageContext.request.contextPath}/search_course" class="nav-item nav-link" style="font-size: 18px">หลักสูตรการอบรม</a>
                    <a href="${pageContext.request.contextPath}/lecturer/<%=lecturer.getUsername()%>/add_roc" class="nav-item nav-link" style="font-size: 18px">ร้องขอหลักสูตร</a>
                    <a href="${pageContext.request.contextPath}/lecturer/<%=lecturer.getUsername()%>/list_request_open_course" class="nav-item nav-link" style="font-size: 18px">รายการร้องขอ</a>
                    <a href="${pageContext.request.contextPath}/lecturer/<%=lecturer.getUsername()%>/list_approve_request_open_course" class="nav-item nav-link active" style="font-size: 18px">หลักสูตรที่เปิดสอน</a>
                    <a href="${pageContext.request.contextPath}/view_activity" class="nav-item nav-link" style="font-size: 18px">ข่าวสารและกิจกรรม</a>
                    <a href="#" class="nav-item nav-link" style="font-size: 17px">อาจารย์</a>
                    <a href="${pageContext.request.contextPath}/doLogout" class="nav-item nav-link" style="font-size: 18px">ออกจากระบบ</a>
                </div>
            </div>
        </nav>
        <!-- Navbar End -->
        <div align="center" style="width: 100%; margin-top: 20px">
            <div align="left" style="width: 85%">
                    <%--                <h2>${request_name.course.name}</h2>--%>
                <div align="center" class="main_container">
                    <div class="course_div" style="align-self: flex-start;">
                        <div style="padding: 20px 20px 0px 20px" align="left">
                            <b><label style="font-size: 20px">${request_name.course.name}</label></b>
                            <label>${request_name.course.major.name}</label>
                            <hr>
                        </div>
                        <div style="padding: 0px 20px 20px 20px" align="left">
                            <b><label>วันเปิดรับสมัคร</label></b>
                            <div class="mb-3">
                                <div class="flex-container">
                                    <fmt:formatDate value="${request_name.startRegister}" pattern="dd/MM/yyyy" var="startRegister" />
                                    <fmt:formatDate value="${request_name.endRegister}" pattern="dd/MM/yyyy" var="endRegister" />
                                    <label>${startRegister} - ${endRegister}</label>
                                </div>
                            </div>
                            <b><label>วันประกาศผลการสมัคร</label></b>
                            <div class="mb-3">
                                <div class="flex-container">
                                    <fmt:formatDate value="${request_name.applicationResult}" pattern="dd/MM/yyyy" var="applicationResult" />
                                    <label>${applicationResult}</label>
                                </div>
                            </div>
                            <b><label>ระยะเวลาการเรียน</label></b>
                            <div class="mb-3">
                                <div class="flex-container">
                                    <fmt:formatDate value="${request_name.startStudyDate}" pattern="dd/MM/yyyy" var="startStudyDate" />
                                    <fmt:formatDate value="${request_name.endStudyDate}" pattern="dd/MM/yyyy" var="endStudyDate" />
                                    <label>${startStudyDate} - ${endStudyDate}</label>
                                </div>
                            </div>
                            <div class="mb-3">
                                <div class="flex-container">
                                    <label>จำนวนรับสมัคร ${request_name.numberOfAllRegistrations} / ${request_name.quantity} คน</label>
                                </div>
                            </div>
                            <b><label>รูปแบบการสอน</label></b>
                            <div class="mb-3">
                                <div class="flex-container">
                                    <label>${request_name.type_teach}</label>
                                </div>
                            </div>
                            <b><label>รูปแบบการสอน</label></b>
                            <div class="mb-3">
                                <div class="flex-container">
                                    <label>${request_name.type_learn}</label>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div style="width: 100%; align-self: flex-start;" align="left">
                        <div style="display: flex; width: 100%" >
                            <div align="left" style="width: 50%"><h3>ข่าวสารประจำหลักสูตร</h3></div>
                            <div align="right" style="width: 50%">
                            </div>
                        </div>
                        <hr>
                        <table class="table table-striped table-hover" style="width: 100%; align-self: flex-start;font-size: 12px">
                            <tr style="color: black">
                                <td style="width: 35%">รายการข่าวสาร และกิจกรรม</td>
                                <td style="width: 20%" align="center">วันที่เผยแพร่</td>
                                <td style="width: 25%" align="center">ประเภท</td>
                                <td style="width: 10%" align="center"></td>
                                <td style="width: 10%" align="center"></td>
                            </tr>
                            <c:choose>
                                <c:when test="${list_activity.size() == 0}">
                                    <tr>
                                        <td colspan="5" align="center">ไม่มีข้อมูล</td>
                                    </tr>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach var="list" items="${list_activity}">
                                        <tr>
                                            <td>${list.name}</td>
                                            <fmt:formatDate value="${list.date}" pattern="dd/MM/yyyy" var="date" />
                                            <td align="center">${date}</td>
                                            <td align="center">${list.type}</td>
                                            <td align="center">
                                                <a href="${pageContext.request.contextPath}/lecturer/<%=lecturer.getUsername()%>/private/${list.ac_id}/edit_course_activity_page/${list.requestOpenCourse.request_id}">
                                                    <button type="button" class="btn btn-outline-warning">แก้ไข</button>
                                                </a>
                                            </td>
                                            <td align="center">
                                                <input type="button" value="ยกเลิก"
                                                       onclick="if((confirm('คุณแน่ใจหรือว่าต้องการลบข่าวสารนี้?'))) { window.location.href='${pageContext.request.contextPath}/lecturer/<%=lecturer.getUsername()%>/${list.ac_id}/delete'; return false; }"
                                                       class="btn btn-outline-danger"/>
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
        alert("เพิ่มข้อมูลข่าวสารประจำหลักสูตรสำเร็จ");
    }else if (editParam === 'true') {
        alert("แก้ไขข้อมูลข่าวสารประจำหลักสูตรสำเร็จ");
    }else if (deleteParam === 'true') {
        alert("ลบข้อมูลข่าวสารประจำหลักสูตรสำเร็จ");
    }
</script>
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
