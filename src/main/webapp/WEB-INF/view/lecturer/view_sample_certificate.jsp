<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 9/27/2023
  Time: 11:34 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="lifelong.model.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <title>ดูตัวอย่างเกียรติบัตร</title>
    <jsp:include page="/WEB-INF/view/layouts/detail-all-style.jsp"/>
    <!-- google font -->
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&display=swap" rel="stylesheet">

    <link href="${pageContext.request.contextPath}/assets/css/admin/style_addcourse.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/lecturer/certificate.css" rel="stylesheet">
    <style>
        /*body{*/
        /*    font-family: 'Prompt', sans-serif;*/
        /*}*/
    </style>
</head>
<script>
    function previewImage(input) {
        var preview = document.getElementById('preview');
        var fileInput = document.getElementById('fileInput');

        if (input.files && input.files[0]) {
            var reader = new FileReader();

            reader.onload = function (e) {
                preview.src = e.target.result;
                preview.style.display = 'block';

            };

            reader.readAsDataURL(input.files[0]);
        } else {
            preview.src = '';
            preview.style.display = 'none';
        }
    }
</script>
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
                    <a href="${pageContext.request.contextPath}/lecturer/<%=lecturer.getUsername()%>/add_roc" class="nav-item nav-link" style="font-size: 18px">ร้องขอหลักสูตร</a>
                    <a href="${pageContext.request.contextPath}/lecturer/<%=lecturer.getUsername()%>/list_request_open_course" class="nav-item nav-link" style="font-size: 18px">รายการร้องขอ</a>
                    <a href="${pageContext.request.contextPath}/lecturer/<%=lecturer.getUsername()%>/list_approve_request_open_course" class="nav-item nav-link active" style="font-size: 18px">หลักสูตรที่เปิดสอน</a>
                    <a href="${pageContext.request.contextPath}/view_activity" class="nav-item nav-link" style="font-size: 18px">ข่าวสารและกิจกรรม</a>
                    <a href="${pageContext.request.contextPath}/doLogout" class="nav-item nav-link" style="font-size: 18px">ออกจากระบบ</a>
                </div>
            </div>
        </nav>
        <!-- Navbar End -->
        <div style="width: 100%;" align="center">
            <form onsubmit="return confirmAction();" action="${pageContext.request.contextPath}/lecturer/${lecturer_id}/${request_id}/update_signature" method="POST" enctype="multipart/form-data">
                <table style="width: 70%">
                    <tr>
                        <td style="width: 50%">
                            <div id="signUpForm" class="flex-container">
                                <div>
                                    <h3>ตัวอย่างเกียรติบัตร</h3>
                                    <hr>
                                    <div style="position: relative;">
                                        <img src="${pageContext.request.contextPath}/uploads/course_img/Certificate_Model_2.png" style="width: 100%" alt="certificate">
                                        <table style="position: absolute; top: 0; left: 0; width: 100%; height: 100%">
                                            <tr>
                                                <td style="width: 17%"><p class="label-cer"></p></td>
                                                <td style="width: 23%"><p class="label-cer"></p></td>
                                                <td style="width: 15%"><p class="label-cer"></p></td>
                                                <td style="width: 33%"><p class="label-cer"></p></td>
                                                <td style="width: 12%"><p class="label-cer"></p></td>
                                            </tr>
                                            <tr>
                                                <td colspan="5"><p class="label-cer"></p></td>
                                            </tr>
                                            <tr>
                                                <td colspan="5"><p class="label-cer"></p></td>
                                            </tr>
                                            <tr>
                                                <td colspan="5"><p class="label-cer"></p></td>
                                            </tr>
                                            <tr>
                                                <td colspan="5"><p class="label-cer"></p></td>
                                            </tr>
                                            <tr align="center">
                                                <td style="width: 17%" colspan="5"><p class="label-cer" style="margin-top: 19px;">${request.lecturer.firstName} ${request.lecturer.lastName}</p></td>
                                            </tr>
                                            <tr>
                                                <td colspan="5"><p class="label-cer"></p></td>
                                            </tr>
                                            <tr align="center">
                                                <td style="width: 17%" colspan="5"><p style="font-size: 15px">${request.course.name}</p></td>
                                            </tr>
                                            <tr>
                                                <td></td>
                                                <td align="center">
                                                    <input type="hidden" name="original_signature" value="${request.signature}" />
                                                    <c:choose>
                                                        <c:when test="${request.signature != ''}">
                                                            <img src="${pageContext.request.contextPath}/uploads/request_open_course/signature/${request.signature}" id="preview" alt="Image Preview" style="height: 40px; margin-left: 10px; border-radius: 10px">
                                                        </c:when>
                                                        <c:otherwise>
                                                            <img src="${pageContext.request.contextPath}/uploads/course_img/gallery.png" id="preview" alt="Image Preview" style="height: 40px; margin-left: 10px; border-radius: 10px">
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td></td>
                                                <td align="center">
                                                    <p style="margin-top: 5px;font-size: 13px">ผศ.ดร.ฐปน ชื่นบาล</p>
                                                </td>
                                                <td></td>
                                            </tr>
                                            <tr>
                                                <td></td>
                                                <td align="center">
                                                    <p style="margin-top: 1px;font-size: 12px">(${request.lecturer.position} ${request.lecturer.firstName} ${request.lecturer.lastName})</p>
                                                </td>
                                                <td></td>
                                                <td align="center">
                                                    <p style="margin-top: 1px;font-size: 12px">(ผู้ช่วยศาสตราจารย์ ดร.ฐปน ชื่นบาล)</p>
                                                </td>
                                                <td></td>
                                            </tr>
                                            <tr>
                                                <td colspan="5"><p class="label-cer"></p></td>
                                            </tr>
                                            <tr>
                                                <td colspan="5"><p class="label-cer"></p></td>
                                            </tr>
                                            <tr>
                                                <td colspan="5"><p class="label-cer"></p></td>
                                            </tr>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </td>
                        <td style="width: 25%">
                            <div id="menuForm" class="flex-container">
                                <div>
                                    <h4>อัพโหลดเกียรติบัตร</h4>
                                    <hr>
                                    <div class="mb-3" align="center">
                                        <div class="form-floating">
                                            <input name="signature" type="file" id="fileInput" accept="image/*" onchange="previewImage(this)" class="form-control"/>
                                        </div>
                                    </div>
                                    <input type="submit" value="อัพโหลด">
                                </div>
                            </div>
                        </td>
                    </tr>
                </table>
            </form>
        </div>
        <%--      <div style="width: 100%" align="center" class="flex-container">--%>
        <%--        --%>
        <%--        --%>
        <%--      </div>--%>
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
    const updateSigParam = urlParams.get('updateSig');

    // ถ้ามีค่าเป็น 'true', แสดง Alert
    if (updateSigParam === 'true') {
        alert("แก้ไขข้อมูลลายเซ็นสำเร็จ");
    }
</script>
<script>
    const course_img = document.getElementById("preview").src;
    var currentTab = 0; // Current tab is set to be the first tab (0)
    for (currentTab ; currentTab < 2 ; currentTab++){
        showTab(currentTab); // Display the current tab
    }
    function confirmAction() {
        var result = confirm("คุณแน่ใจหรือไม่ว่าต้องการแก้ไขลายเซ็น?");
        if (result) {
            return true; // ถ้าผู้ใช้กด OK ให้ทำงานตามปกติ
        } else {
            return false; // ถ้าผู้ใช้กด Cancel ให้ยกเลิกการส่งฟอร์ม
        }
    }
</script>
</html>
