<%@ page import="java.text.SimpleDateFormat" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="lifelong.model.*" %>
<%--
  Created by IntelliJ IDEA.
  User: asus
  Date: 30/5/2566
  Time: 13:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>ยืนยันการหลักสูตรร้องขอ</title>
    <jsp:include page="/WEB-INF/view/layouts/detail-all-style.jsp"/>
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&display=swap" rel="stylesheet">

    <link href="${pageContext.request.contextPath}/assets/css/admin/style_addcourse.css" rel="stylesheet">

    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<style>
    body{
        font-family: 'Prompt', sans-serif;
    }
</style>
</head>
<script>
    function previewImages() {
        var preview = document.getElementById('imagePreview');
        var loadImg = document.getElementById('loadImg');
        var ac_img = document.getElementById('ac_img');
        var img_label = document.getElementById('img_label');
        var files = document.getElementById('ac_img').files;
        var maxImagesToShow = 3; // จำนวนรูปภาพที่ต้องการแสดงเป็นตัวอย่าง
        var remainingImages = files.length - maxImagesToShow; // จำนวนรูปภาพที่เหลือ

        preview.innerHTML = ''; // ล้างเนื้อหาที่แสดงรูปภาพตัวอย่างเก่า
        img_label.innerHTML = '';

        for (var i = 0; i < maxImagesToShow; i++) {
            var file = files[i];
            var reader = new FileReader();

            reader.onload = function (e) {
                var img = document.createElement('img');
                img.src = e.target.result;
                img.style.maxWidth = '200px'; // ตั้งความกว้างสูงสุดของรูปภาพ
                img.style.maxHeight = '200px'; // ตั้งความสูงสูงสุดของรูปภาพ
                preview.appendChild(img); // เพิ่มรูปภาพลงในตัวแสดงรูปภาพตัวอย่าง
            };

            reader.readAsDataURL(file); // อ่านไฟล์ภาพและแสดงผล
        }

        if (remainingImages > 0) {
            var remainingImagesText = 'และรูปภาพอีก ' + remainingImages + ' รูป';
            var message = document.createElement('p');
            message.textContent = remainingImagesText;
            // preview.appendChild(message);
            img_label.appendChild(message);
        }
        loadImg.style.display = 'none';
        preview.style.display = 'block';
        img_label.style.display = 'block';
    }

</script>
<style>
    label{
         font-family: 'Prompt', sans-serif;
         font-weight: 700 !important;
        font-size: 14px;
     }
</style>
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
                            <a href="${pageContext.request.contextPath}/course/<%=admin.getUsername()%>/list_request_open_course" class="nav-item nav-link active" style="font-size: 17px">รายการร้องขอ</a>
                            <a href="${pageContext.request.contextPath}/course/public/add_activity" class="nav-item nav-link" style="font-size: 17px">เพิ่มข่าวสารทั่วไป</a>
                            <a href="${pageContext.request.contextPath}/course/public/list_activity" class="nav-item nav-link" style="font-size: 17px">ข่าวสารและกิจกรรม</a>
                            <a href="#" class="nav-item nav-link" style="font-size: 17px">ผู้ดูแลระบบ</a>
                            <a href="${pageContext.request.contextPath}/doLogout" class="nav-item nav-link" style="font-size: 17px">ออกจากระบบ</a>
                        </div>
                    </div>
        </nav>
        <!-- Navbar End -->
        <div class="container">
            <div id="container">
                <form id="signUpForm" style="font-size: 14px" action="${pageContext.request.contextPath}/course/${admin_id}/view_request_open_course/${ROC_detail.request_id}/approve" method="POST">
                    <!-- step one -->
                    <div class="step">
                        <div class="mb-3" style="display:flex;">
                            <div align="left" style="width: 50%">
                                <label>รายละเอียดคำร้องขอ</label>
                                <div class="course-totalHours-container">
                                    <h4>${ROC_detail.course.name}</h4>
                                </div>
                                <label>${ROC_detail.course.major.name}</label>
                            </div>
                            <div align="right" style="width: 50%;align-self: flex-end;">
                                <fmt:formatDate value="${ROC_detail.requestDate}" pattern="dd/MM/yyyy" var="requestDate" />
                                <label>วันที่ร้องขอ : ${requestDate}</label>
                                <h4>${ROC_detail.lecturer.position} ${ROC_detail.lecturer.firstName} ${ROC_detail.lecturer.lastName}</h4>
                            </div>
                        </div>
                        <hr>
                        <div style="display:flex; width: 100%">
                            <div style="width: 35%">
                                <div>
                                    <label>${ROC_detail.course.course_type}</label>
                                </div>
                                <div style="display: flex">
                                    <div style="width: 50%;">
                                        <c:choose>
                                            <c:when test="${ROC_detail.course.fee != 0}">
                                                <fmt:parseNumber var="courseFee" type="number" value="${ROC_detail.course.fee}"/>
                                                <label><fmt:formatNumber value="${courseFee}"/> บาท</label>
                                            </c:when>
                                            <c:otherwise>
                                                <label>ไม่มีค่าธรรมเนียม</label>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    <div>ชั่วโมงเรียน : ${ROC_detail.course.totalHours} ชั่วโมง</div>
                                </div>
                                <hr>
                                <div style="border-radius: 20px;" align="center">
                                    <img src="${pageContext.request.contextPath}/uploads/course_img/${ROC_detail.course.img}" width="320px" style="border-radius: 10px; margin-bottom: 30px">
                                </div>
                            </div>
                            <div style="width: 65%; margin-left: 20px">
                                <table style="width: 100%; font-size: 14px">
                                    <tr>
                                        <td>
                                            <fmt:formatDate value="${ROC_detail.startRegister}" pattern="dd/MM/yyyy" var="startRegister" />
                                            <fmt:formatDate value="${ROC_detail.endRegister}" pattern="dd/MM/yyyy" var="endRegister" />
                                            <label>วันเปิดรับสมัคร : </label> <label>${startRegister} - ${endRegister}</label>
                                        </td>
                                        <td>
                                            <label>จำนวนรับสมัคร : </label><label>${ROC_detail.quantity} คน</label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <label>วันชำระเงิน : </label>
                                            <c:choose>
                                                <c:when test="${ROC_detail.course.fee != 0}">
                                                    <fmt:formatDate value="${ROC_detail.startPayment}" pattern="dd/MM/yyyy" var="startPayment" />
                                                    <fmt:formatDate value="${ROC_detail.endPayment}" pattern="dd/MM/yyyy" var="endPayment" />
                                                    <label>${startPayment} - ${endPayment}</label>
                                                </c:when>
                                                <c:otherwise>
                                                    <label>ไม่มีการชำระเงิน(ฟรี)</label>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <fmt:formatDate value="${ROC_detail.applicationResult}" pattern="dd/MM/yyyy" var="applicationResult" />
                                            <label>วันประกาศผลการสมัคร : </label><label>${applicationResult}</label>
                                        </td>
                                    </tr>
                                    <tr>
<%--                                        <td colspan="2">--%>
<%--                                            <hr>--%>
<%--                                            <fmt:formatDate value="${ROC_detail.startStudyDate}" pattern="dd/MM/yyyy" var="startStudyDate" />--%>
<%--                                            <fmt:formatDate value="${ROC_detail.endStudyDate}" pattern="dd/MM/yyyy" var="endStudyDate" />--%>
<%--                                            <c:set var="studyTime" value="${ROC_detail.studyTime}"/>--%>
<%--                                            <c:set var="parts" value="${fn:split(studyTime, ', ')}"/>--%>
<%--                                            <label>ระยะเวลาการเรียน : </label><label>${startStudyDate} - ${endStudyDate}</label>--%>
<%--                                            <label>เรียนทุกวัน ${ROC_detail.studyDay}</label><br>--%>
<%--                                            <label>เวลา : ${parts[0]} : ${parts[1]} น.</label>--%>
<%--                                            <hr>--%>
<%--                                        </td>--%>
                                        <td colspan="2">
                                            <c:set var="delimiter" value="$%"/>
                                            <c:set var="subText"
                                                   value="${fn:split(ROC_detail.studyTime, delimiter)}"/>
                                            <label>วันเวลาในการเรียน</label><br>
                                            <c:forEach var="ogText" items="${subText}">
                                                <c:set var="replaceSlash" value="${fn:replace(ogText, '/', ' ')}"/>
                                                <c:set var="newText" value="${fn:replace(replaceSlash, ',', ' - ')}"/>
                                                <p style="margin-bottom: 0px">${newText}</p>
                                            </c:forEach>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <label>รูปแบบการสอน : </label><label>${ROC_detail.type_teach}</label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <label>รูปแบบการเรียน : </label><label>${ROC_detail.type_learn}</label>
                                            <input type="hidden" name="type_learn" id="type_learn" value="${ROC_detail.type_learn}" />
                                        </td>
                                    </tr>
                                    <tr id="locationRow"  style="display: none;">
                                        <td colspan="2">
                                            <label>สถานที่เรียน : </label><label>${ROC_detail.location}</label>
                                        </td>
                                    </tr>
                                    <tr id="moocRow" style="display: none;">
                                        <td colspan="2">
                                            <label>Link Mooc : </label><label>${ROC_detail.linkMooc}</label>
                                        </td>
                                    </tr>
                                </table>
                                <hr>
                                <!-- start previous / next buttons -->
                                <div style="width: 100%" align="center" class="flex-container">
                                    <input type="button" name="statusResult" value="แก้ไขคำร้องขอ"
                                           onclick="cancelRequest();" style="width: 50%;font-family: 'Prompt', sans-serif;" class="cancel-button"/>
                                    <input type="button" name="statusResult" value="ยืนยันคำร้องขอ" onclick="confirmSubmit();" class="button-5" style="width: 50%;font-family: 'Prompt', sans-serif;"/>
                                </div>
                                <!-- end previous / next buttons -->
                            </div>
                        </div>
                    </div>
                </form>
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
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    var currentTab = 0; // Current tab is set to be the first tab (0)
    showTab(currentTab); // Display the current tab
    function showTab(n) {
        var x = document.getElementsByClassName("step");
        x[n].style.display = "block";
    }
    function confirmSubmit() {
        if (confirm('คุณแน่ใจหรือว่าต้องการดำเนินการตามคำร้องขอนี้?')) {
            document.getElementById('signUpForm').submit();
        }
    }

    function cancelRequest() {
        if (confirm('คุณแน่ใจหรือว่าต้องการยกเลิกคำร้องขอนี้?')) {
            $.ajax({
                type: "POST",
                url: "${pageContext.request.contextPath}/course/${admin_id}/view_request_open_course/${request_id}/cancel",
                data: {},
                success: function(response) {
                    // ทำอะไรก็ตามที่คุณต้องการหลังจากสำเร็จ
                    window.location.href = "${pageContext.request.contextPath}/course/${admin_id}/list_all_course"; // ตัวอย่างเท่านั้น
                },
                error: function(error) {
                    console.error("เกิดข้อผิดพลาดในการส่งคำขอ:", error);
                    // ทำอะไรก็ตามที่คุณต้องการในกรณีเกิดข้อผิดพลาด
                }
            });
        }
    }
</script>
<script>
    showHideFields()
    function showHideFields() {
        var typeLearnSelect = document.getElementById("type_learn");
        var locationRow = document.getElementById("locationRow");
        var moocRow = document.getElementById("moocRow");

        var selectedOption = typeLearnSelect.value;

        if (selectedOption === "เรียนในสถานศึกษา") {
            locationRow.style.display = "table-row";
            moocRow.style.display = "none";
        } else if (selectedOption === "เรียนออนไลน์") {
            locationRow.style.display = "none";
            moocRow.style.display = "table-row";
        } else if (selectedOption === "เรียนทั้งออนไลน์และในสถานศึกษา") {
            locationRow.style.display = "table-row";
            moocRow.style.display = "table-row";
        } else {
            locationRow.style.display = "none";
            moocRow.style.display = "none";
        }
    }
</script>
</html>
