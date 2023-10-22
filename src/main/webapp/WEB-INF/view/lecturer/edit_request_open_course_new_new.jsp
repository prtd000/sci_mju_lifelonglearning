<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 10/7/2023
  Time: 12:17 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="lifelong.model.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="th" uri="http://www.springframework.org/tags/form" %>
<html>
<head>
    <title>ร้องขอหลักสูตร</title>
    <jsp:include page="/WEB-INF/view/layouts/detail-all-style.jsp"/>
    <!-- google font -->
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&display=swap" rel="stylesheet">
    <link href="https://cdn.quilljs.com/1.3.6/quill.snow.css" rel="stylesheet">
    <script src="https://cdn.quilljs.com/1.3.6/quill.js"></script>
    <link href="https://fonts.googleapis.com/css?family=Raleway" rel="stylesheet">

    <script>
        function previewImage(input) {
            var preview = document.getElementById('preview');
            var displayPreview = document.getElementById('displayPreview');
            var fileInput = document.getElementById('fileInput');

            var file = input.files[0];

            if (!file) {
                alert("กรุณาเลือกรูปภาพ");
                return;
            }

            var allowedExtensions = /(\.png|\.jpg|\.jpeg)$/i;
            var maxFileSize = 2 * 1024 * 1024; // 2MB

            if (!allowedExtensions.exec(file.name)) {
                alert("รูปภาพต้องเป็นไฟล์นามสกุล png, jpg, หรือ jpeg เท่านั้น");
                input.value = "";
                return;
            }else {
                document.getElementById("invalidImg").innerHTML = "";
            }

            if (file.size > maxFileSize) {
                alert("ขนาดไฟล์รูปภาพต้องไม่เกิน 2MB");
                input.value = "";
                return;
            }

            if (input.files && input.files[0]) {
                var reader = new FileReader();

                reader.onload = function (e) {
                    preview.src = e.target.result;
                    preview.style.display = 'block';

                    displayPreview.src = e.target.result;
                    displayPreview.style.display = 'block';
                };

                reader.readAsDataURL(input.files[0]);
            } else {
                preview.src = '';
                preview.style.display = 'none';

                displayPreview.src = '';
                displayPreview.style.display = 'none';
            }
        }

    </script>

    </script>
    <!--Internal CSS start-->
    <style>
        body{
            font-family: 'Prompt', sans-serif;
        }
        #editor {
            width: 100%;
            height: 500px;
            border: 1px solid #ccc;
            padding: 10px;
            font-size: 16px;
        }
        .toolbar {
            background-color: #f2f2f2;
            padding: 5px;
        }
        .toolbar button {
            margin: 5px;
            padding: 3px 10px;
            font-size: 14px;
        }
    </style>
    <style>
        * {
            box-sizing: border-box;
        }

        body {
            background-color: #f1f1f1;
        }

        #regForm {
            background-color: #ffffff;
            margin: 100px auto;
            font-family: Raleway;
            padding: 40px;
            width: 70%;
            min-width: 300px;
            border-radius: 15px;
        }

        h1 {
            text-align: center;
        }

        input {
            padding: 10px;
            width: 100%;
            font-size: 12px;
            font-family: Raleway;
            border: 1px solid #aaaaaa;
        }

        /* Mark input boxes that gets an error on validation: */
        input.invalid {
            background-color: #ffdddd;
        }

        /* Hide all steps by default: */
        .tab {
            display: none;
        }

        button {
            background-color: #04AA6D;
            color: #ffffff;
            border: none;
            padding: 10px 20px;
            font-size: 17px;
            font-family: Raleway;
            cursor: pointer;
        }

        button:hover {
            opacity: 0.8;
        }

        #prevBtn {
            background-color: #bbbbbb;
        }

        /* Make circles that indicate the steps of the form: */
        .step {
            height: 15px;
            width: 15px;
            margin: 0 2px;
            background-color: #bbbbbb;
            border: none;
            border-radius: 50%;
            display: inline-block;
            opacity: 0.5;
        }

        .step.active {
            opacity: 1;
        }

        /* Mark the steps that are finished and valid: */
        .step.finish {
            background-color: #04AA6D;
        }
        .flex-div-container,.objective-container{
            width: 100%;
            display: flex;
            align-items: center;
        }
        .course_detail,.course_detail_tap2{
            border: 1px solid;
            border-radius: 20px;
            height: 100%;
            padding: 30px;
            margin-left: 15px;
            margin-right: 20px;
        }
        input{
            font-family: 'Prompt', sans-serif;
        }
    </style>
    <style>
        .checkbox-wrapper-24 .checkbox {
            display: table-cell;
            width: 100%;
            height: 100%;
            vertical-align: middle;
            text-align: center;
        }

        .checkbox-wrapper-24 label {
            display: inline-block;
            color: #333;
            cursor: pointer;
            /*position: relative;*/
        }
        .checkbox-wrapper-24 label span {
            display: inline-block;
            /*position: relative;*/
            background-color: transparent;
            width: 25px;
            height: 25px;
            transform-origin: center;
            border: 2px solid #333;
            border-radius: 50%;
            vertical-align: middle;
            margin-right: 10px;
            transition: background-color 150ms 200ms, transform 350ms cubic-bezier(0.78, -1.22, 0.17, 1.89);
        }
        .checkbox-wrapper-24 label span:before {
            content: "";
            width: 0px;
            height: 2px;
            border-radius: 2px;
            background: #333;
            /*position: absolute;*/
            transform: rotate(45deg);
            top: 13px;
            left: 9px;
            transition: width 50ms ease 50ms;
            transform-origin: 0% 0%;
        }
        .checkbox-wrapper-24 label span:after {
            content: "";
            width: 0;
            height: 2px;
            border-radius: 2px;
            background: #333;
            /*position: absolute;*/
            transform: rotate(305deg);
            top: 16px;
            left: 10px;
            transition: width 50ms ease;
            transform-origin: 0% 0%;
        }
        .checkbox-wrapper-24 label:hover span:before {
            width: 5px;
            transition: width 100ms ease;
        }
        .checkbox-wrapper-24 label:hover span:after {
            width: 10px;
            transition: width 150ms ease 100ms;
        }

        .checkbox-wrapper-24 input[type=checkbox] {
            display: none;
        }
        .checkbox-wrapper-24 input[type=checkbox]:checked + label span {
            background-color: #333;
            transform: scale(1.25);
        }
        .checkbox-wrapper-24 input[type=checkbox]:checked + label span:after {
            width: 10px;
            background: #fff;
            transition: width 150ms ease 100ms;
        }
        .checkbox-wrapper-24 input[type=checkbox]:checked + label span:before {
            width: 5px;
            background: #fff;
            transition: width 150ms ease 100ms;
        }
        .checkbox-wrapper-24 input[type=checkbox]:checked + label:hover span {
            background-color: #333;
            transform: scale(1.25);
        }
        .checkbox-wrapper-24 input[type=checkbox]:checked + label:hover span:after {
            width: 10px;
            background: #fff;
            transition: width 150ms ease 100ms;
        }
        .checkbox-wrapper-24 input[type=checkbox]:checked + label:hover span:before {
            width: 5px;
            background: #fff;
            transition: width 150ms ease 100ms;
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
                    <a href="${pageContext.request.contextPath}/lecturer/<%=lecturer.getUsername()%>/add_roc" class="nav-item nav-link active" style="font-size: 18px">ร้องขอหลักสูตร</a>
                    <a href="${pageContext.request.contextPath}/lecturer/<%=lecturer.getUsername()%>/list_request_open_course" class="nav-item nav-link" style="font-size: 18px">รายการร้องขอ</a>
                    <a href="${pageContext.request.contextPath}/lecturer/<%=lecturer.getUsername()%>/list_approve_request_open_course" class="nav-item nav-link" style="font-size: 18px">หลักสูตรของฉัน</a>
                    <a href="${pageContext.request.contextPath}/view_activity" class="nav-item nav-link" style="font-size: 18px">ข่าวสารและกิจกรรม</a>
                    <a href="${pageContext.request.contextPath}/doLogout" class="nav-item nav-link" style="font-size: 18px">ออกจากระบบ</a>
                </div>
            </div>
        </nav>
        <!-- Navbar End -->
        <!-- Navbar End -->
        <form id="regForm" action="${pageContext.request.contextPath}/lecturer/<%=lecturer.getUsername()%>/save" method="POST" onsubmit="return confirmAction();" name="frm" style="font-family: 'Prompt', sans-serif;width: 95%; margin-top: 15px;font-size: 12px">
            <h1 style="text-align-last: start;">ร้องขอหลักสูตร</h1>
            <hr>
            <!-- One "tab" for each step in the form: -->
            <div class="tab">
                <table style="width: 100%">
                    <tr>
                        <td style="width: 40%; vertical-align: top;" rowspan="2">
                            <div class="course_detail" id="course_details_tab1">
                                <div style="width: 100%;">
                                    <h4 id="display_Course_Name">${request_open_course.course.name}</h4>
                                    <hr>
                                    <div style="display: flex; width: 100%;">
                                        <div style="width: 50%;">
                                            <label id="display_Course_Major">${request_open_course.course.major.name}</label><br>
                                            <label id="display_Course_Type">${request_open_course.course.course_type}</label><br>
                                            <b>ระยะเวลาเรียน : </b><label id="display_Course_Total_hours">${request_open_course.course.totalHours}</label><b> ชั่วโมง</b><br>
                                            <c:if test="${request_open_course.course.fee == 0}">
                                                <b>ค่าธรรมเนียม : </b><label id="display_Course_Fee">ไม่มีค่าธรรมเนียม</label><br>
                                            </c:if>
                                            <c:if test="${request_open_course.course.fee != 0}">
                                                <b>ค่าธรรมเนียม : </b><label id="display_Course_Fee">${request_open_course.course.fee}</label><br>
                                            </c:if>

                                        </div>
                                        <div style="width: 50%;" align="center">
                                            <img id="myImage" src="${pageContext.request.contextPath}/uploads/course_img/${request_open_course.course.img}" style="width: 180px;">
                                        </div>
                                    </div>

                                    <label id="display_Course_IMG" style="display: none">รูป</label>
                                </div>
                            </div>
                        </td>
                        <td style="width: 60%; vertical-align: top; height: 1px;">
                            <h4>เลือกหลักสูตร<b style="color: red; font-size: 24px">*</b></h4>
                            <div style="width: 100%;" align="center">
                                <c:choose>
                                    <c:when test="${request_open_course.course.course_type == 'หลักสูตรอบรมระยะสั้น'}">
                                        <input style="width: 2%;" type="radio" name="CType" value="หลักสูตรทั้งหมด">
                                        <label style="margin-right: 20px;">หลักสูตรทั้งหมด</label>
                                        <input style="width: 2%;" type="radio" name="CType" value="หลักสูตรอบรมระยะสั้น" checked>
                                        <label style="margin-right: 20px;">หลักสูตรอบรมระยะสั้น</label>
                                        <input style="width: 2%;" type="radio" name="CType" value="Non-Degree">
                                        <label>Non-Degree</label>
                                    </c:when>
                                    <c:when test="${request_open_course.course.course_type == 'Non-Degree'}">
                                        <input style="width: 2%;" type="radio" name="CType" value="หลักสูตรทั้งหมด">
                                        <label style="margin-right: 20px;">หลักสูตรทั้งหมด</label>
                                        <input style="width: 2%;" type="radio" name="CType" value="หลักสูตรอบรมระยะสั้น">
                                        <label style="margin-right: 20px;">หลักสูตรอบรมระยะสั้น</label>
                                        <input style="width: 2%;" type="radio" name="CType" value="Non-Degree" checked>
                                        <label>Non-Degree</label>
                                    </c:when>
                                    <c:otherwise>
                                        <input style="width: 2%;" type="radio" name="CType" value="หลักสูตรทั้งหมด">
                                        <label style="margin-right: 20px;">หลักสูตรทั้งหมด</label>
                                        <input style="width: 2%;" type="radio" name="CType" value="หลักสูตรอบรมระยะสั้น">
                                        <label style="margin-right: 20px;">หลักสูตรอบรมระยะสั้น</label>
                                        <input style="width: 2%;" type="radio" name="CType" value="Non-Degree">
                                        <label>Non-Degree</label>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <hr>
                            <div id="select_course" style="width: 97.5%;">
                                <div class="input-group mb-3" style="width: 97.5%;">
                                    <label class="input-group-text" for="inputGroupSelect01" id="CName">หลักสูตรทั้งหมด</label>
                                    <select name="course_id" class="form-select" id="inputGroupSelect01">
                                        <option value="">เลือกหลักสูตร</option>
                                        <c:set var="requestedCourseIds" value="" />
                                        <c:forEach var="item1" items="${request_select}">
                                            <c:set var="requestedCourseIds" value="${requestedCourseIds},${item1.course.course_id}" />
                                        </c:forEach>

                                        <c:forEach items="${courses}" var="course">
                                            <c:if test="${not fn:contains(requestedCourseIds, course.course_id)}">
                                                <option value="${course.course_id}"
                                                        data-course_type="${course.course_type}"
                                                        data-major="${course.major.name}"
                                                        data-totalHours="${course.totalHours}"
                                                        data-fee="${course.fee}"
                                                        data-img="${course.img}">${course.name}</option>
                                            </c:if>

                                        </c:forEach>
                                        <option value="${request_open_course.course.course_id}"
                                                data-course_type="${request_open_course.course.course_type}"
                                                data-major="${request_open_course.course.major.name}"
                                                data-totalHours="${request_open_course.course.totalHours}"
                                                data-fee="${request_open_course.course.fee}"
                                                data-img="${request_open_course.course.img}" selected>${request_open_course.course.name}</option>

                                    </select>
                                    <select name="course_id" class="form-select" id="inputGroupSelect02">
                                        <option value="">เลือกหลักสูตร</option>
                                        <c:set var="requestedCourseIds" value="" />
                                        <c:forEach var="item1" items="${request_select}">
                                            <c:set var="requestedCourseIds" value="${requestedCourseIds},${item1.course.course_id}" />
                                        </c:forEach>

                                        <c:forEach items="${course_type_C}" var="course">
                                            <c:if test="${not fn:contains(requestedCourseIds, course.course_id)}">
                                                <option value="${course.course_id}"
                                                        data-course_type="${course.course_type}"
                                                        data-major="${course.major.name}"
                                                        data-totalHours="${course.totalHours}"
                                                        data-fee="${course.fee}"
                                                        data-img="${course.img}">${course.name}</option>
                                            </c:if>
                                        </c:forEach>
                                        <c:if test="${request_open_course.course.course_type == 'หลักสูตรอบรมระยะสั้น'}">
                                            <option value="${request_open_course.course.course_id}"
                                                    data-course_type="${request_open_course.course.course_type}"
                                                    data-major="${request_open_course.course.major.name}"
                                                    data-totalHours="${request_open_course.course.totalHours}"
                                                    data-fee="${request_open_course.course.fee}"
                                                    data-img="${request_open_course.course.img}" selected>${request_open_course.course.name}</option>
                                        </c:if>
                                    </select>
                                    <select name="course_id" class="form-select" id="inputGroupSelect03">
                                        <option value="">เลือกหลักสูตร</option>
                                        <c:set var="requestedCourseIds" value="" />
                                        <c:forEach var="item1" items="${request_select}">
                                            <c:set var="requestedCourseIds" value="${requestedCourseIds},${item1.course.course_id}" />
                                        </c:forEach>

                                        <c:forEach items="${course_type_N}" var="course">
                                            <c:if test="${not fn:contains(requestedCourseIds, course.course_id)}">
                                                <%--                                                <option value="${course.course_id}">${course.name}</option>--%>
                                                <option value="${course.course_id}"
                                                        data-course_type="${course.course_type}"
                                                        data-major="${course.major.name}"
                                                        data-totalHours="${course.totalHours}"
                                                        data-fee="${course.fee}"
                                                        data-img="${course.img}">${course.name}</option>
                                            </c:if>
                                        </c:forEach>
                                        <c:if test="${request_open_course.course.course_type == 'Non-Degree'}">
                                            <option value="${request_open_course.course.course_id}"
                                                    data-course_type="${request_open_course.course.course_type}"
                                                    data-major="${request_open_course.course.major.name}"
                                                    data-totalHours="${request_open_course.course.totalHours}"
                                                    data-fee="${request_open_course.course.fee}"
                                                    data-img="${request_open_course.course.img}" selected>${request_open_course.course.name}</option>
                                        </c:if>
                                    </select>
                                </div>
                                <label id="invalidCourse_Select" style="color: red; font-size: 12px"></label>
                            </div>
                            <br>
                            <div class="mb-3" style="width: 100%; display: flex">
                                <div style="width: 32%">
                                    <label>วันเปิดรับสมัคร</label></b><b style="color: red; font-size: 20px">*</b>
                                    <div style="margin-right: 15px;">
                                        <input name="startRegister" type="date" id="startRegister" value="${request_open_course.startRegister}"/>
                                    </div>
                                    <label id="invalidStartRegister" style="color: red; font-size: 12px"></label>
                                </div>
                                <div style="width: 32%">
                                    <label>วันปิดรับสมัคร</label><b style="color: red; font-size: 20px">*</b>
                                    <div style="margin-right: 15px;">
                                        <input name="endRegister" type="date" id="endRegister" value="${request_open_course.endRegister}"/>
                                    </div>
                                    <label id="invalidEndRegister" style="color: red; font-size: 12px"></label>
                                </div>
                                <div style="width: 35%">
                                    <label>จำนวนรับสมัคร</label><b style="color: red; font-size: 20px">*</b>
                                    <div class="input-group mb-3">
                                        <input style="width: 80%;" name="quantity" id="quantity" value="${request_open_course.quantity}" type="number" class="form-control" oninput="this.className = ''" placeholder="จำนวนรับสมัคร" aria-describedby="basic-addon2">
                                        <span class="input-group-text" id="basic-addon2">คน</span>
                                    </div>
                                    <label id="invalidQuantity" style="color: red; font-size: 12px"></label>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td style="vertical-align: top;">
                            <div class="mb-3" style="width: 100%; display: flex">
                                <div style="width: 32%" id="startPayment_display">
                                    <label>วันเริ่มชำระเงิน</label><b style="color: red; font-size: 20px">*</b>
                                    <div style="margin-right: 15px;">
                                        <input name="startPayment" type="date" id="startPayment" value="${request_open_course.startPayment}"/>
                                    </div>
                                    <label id="invalidStartPayment" style="color: red; font-size: 12px"></label>
                                </div>
                                <div style="width: 32%" id="endPayment_display">
                                    <label>วันสิ้นสุดการชำระเงิน</label><b style="color: red; font-size: 20px">*</b>
                                    <div style="margin-right: 15px;">
                                        <input name="endPayment" type="date" id="endPayment" value="${request_open_course.endPayment}"/>
                                    </div>
                                    <label id="invalidEndPayment" style="color: red; font-size: 12px"></label>
                                </div>
                                <div style="width: 35%">
                                    <label>วันประกาศผลการสมัคร</label><b style="color: red; font-size: 20px">*</b>
                                    <div style="margin-right: 15px;">
                                        <input name="applicationResult" type="date" id="applicationResult" value="${request_open_course.applicationResult}"/>
                                    </div>
                                    <label id="invalidApplicationResult" style="color: red; font-size: 12px"></label>
                                </div>
                            </div>
                        </td>
                    </tr>
                </table>
            </div>

            <div class="tab">
                <table style="width: 100%">
                    <tr>
                        <td style="width: 40%; vertical-align: top;" rowspan="3">
                            <div class="course_detail">
                                <div style="width: 100%;">
                                    <h4 id="display_Course_Name_tap2">${request_open_course.course.name}</h4>
                                    <hr>
                                    <div style="display: flex; width: 100%;">
                                        <div style="width: 50%;">
                                            <label id="display_Course_Major_tap2">${request_open_course.course.major.name}</label><br>
                                            <label id="display_Course_Type_tap2">${request_open_course.course.course_type}</label><br>
                                            <b>ระยะเวลาเรียน : </b><label id="display_Course_Total_hours_tap2">${request_open_course.course.totalHours}</label><b> ชั่วโมง</b><br>
                                            <c:if test="${request_open_course.course.fee == 0}">
                                                <b>ค่าธรรมเนียม : </b><label id="display_Course_Fee_tap2">ไม่มีค่าธรรมเนียม</label><br>
                                            </c:if>
                                            <c:if test="${request_open_course.course.fee != 0}">
                                                <b>ค่าธรรมเนียม : </b><label id="display_Course_Fee_tap2">${request_open_course.course.fee}</label><br>
                                            </c:if>
                                        </div>
                                        <div style="width: 50%;" align="center">
                                            <img id="myImage_tap2" src="${pageContext.request.contextPath}/uploads/course_img/${request_open_course.course.img}" style="width: 180px;">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </td>
                        <td style="width: 60%; vertical-align: top; height: 1px;">
                            <h5><b>วันในการเรียน</b><b style="color: red; font-size: 24px">*</b></h5>
                            <hr>
                            <div class="btn-group" role="group" aria-label="Basic checkbox toggle button group" style="width: 100%; display: flex; text-align: -webkit-left;" align="center">
                                <div style="width: 50%; margin-right: 15px">

                                    <div style="display:flex;">
                                        <div style="width: 30%;">
                                            <input type="checkbox" class="btn-check" id="chk_mo" autocomplete="off">
                                            <label class="btn btn-outline-primary" for="chk_mo" style="width: 95%; font-size: 12px">วันจันทร์</label>
                                        </div>
                                        <div class="input-group" style="width:70%;">
                                            <span class="input-group-text" style="font-size: 12px">เวลาเรียน</span>
                                            <input type="time" class="form-control" id="start_chk_mo" name="mo_start_study_time" onchange="calculateTime('chk_mo')" step="1800" style="font-size: 12px" disabled/>
                                            <input type="time" class="form-control" id="end_chk_mo" name="mo_end_study_time" onchange="calculateTime('chk_mo')" step="1800" style="font-size: 12px" disabled/>
                                            <input type="hidden" id="total_to_save_chk_mo">
                                            <input type="hidden" id="total_to_cal_chk_mo">
                                        </div>
                                    </div>
                                    <label id="invalid_chk_mo" align="right" style="color: red; font-size: 12px;width: 100%"></label>
                                    <br>

                                    <div style="display:flex;">
                                        <div style="width: 30%;">
                                            <input type="checkbox" class="btn-check" id="chk_tu" autocomplete="off">
                                            <label class="btn btn-outline-primary" for="chk_tu" style="width: 95%; font-size: 12px">วันอังคาร</label>
                                        </div>
                                        <div class="input-group" style="width:70%;">
                                            <span class="input-group-text" style="font-size: 12px">เวลาเรียน</span>
                                            <input class="form-control" type="time" id="start_chk_tu" name="tu_start_study_time" onchange="calculateTime('chk_tu')" step="1800" style="font-size: 12px" disabled/>
                                            <input class="form-control" type="time" id="end_chk_tu" name="tu_end_study_time" onchange="calculateTime('chk_tu')" step="1800" style="font-size: 12px" disabled/>
                                            <input type="hidden" id="total_to_save_chk_tu">
                                            <input type="hidden" id="total_to_cal_chk_tu">
                                        </div>
                                    </div>
                                    <label id="invalid_chk_tu" align="right" style="color: red; font-size: 12px;width: 100%"></label>
                                    <br>

                                    <div style="display:flex;">
                                        <div style="width: 30%;">
                                            <input type="checkbox" class="btn-check" id="chk_we" autocomplete="off">
                                            <label class="btn btn-outline-primary" for="chk_we" style="width: 95%; font-size: 12px">วันพุธ</label>
                                        </div>
                                        <div class="input-group" style="width:70%;">
                                            <span class="input-group-text" style="font-size: 12px">เวลาเรียน</span>
                                            <input class="form-control" type="time" id="start_chk_we" name="we_start_study_time" onchange="calculateTime('chk_we')" step="1800" style="font-size: 12px" disabled/>
                                            <input class="form-control" type="time" id="end_chk_we" name="we_end_study_time" onchange="calculateTime('chk_we')" step="1800" style="font-size: 12px" disabled/>
                                            <input type="hidden" id="total_to_save_chk_we">
                                            <input type="hidden" id="total_to_cal_chk_we">
                                        </div>
                                    </div>
                                    <label id="invalid_chk_we" align="right" style="color: red; font-size: 12px;width: 100%"></label>
                                    <br>

                                    <div style="display:flex;">
                                        <div style="width: 30%;">
                                            <input type="checkbox" class="btn-check" id="chk_th" autocomplete="off">
                                            <label class="btn btn-outline-primary" for="chk_th" style="width: 95%; font-size: 12px">วันพฤหัสบดี</label>
                                        </div>
                                        <div class="input-group" style="width:70%;">
                                            <span class="input-group-text" style="font-size: 12px">เวลาเรียน</span>
                                            <input class="form-control" type="time" id="start_chk_th" name="th_start_study_time" onchange="calculateTime('chk_th')" step="1800" style="font-size: 12px" disabled/>
                                            <input class="form-control" type="time" id="end_chk_th" name="th_end_study_time" onchange="calculateTime('chk_th')" step="1800" style="font-size: 12px" disabled/>
                                            <input type="hidden" id="total_to_save_chk_th">
                                            <input type="hidden" id="total_to_cal_chk_th">
                                        </div>
                                    </div>
                                    <label id="invalid_chk_th" align="right" style="color: red; font-size: 12px;width: 100%"></label>
                                    <br>
                                </div>
                                <div style="width: 50%;">

                                    <div style="display:flex;">
                                        <div style="width: 30%;">
                                            <input type="checkbox" class="btn-check" id="chk_fr" autocomplete="off">
                                            <label class="btn btn-outline-primary" for="chk_fr" style="width: 95%; font-size: 12px">วันศุกร์</label>
                                        </div>
                                        <div class="input-group" style="width:70%;">
                                            <span class="input-group-text" style="font-size: 12px">เวลาเรียน</span>
                                            <input class="form-control" type="time" id="start_chk_fr" name="fr_start_study_time" onchange="calculateTime('chk_fr')" step="1800" style="font-size: 12px" disabled/>
                                            <input class="form-control" type="time" id="end_chk_fr" name="fr_end_study_time" onchange="calculateTime('chk_fr')" step="1800" style="font-size: 12px" disabled/>
                                            <input type="hidden" id="total_to_save_chk_fr">
                                            <input type="hidden" id="total_to_cal_chk_fr">
                                        </div>
                                    </div>
                                    <label id="invalid_chk_fr" align="right" style="color: red; font-size: 12px;width: 100%"></label>
                                    <br>

                                    <div style="display:flex;">
                                        <div style="width: 30%;">
                                            <input type="checkbox" class="btn-check" id="chk_sa" autocomplete="off">
                                            <label class="btn btn-outline-primary" for="chk_sa" style="width: 95%; font-size: 12px">วันเสาร์</label>
                                        </div>
                                        <div class="input-group" style="width:70%;">
                                            <span class="input-group-text" style="font-size: 12px">เวลาเรียน</span>
                                            <input class="form-control" type="time" id="start_chk_sa" name="sa_start_study_time" onchange="calculateTime('chk_sa')" step="1800" style="font-size: 12px" disabled/>
                                            <input class="form-control" type="time" id="end_chk_sa" name="sa_end_study_time" onchange="calculateTime('chk_sa')" step="1800" style="font-size: 12px" disabled/>
                                            <input type="hidden" id="total_to_save_chk_sa">
                                            <input type="hidden" id="total_to_cal_chk_sa">
                                        </div>
                                    </div>
                                    <label id="invalid_chk_sa" align="right" style="color: red; font-size: 12px;width: 100%"></label>
                                    <br>

                                    <div style="display:flex;">
                                        <div style="width: 30%;">
                                            <input type="checkbox" class="btn-check" id="chk_su" autocomplete="off">
                                            <label class="btn btn-outline-primary" for="chk_su" style="width: 95%; font-size: 12px">วันอาทิตย์</label>
                                        </div>
                                        <div class="input-group" style="width:70%;">
                                            <span class="input-group-text" style="font-size: 12px">เวลาเรียน</span>
                                            <input class="form-control" type="time" id="start_chk_su" name="su_start_study_time" onchange="calculateTime('chk_su')" step="1800" style="font-size: 12px" disabled/>
                                            <input class="form-control" type="time" id="end_chk_su" name="su_end_study_time" onchange="calculateTime('chk_su')" step="1800" style="font-size: 12px" disabled/>
                                            <input type="hidden" id="total_to_save_chk_su">
                                            <input type="hidden" id="total_to_cal_chk_su">
                                        </div>
                                    </div>
                                    <label id="invalid_chk_su" align="right" style="color: red; font-size: 12px;width: 100%"></label>
                                    <br>
                                    <div>
                                        <input type="hidden" id="to_submit" name="to_submit">
                                        <button style="width: 100%; font-size: 12px" type="button" class="btn btn-primary" onclick="calTotal()">คำนวณวันเวลาเรียน</button>
                                    </div>
                                </div>
                            </div>
                            <label id="invalid_test" align="right" style="color: red; font-size: 12px;width: 100%"></label>
                        </td>
                    </tr>
                    <tr>
                        <td style="vertical-align: top;">
                            <br>
                            <h5><b>เวลาในการเรียน</b><b style="color: red; font-size: 24px">*</b></h5>
                            <hr>
                            <div class="mb-3" style="width: 100%;">
                                <div id="cal_study" style="display: none; margin-left: 20px; width: 50%">
                                    <p id="display"></p>
                                    <label style="display: flex;">
                                        <p id="display_time_by_week">เรียนสัปดาห์ละ: <span id="time_difference_by_week"></span></p>
                                    </label>
                                    <p id="display_study_course">ควรเรียนอย่างน้อย <span id="time_difference_study_course"></span> สัปดาห์</p>
                                </div>
                            </div>
                        </td>
                        <h5 style="display: none">จำนวน Checkbox ที่ถูกเลือก: <span id="selectedCount">0</span></h5>
                    </tr>
                    <tr>
                        <td style="vertical-align: top;">
                            <br>
                            <h5><b>ระยะเวลาในการเรียน</b><b style="color: red; font-size: 24px">*</b></h5>
                            <hr>
                            <div class="mb-3" style="width: 100%; display: flex">
                                <div style="width: 32%">
                                    <label>เริ่มเรียน</label>
                                    <div style="margin-right: 15px;">
                                        <input name="startStudyDate" type="date" id="startStudyDate" value="${request_open_course.startStudyDate}"/>
                                    </div>
                                    <label id="invalidStartStudyDate" style="color: red; font-size: 12px"></label>
                                </div>
                                <div style="width: 32%">
                                    <label>วันสิ้นสุดการเรียน</label>
                                    <div style="margin-right: 15px;">
                                        <input name="endStudyDate" type="date" id="endStudyDate" onchange="checkEndDate(this.value)" value="${request_open_course.endStudyDate}"/>
                                    </div>
                                    <label id="invalidEndStudyDate" style="color: red; font-size: 12px"></label>
                                </div>
                                <div style="width: 32%">
                                    <label id="invalid_StudyDate" style="color: red; font-size: 15px"></label>
                                </div>
                            </div>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="tab">
                <table style="width: 100%">
                    <tr>
                        <td style="width: 40%; vertical-align: top;" rowspan="3">
                            <div class="course_detail">
                                <div style="width: 100%;">
                                    <h4 id="display_Course_Name_tap3">ชื่อหลักสูตร</h4>
                                    <hr>
                                    <div style="display: flex; width: 100%;">
                                        <div style="width: 50%;">
                                            <label id="display_Course_Major_tap3">สาขาวิชา</label><br>
                                            <label id="display_Course_Type_tap3">ประเภทหลักสูตร</label><br>
                                            <b>ระยะเวลาเรียน : </b><label id="display_Course_Total_hours_tap3">0</label><b> ชั่วโมง</b><br>
                                            <b>ค่าธรรมเนียม : </b><label id="display_Course_Fee_tap3">0.0 บาท</label><br>
                                        </div>
                                        <div style="width: 50%;" align="center">
                                            <img id="myImage_tap3" src="${pageContext.request.contextPath}/uploads/course_img/gallery.png" style="width: 180px;">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </td>
                        <td style="width: 100%; vertical-align: top; height: 1px;">
                            <div style="display: flex">
                                <div style="width: 50%; padding-left: 20px">
                                    <h5><b>ประเภทการเรียน</b><b style="color: red; font-size: 24px">*</b></h5>
                                    <hr>
                                    <select name="type_teach" id="type_teach" class="form-select">
                                        <option value="">--กรุณาเลือกรูปแบบการสอน--</option>
                                        <option value="แบบที่ 1 เรียนร่วมกับนักศึกษาในหลักสูตร">แบบที่ 1 เรียนร่วมกับนักศึกษาในหลักสูตร</option>
                                        <option value="แบบที่ 2 แยกกลุ่มเรียนโดยเฉพาะ">แบบที่ 2 แยกกลุ่มเรียนโดยเฉพาะ</option>
                                        <option value="จัดการเรียนการสอนร่วมกับทั้งแบบที่ 1 และแบบที่ 2">จัดการเรียนการสอนร่วมกับทั้งแบบที่ 1 และ แบบที่ 2</option>
                                    </select>
                                    <label id="invalidTypeTeach" style="color: red; font-size: 12px"></label>
                                </div>
                                <div style="width: 50%; padding-left: 20px">
                                    <h5><b>รูปแบบการสอน</b><b style="color: red; font-size: 24px">*</b></h5>
                                    <hr>
                                    <select name="type_learn" id="type_learn" onchange="showHideFields()" class="form-select">
                                        <option value="">--กรุณาเลือกประเภทการเรียน--</option>
                                        <option value="เรียนออนไลน์">เรียนออนไลน์</option>
                                        <option value="เรียนในสถานศึกษา">เรียนในสถานศึกษา</option>
                                        <option value="เรียนทั้งออนไลน์และในสถานศึกษา">เรียนทั้งออนไลน์และในสถานศึกษา</option>
                                    </select>
                                    <label id="invalidTypeLearn" style="color: red; font-size: 12px"></label>
                                </div>
                            </div>
                            <div style="width: 100%; padding-left: 20px">
                                <div style="width: 100%;">
                                    <div id="locationRow" style="display: none;">
                                        <br>
                                        <b><label>สถานที่เรียน:</label></b><b style="color: red; font-size: 20px">*</b>
                                        <div class="form-floating">
                                            <textarea class="form-control" id="floatingTextarea2" name="location" style="height: 100px" placeholder=""></textarea>
                                            <label for="floatingTextarea2">สถานที่ (ระบุ ตึก ห้อง และชั้นที่เรียน หรือรายละเอียดต่างๆ)</label>
                                        </div>

                                        <label id="invalidLocation" style="color: red; font-size: 12px"></label>
                                    </div>
                                </div>
                                <br>
                                <div style="width: 100%;">
                                    <div id="moocRow" style="display: none;">
                                        <b><label>link mooc (สำหรับเรียนออนไลน์):</label></b><b style="color: red; font-size: 20px">*</b>
                                        <div class="form-floating">
                                            <input name="link_mooc" id="link_mooc" autocomplete="off" placeholder="https://mooc.mju.ac.th/...." />
                                        </div>
                                        <label id="invalidLinkMooc" style="color: red; font-size: 12px"></label>
                                    </div>
                                </div>
                            </div>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="tab">
                <table style="width: 100%">
                    <tr>
                        <td style="width: 40%; vertical-align: top;" rowspan="3">
                            <div class="course_detail">
                                <div style="width: 100%;">
                                    <h4 id="display_Course_Name_tap4">ชื่อหลักสูตร</h4>
                                    <hr>
                                    <div style="display: flex; width: 100%;">
                                        <div style="width: 50%;">
                                            <label id="display_Course_Major_tap4">สาขาวิชา</label><br>
                                            <label id="display_Course_Type_tap4">ประเภทหลักสูตร</label><br>
                                            <b>ระยะเวลาเรียน : </b><label id="display_Course_Total_hours_tap4">0</label><b> ชั่วโมง</b><br>
                                            <b>ค่าธรรมเนียม : </b><label id="display_Course_Fee_tap4">0.0 บาท</label><br>
                                        </div>
                                        <div style="width: 50%;" align="center">
                                            <img id="myImage_tap4" src="${pageContext.request.contextPath}/uploads/course_img/gallery.png" style="width: 180px;">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </td>
                        <td style="width: 100%; vertical-align: top; height: 1px;">
                            <h4>รายละเอียดการร้องขอ</h4>
                            <hr>
                            <div style="width: 100%; display: flex">
                                <div style="width: 50%;">
                                    <b><label>รับสมัครวันที่</label></b>
                                    <div style="display: flex">
                                        <p id="startRegister_display">เริ่ม</p>
                                        <p style="margin: 0px 10px 0px 10px;"> ถึง </p>
                                        <p id="endRegister_display">สิ้นสุด</p>
                                    </div>
                                </div>
                                <div style="width: 50%">
                                    <b><label>รับจำนวน </label></b>
                                    <div style="display: flex">
                                        <p id="quantity_display" style="margin-right: 10px;"></p> คน
                                    </div>
                                </div>
                            </div>
                            <div id="display_Payment_Date" style="width: 100%; display: flex">
                                <div style="width: 100%;">
                                    <b><label>วันชำระเงิน</label></b>
                                    <div style="display: flex">
                                        <p id="startPaymentTotal_display">เริ่ม</p>
                                        <p style="margin: 0px 10px 0px 10px;"> ถึง </p>
                                        <p id="endPaymentTotal_display">สิ้นสุด</p>
                                    </div>
                                </div>
                            </div>
                            <div style="width: 100%; display: flex">
                                <div style="width: 50%">
                                    <b><label>ประกาศผลการสมัคร</label></b>
                                    <div style="display: flex">
                                        <p id="applicationResult_display">วันที่</p>
                                    </div>
                                </div>
                                <div style="width: 50%">
                                    <b><label>ระยะเวลาในการเรียน</label></b>
                                    <div style="width: 100%; display: flex">
                                        <p id="startStudyDate_display">เริ่ม</p>
                                        <p style="margin: 0px 10px 0px 10px;"> ถึง </p>
                                        <p id="endStudyDate_display">สิ้นสุด</p>
                                    </div>
                                </div>
                            </div>
                            <div style="width: 100%; display: flex">
                                <div style="width: 50%;">
                                    <b><label>วันที่เรียน</label></b>
                                    <div style="display: flex; width: 85%;">
                                        <p id="dayByWeek_display">วันไหนบ้าง</p>
                                    </div>
                                </div>
                                <div style="width: 50%;">
                                    <b><label>เวลา</label></b>
                                    <div style="display: flex">
                                        <p id="start_study_time_display" name="start_study_time_display" style="margin-right: 10px;">เริ่ม</p>น.
                                        <p style="margin: 0px 10px 0px 10px;"> ถึง </p>
                                        <p id="end_study_time_display" name="end_study_time_display" style="margin-right: 10px;">สิ้นสุด</p>น.
                                    </div>
                                </div>
                            </div>
                            <div style="width: 100%; display: flex">
                                <div style="width: 50%;">
                                    <b><label>ประเภทการสอน</label></b>
                                    <div style="display: flex">
                                        <p id="type_teach_display">ประเภท</p>
                                    </div>
                                </div>
                                <div style="width: 50%;">
                                    <b><label>ประเภทการเรียน</label></b>
                                    <div style="display: flex">
                                        <p id="type_learn_display">ประเภท</p>
                                    </div>
                                </div>
                            </div>
                            <div style="width: 100%" id="link_type">
                                <b><label>LinkMooc</label></b>
                                <div style="width: 100%; display: flex">
                                    <p id="link_mooc_display">ลิงค์</p>
                                </div>
                            </div>
                            <div style="width: 100%" id="location_type">
                                <b><label>สถานที่เรียน</label></b>
                                <div style="width: 100%; display: flex">
                                    <p id="location_display">สถานที่</p>
                                </div>
                            </div>
                            <input type="text" id="display_for_submit" name="display_for_submit">
                        </td>
                    </tr>
                </table>
            </div>
            <div style="overflow:auto;">
                <div>
                    <button type="button" id="prevBtn" style="font-family: 'Prompt', sans-serif;width: 200px;border-radius: 15px;" onclick="nextPrev(-1)">ย้อนกลับ</button>
                    <button type="button" id="nextBtn" style="float: right; font-family: 'Prompt', sans-serif;width: 200px;border-radius: 15px;" onclick="nextPrev(1)">ต่อไป</button>
                    <button type="submit" id="submitBtn" style="display: none;float: right; font-family: 'Prompt', sans-serif;width: 200px;border-radius: 15px;">ยืนยัน</button>
                </div>
            </div>
            <!-- Circles which indicates the steps of the form: -->
            <div style="text-align:center;margin-top:40px; display: flex;">
                <span class="step"></span>
                <span class="step"></span>
                <span class="step"></span>
                <span class="step"></span>
            </div>
        </form>
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
    // function updateDisplay() {
    //     var selectedDays = [];
    //     // ดึงค่าจาก input elements
    //     var startTimeInput = document.getElementById("start_study_time").value;
    //     var endTimeInput = document.getElementById("end_study_time").value;
    //     var courseHour = document.getElementById("display_Course_Total_hours_tap2").textContent;
    //
    //     document.getElementById("startStudyDate").value = "";
    //     document.getElementById("endStudyDate").value = "";
    //     document.getElementById('invalid_StudyDate').textContent = "";
    //     document.getElementById('invalidEndStudyDate').textContent = "";
    //     document.getElementById('invalidStartStudyDate').textContent = "";
    //
    //     // แปลงค่าเวลาเป็นวินาที
    //     var startTime = new Date("1970-01-01T" + startTimeInput + "Z");
    //     var endTime = new Date("1970-01-01T" + endTimeInput + "Z");
    //
    //     // นับ Checkbox ที่ถูกเลือก
    //     var selectedCount = 0;
    //     // เริ่มจากการตรวจสอบสถานะของ Checkbox ทุกตัว
    //     var checkboxes = document.querySelectorAll('.btn-check');
    //     var study_time = "";
    //     checkboxes.forEach(function(checkbox) {
    //         if (checkbox.checked) {
    //             study_time = startTime + checkbox.id + "," + checkbox.id.value
    //             // ถ้า Checkbox ถูกเลือก, เพิ่มวันและเวลาที่ผู้ใช้เลือกลงในอาร์เรย์
    //             var label = document.querySelector('label[for="' + checkbox.id + '"]');
    //             var startTime = document.getElementById('start_' + checkbox.id).value;
    //             var endTime = document.getElementById('end_' + checkbox.id).value;
    //
    //             selectedDays.push({
    //                 day: label.textContent,
    //                 startTime: startTime,
    //                 endTime: endTime
    //             });
    //
    //             selectedCount++;
    //         }
    //     });
    //
    //     // คำนวณความต่างของเวลา
    //     var timeDifference = endTime - startTime;
    //     var timeDifferenceByWeek = timeDifference * parseInt(selectedCount);
    //
    //     // แปลงผลลัพธ์เป็นชั่วโมงและนาที
    //     var hours = Math.floor(timeDifference / 3600000);
    //     var minutes = Math.floor((timeDifference % 3600000) / 60000);
    //
    //     var hoursByWeek = Math.floor(timeDifferenceByWeek / 3600000);
    //     var minutesByWeek = Math.floor((timeDifferenceByWeek % 3600000) / 60000);
    //
    //     var avgStudyByCourse = parseInt(courseHour);
    //     var quotient = Math.floor((avgStudyByCourse*60) / ((hoursByWeek*60)+minutesByWeek));// หารเอาส่วน
    //     var remainder = (avgStudyByCourse*60) - (quotient * (hoursByWeek*60)); // หารเอาเศษ
    //     if(remainder !== 0){
    //         quotient++;
    //     }
    //
    //     if(startTimeInput !== "" && endTimeInput !== ""){
    //         // แสดงผลลัพธ์
    //         document.getElementById("cal_study").style.display = "block";
    //         var resultElement1 = document.getElementById("time_difference");
    //         resultElement1.textContent = hours + " ชั่วโมง " + minutes + " นาที";
    //
    //         var resultElement2 = document.getElementById("time_difference_by_week");
    //         resultElement2.textContent = hoursByWeek + " ชั่วโมง " + minutesByWeek + " นาที";
    //
    //         var resultElement3 = document.getElementById("time_difference_study_course");
    //         resultElement3.textContent = quotient;
    //     }
    //
    //     // แสดงวันที่ถูกเลือกใน <h5> element
    //     var displayElement = document.getElementById("display");
    //     var displayElementForSubmit = document.getElementById("display_for_submit");
    //     if (selectedDays.length > 0) {
    //         displayElement.textContent = "เรียนทุกวัน: " + selectedDays.join(", ");
    //         displayElementForSubmit.value = selectedDays.join(", ");
    //         if(startTimeInput !== "" && endTimeInput !== ""){
    //             document.getElementById("cal_study").style.display = "block";
    //         }
    //     } else {
    //         document.getElementById("cal_study").style.display = "none";
    //         displayElement.textContent = "กรุณาเลือกวันที่จะเรียน";
    //     }
    //     // แสดงจำนวน Checkbox ที่ถูกเลือกใน <span> element
    //     var selectedCountElement = document.getElementById("selectedCount");
    //     selectedCountElement.textContent = selectedCount.toString();
    // }
</script>
<script>
    var selectedCount = 0;
    // ดึง Checkbox elements
    const checkboxes = document.querySelectorAll('.btn-check');
    // เพิ่ม event listener ในทุก Checkbox
    checkboxes.forEach(function (checkbox) {
        checkbox.addEventListener('change', function () {
            // ดึง ID ของ Checkbox
            const id = checkbox.id;

            // ดึง input elements ที่เกี่ยวข้อง
            const startInput = document.getElementById('start_' + id);
            const endInput = document.getElementById('end_' + id);

            // ตรวจสอบสถานะของ Checkbox
            if (checkbox.checked) {
                // เปิดใช้งาน input elements เมื่อ Checkbox เลือก
                startInput.disabled = false;
                endInput.disabled = false;
                selectedCount++;
            } else {
                // ปิดใช้งาน input elements เมื่อ Checkbox ไม่ถูกเลือก
                startInput.disabled = true;
                endInput.disabled = true;
                startInput.value = "";
                endInput.value = "";
                selectedCount--;
            }
            // แสดงจำนวน Checkbox ที่ถูกเลือกใน <span> element
                var selectedCountElement = document.getElementById("selectedCount");
                selectedCountElement.textContent = selectedCount.toString();
        });
    });
</script>
<script>
    const timeInputs = document.querySelectorAll('input[type="time"]');

    const roundFunc = e => {
        let x = e.target.value.split(':');
        if (x[1] > 0 && x[1] < 15) {
            x[1] = "00";
        } else if (x[1] > 44 && x[1] < 60) {
            x[0] = x[0] < 10 ? "0" + (parseInt(x[0]) + 1) : (parseInt(x[0]) + 1).toString();
            x[1] = "00";
        } else {
            x[1] = "30";
        }
        e.target.value = x.join(':');
    }

    timeInputs.forEach(input => {
        input.addEventListener('input', roundFunc);
    });
</script>
<script>
    function calculateTime(id) {
        // ดึงค่าจาก input elements
        var courseHour = document.getElementById("display_Course_Total_hours_tap2").textContent;
        var selectedCountElement = document.getElementById("selectedCount").textContent;
        const startTimeInput = document.getElementById('start_' + id).value;
        var endTimeInput = document.getElementById('end_' + id).value;

        // แปลงค่าเวลาเป็นวินาที
        var startTime = new Date("1970-01-01T" + startTimeInput + "Z");
        var endTime = new Date("1970-01-01T" + endTimeInput + "Z");

        // คำนวณความต่างของเวลา
        var timeDifference = endTime - startTime;
        var timeDifferenceByWeek = timeDifference * parseInt(selectedCountElement);
        // แปลงผลลัพธ์เป็นชั่วโมงและนาที
        var hours = Math.floor(timeDifference / 3600000);
        var minutes = Math.floor((timeDifference % 3600000) / 60000);

        var hoursByWeek = Math.floor(timeDifferenceByWeek / 3600000);
        var minutesByWeek = Math.floor((timeDifferenceByWeek % 3600000) / 60000);

        var avgStudyByCourse = parseInt(courseHour);
        var quotient = Math.floor((avgStudyByCourse*60) / ((hoursByWeek*60)+minutesByWeek));// หารเอาส่วน
        var remainder = (avgStudyByCourse*60) - (quotient * (hoursByWeek*60)); // หารเอาเศษ
        if(remainder !== 0){
            quotient++;
        }

        // // ตรวจสอบว่า end time มากกว่า start time
        if (startTimeInput >= endTimeInput && currentTab !== 0) {
            if (endTimeInput !== "" && startTimeInput !== ""){
                document.getElementById("invalid_"+id).textContent = "กรุณาเลือกเวลาสิ้นสุดที่มากกว่าเริ่มเรียน";
                document.getElementById('end_' + id).value = "";
                document.getElementById("total_to_save_"+id).value = "";
                document.getElementById("total_to_cal_"+id).value = "";
                endTimeInput.focus()
                return false;
            }else {
                document.getElementById("invalid_"+id).textContent = "";
            }
        }else {
            document.getElementById("invalid_"+id).textContent = "";
            var day = document.querySelector('label[for="' + id + '"]');
            document.getElementById("total_to_save_"+id).value = day.textContent + '/' + startTimeInput + '/' + endTimeInput + '$%';
            document.getElementById("total_to_cal_"+id).value = timeDifference;
        }
    }
    function calTotal(){
        // รายชื่อของวัน
        var days = ["mo", "tu", "we", "th", "fr", "sa", "su"];
        var total_study = "";
        var total_cal = 0;
        var count = 0;

// วนลูปผ่านทุกวัน
        for (var i = 0; i < days.length; i++) {
            var day = days[i];
            var checkbox = document.getElementById("chk_" + day);
            var startInput = document.getElementById("start_chk_" + day);
            var endInput = document.getElementById("end_chk_" + day);
            var invalidLabel = document.getElementById("invalid_chk_" + day);
            var total_to_save = document.getElementById("total_to_save_chk_" + day).value;
            var total_to_cal = document.getElementById("total_to_cal_chk_" + day).value;

            if (checkbox.checked) {
                if (startInput.value.trim() === "" || endInput.value.trim() === "") {
                    // ถ้า Checkbox ถูกเลือก และมีค่าว่าง ให้แสดงข้อความเตือนให้ผู้ใช้ระบุเวลาที่ถูกต้อง
                    invalidLabel.textContent = "กรุณากรอกเวลาให้ครบ";
                } else {
                    // ถ้า Checkbox ถูกเลือก และไม่มีค่าว่าง ให้ลบข้อความเตือน
                    invalidLabel.textContent = "";
                    total_study += total_to_save;
                    total_cal += parseInt(total_to_cal);
                    count++;
                }
            } else {
                // ถ้า Checkbox ไม่ถูกเลือก ให้ลบข้อความเตือน
                invalidLabel.textContent = "";
            }
        }
        var courseHour = document.getElementById("display_Course_Total_hours_tap2").textContent;
        var timeDifferenceByWeek = parseInt(total_cal);

        var hoursByWeek = Math.floor(timeDifferenceByWeek / 3600000);
        var minutesByWeek = Math.floor((timeDifferenceByWeek % 3600000) / 60000);

        var avgStudyByCourse = parseInt(courseHour);
        var quotient = Math.floor((avgStudyByCourse*60) / ((hoursByWeek*60)+minutesByWeek));// หารเอาส่วน
        var remainder = (avgStudyByCourse*60) - (quotient * (hoursByWeek*60)); // หารเอาเศษ
        if(remainder !== 0){
            quotient++;
        }

        if(count !== 0){
            // แสดงผลลัพธ์
            document.getElementById("cal_study").style.display = "block";
            var resultElement2 = document.getElementById("time_difference_by_week");
            resultElement2.textContent = hoursByWeek + " ชั่วโมง " + minutesByWeek + " นาที";

            var resultElement3 = document.getElementById("time_difference_study_course");
            resultElement3.textContent = quotient;

            document.getElementById("display_for_submit").value = total_study;

        }
    }
</script>
<script>
    // เรียกฟังก์ชันเมื่อมีการเลือกสาขา
    document.getElementById("major_id").addEventListener("change", function () {
        // รับค่าที่ถูกเลือก
        var selectedMajor = document.getElementById("major_id").value;

        // ค้นหาชื่อสาขาที่ถูกเลือกจาก dropdown
        var majors = document.querySelectorAll("#major_id option");
        var selectedMajorName = "";
        for (var i = 0; i < majors.length; i++) {
            if (majors[i].value === selectedMajor) {
                selectedMajorName = majors[i].textContent;
                break;
            }
        }

        // แสดงชื่อสาขาใน <h4> element
        document.getElementById("displayMajor").textContent = selectedMajorName;
    });
</script>
<script>
    function boldText() {
        document.execCommand('bold', false, null);
    }

    function italicText() {
        document.execCommand('italic', false, null);
    }

    function underlineText() {
        document.execCommand('underline', false, null);
    }
</script>
<script>
    function confirmAction() {
        var result = confirm("คุณแน่ใจหรือไม่ว่าต้องการเพิ่มคำร้องขอนี้?");
        if (result) {
            return true; // ถ้าผู้ใช้กด OK ให้ทำงานตามปกติ
        } else {
            return false; // ถ้าผู้ใช้กด Cancel ให้ยกเลิกการส่งฟอร์ม
        }
    }
</script>
<script>
    var currentTab = 0; // Current tab is set to be the first tab (0)
    showTab(currentTab); // Display the current tab
    function showTab(n) {
        // This function will display the specified tab of the form...
        var x = document.getElementsByClassName("tab");
        x[n].style.display = "block";
        //... and fix the Previous/Next buttons:
        if (n == 0) {
            document.getElementById("prevBtn").style.display = "none";
        } else {
            document.getElementById("prevBtn").style.display = "inline";
        }
        if (n == (x.length - 1)) {
            document.getElementById("nextBtn").innerHTML = "ยืนยัน";
            // document.getElementById("nextBtn").style.display = "none";
            // document.getElementById("submitBtn").style.display = "block";
        } else {
            document.getElementById("nextBtn").innerHTML = "ต่อไป";
            // document.getElementById("nextBtn").style.display = "block";
            // document.getElementById("submitBtn").style.display = "none";
        }
        //... and run a function that will display the correct step indicator:
        fixStepIndicator(n)
    }

    function nextPrev(n) {
        // This function will figure out which tab to display
        var x = document.getElementsByClassName("tab");
        // Exit the function if any field in the current tab is invalid:
        // if (currentTab === 0&& !validateStep1()) {
        //     validateStep1();
        // }
        if (n == 1 && !validateForm()) return false;
        // Hide the current tab:
        x[currentTab].style.display = "none";
        // Increase or decrease the current tab by 1:
        currentTab = currentTab + n;
        // if you have reached the end of the form...
        // if (currentTab >= x.length) {
        //     // ... the form gets submitted:
        //     document.getElementById("regForm").submit();
        //     return false;
        // }
        if (currentTab >= x.length) {
            var confirmed = confirmAction();
            if (confirmed) {
                document.getElementById("regForm").submit();
                return false;
            } else {
                currentTab = currentTab - 1; // ย้อนกลับไปที่ขั้นตอนก่อนหน้า
            }
        }
        console.log("currentTab : "+currentTab);
        // Otherwise, display the correct tab:
        showTab(currentTab);
    }
    function validateForm() {
        // This function deals with validation of the form fields
        var x, y, i, valid = true;
        x = document.getElementsByClassName("tab");
        y = x[currentTab].getElementsByTagName("input");
        // A loop that checks every input field in the current tab:
        // for (i = 0; i < y.length; i++) {
        //     // If a field is empty...checkScriptPage1()
        //     if (y[i].value == "") {
        //         // add an "invalid" class to the field:
        //         y[i].className += " invalid";
        //         // and set the current valid status to false
        //         valid = false;
        //     }
        // }
        if (currentTab === 0) {
            // ตรวจสอบข้อมูลใน Step 2
            if (!checkScriptPage1()){
                return false;
            }
            // calculateTimeDifference();
        }
        else if(currentTab === 1){
            if (!checkScriptPage2()){
                return false;
            }
        }
        else if (currentTab === 2){
            if(!checkScriptPage3()){
                return false;
            }
        }
        // If the valid status is true, mark the step as finished and valid:
        if (valid) {
            document.getElementsByClassName("step")[currentTab].className += " finish";
        }
        return valid; // return the valid status
    }
    var pElement = document.getElementById("link_mooc_display");
    function displayDetailInStep3() {
        const startRegister = document.getElementById("startRegister").value;
        const endRegister = document.getElementById("endRegister").value;
        const quantity = document.getElementById("quantity").value;
        const startPayment = document.getElementById("startPayment").value;
        const endPayment = document.getElementById("endPayment").value;
        const applicationResult = document.getElementById("applicationResult").value;
        // const dayByWeek = document.getElementById("display").textContent;
        // const start_study_time = document.getElementById("start_study_time").value;
        // const end_study_time = document.getElementById("end_study_time").value;
        const startStudyDate = document.getElementById("startStudyDate").value;
        const endStudyDate = document.getElementById("endStudyDate").value;
        const type_teach = document.getElementById("type_teach").value;
        const type_learn = document.getElementById("type_learn").value;
        const location = document.getElementById("floatingTextarea2").value;
        const link_mooc = document.getElementById("link_mooc").value;

        // สร้างวัตถุ Date จากค่าที่ได้จาก input
        const startDate = new Date(startRegister);
        const endDate = new Date(endRegister);

        const startPayment_FM = new Date(startPayment);
        const endPayment_FM = new Date(endPayment);
        const applicationResult_FM= new Date(applicationResult);
        const startStudyDate_FM = new Date(startStudyDate);
        const endStudyDate_FM = new Date(endStudyDate);

        // จัดรูปแบบวันที่เป็น "dd/MM/yyyy"
        const startDateFormatted = startDate.toLocaleDateString('th-TH', { day: '2-digit', month: '2-digit', year: 'numeric' });
        const endDateFormatted = endDate.toLocaleDateString('th-TH', { day: '2-digit', month: '2-digit', year: 'numeric' });

        const startPayment_display = startPayment_FM.toLocaleDateString('th-TH', { day: '2-digit', month: '2-digit', year: 'numeric' });
        const endPayment_display = endPayment_FM.toLocaleDateString('th-TH', { day: '2-digit', month: '2-digit', year: 'numeric' });
        const applicationResult_display = applicationResult_FM.toLocaleDateString('th-TH', { day: '2-digit', month: '2-digit', year: 'numeric' });
        const startStudyDate_display = startStudyDate_FM.toLocaleDateString('th-TH', { day: '2-digit', month: '2-digit', year: 'numeric' });
        const endStudyDate_display = endStudyDate_FM.toLocaleDateString('th-TH', { day: '2-digit', month: '2-digit', year: 'numeric' });


        // แสดงข้อมูล
        document.getElementById("startRegister_display").textContent = startDateFormatted;
        document.getElementById("endRegister_display").textContent = endDateFormatted;
        document.getElementById("quantity_display").textContent = quantity;
        document.getElementById("startPaymentTotal_display").textContent = startPayment_display;
        document.getElementById("endPaymentTotal_display").textContent = endPayment_display;
        document.getElementById("applicationResult_display").textContent = applicationResult_display;
        document.getElementById("startStudyDate_display").textContent = startStudyDate_display;
        document.getElementById("endStudyDate_display").textContent = endStudyDate_display;
        // document.getElementById("dayByWeek_display").textContent = dayByWeek;
        // document.getElementById("start_study_time_display").textContent = start_study_time;
        // document.getElementById("end_study_time_display").textContent = end_study_time;
        document.getElementById("type_teach_display").textContent = type_teach;
        document.getElementById("type_learn_display").textContent = type_learn;
        if (type_learn === "เรียนในสถานศึกษา"){
            document.getElementById("location_type").style.display = "block";
            document.getElementById("link_type").style.display = "none";
        }else if (type_learn === "เรียนออนไลน์"){
            document.getElementById("location_type").style.display = "none";
            document.getElementById("link_type").style.display = "block";
        }else {
            document.getElementById("location_type").style.display = "block";
            document.getElementById("link_type").style.display = "block";
        }
        // สร้างลิงค์ <a> ด้วย innerHTML
        pElement.innerHTML = `<a href="`+ link_mooc +`" target="_blank">`+link_mooc+`</a>`;
        // document.getElementById("link_mooc_display").textContent = link_mooc;
        document.getElementById("location_display").textContent = location;
    }
    function displayCheckDisplayDetailInStep3() {
        //-------------Check Type Course--------------
        const fee = document.getElementById("display_Course_Fee").textContent;
        if (fee === "ไม่มีค่าธรรมเนียม"){
            document.getElementById("display_Payment_Date").style.display = "none";
        }else {
            document.getElementById("display_Payment_Date").style.display = "block";
        }

        //-------------Check Type Learn---------------
        const type_learn = document.getElementById("type_learn").value;

        const location = document.getElementById("floatingTextarea2").value;
        const linkMooc = document.getElementById("link_mooc").value;

        const display_linkMooc = document.getElementById("link_mooc_display");
        const display_location = document.getElementById("location_display");

        if (type_learn === "เรียนออนไลน์"){
            // document.getElementById("link_mooc_display").textContent = linkMooc;
            pElement.innerHTML = `<a href="`+ linkMooc +`" target="_blank">`+linkMooc+`</a>`;
            display_linkMooc.style.display = "block";
            display_location.style.display = "none";
        }else if (type_learn === "เรียนในสถานศึกษา") {
            document.getElementById("location_display").textContent = location;
            display_linkMooc.style.display = "none";
            display_location.style.display = "block";
        }else if (type_learn === "เรียนทั้งออนไลน์และในสถานศึกษา") {
            // document.getElementById("link_mooc_display").textContent = linkMooc;
            pElement.innerHTML = `<a href="`+ linkMooc +`" target="_blank">`+linkMooc+`</a>`;
            document.getElementById("location_display").textContent = location;
            display_linkMooc.style.display = "block";
            display_location.style.display = "block";
        }
        displayDetailInStep3();
    }
    document.getElementById("nextBtn").addEventListener("click", displayCheckDisplayDetailInStep3);

    // function validateForm() {
    //     if (currentTab === 0) {
    //         // ตรวจสอบข้อมูลใน Step 1
    //         if (!checkScriptPage1()) {
    //             return false;
    //         }
    //     }
    //     // เพิ่มเงื่อนไขการตรวจสอบข้อมูลในขั้นตอนอื่น ๆ ตามต้องการ
    //     return true;
    // }

    function fixStepIndicator(n) {
        // This function removes the "active" class of all steps...
        var i, x = document.getElementsByClassName("step");
        for (i = 0; i < x.length; i++) {
            x[i].className = x[i].className.replace(" active", "");
        }
        //... and adds the "active" class on the current step:
        x[n].className += " active";
    }
</script>
<script>
    function checkFile(input) {
        var file = input.files[0];

        if (!file) {
            alert("กรุณาเลือกไฟล์หลักสูตร");
            return;
        }

        var allowedExtensions = /(\.pdf)$/i;
        var maxFileSize = 10 * 1024 * 1024; // 2MB

        if (!allowedExtensions.exec(file.name)) {
            alert("ต้องเป็นไฟล์ PDF เท่านั้น");
            input.value = "";
            return;
        }else {
            document.getElementById("invalidCourseFile").innerHTML = "";
        }

        if (file.size > maxFileSize) {
            alert("ขนาดไฟล์รูปภาพต้องไม่เกิน 10MB");
            input.value = "";
        }
    }
</script>
<script>
    function checkScriptPage1(){
        //------------Course Type-------------
        var Course_Type_Check = document.getElementsByName('CType');
        var Course_Type_Type_null = false;
        for (var i = 0; i < Course_Type_Check.length; i++) {
            if (Course_Type_Check[i].checked) {
                Course_Type_Type_null = true;
                break;
            }
        }
        if (!Course_Type_Type_null) {
            alert("กรุณาเลือกหลักสูตร");
            return false;
        }

        //------------Course Select-------------
        var courseCheck = document.getElementById('display_Course_Name').textContent;
        if (courseCheck === "ชื่อหลักสูตร" || courseCheck === "เลือกหลักสูตร") {
            // alert("กรุณาเลือกประเภทหลักสูตร");
            document.getElementById("invalidCourse_Select").innerHTML = "กรุณาเลือกหลักสูตรที่จะร้องขอ";
            return false;
        } else {
            document.getElementById("invalidCourse_Select").innerHTML = "";
        }

        //-----------StartRegister-----------
        var startRegisterValue = document.getElementById('startRegister').value; // ค่าวันเปิดรับสมัคร
        if (startRegisterValue.trim() === "") {
            document.getElementById("invalidStartRegister").innerHTML = "กรุณาเลือกวันเปิดรับสมัคร";
            return false;
        }else if (new Date(startRegisterValue) < new Date(currentDate)){
            document.getElementById("invalidStartRegister").innerHTML = "กรุณาเลือกวันให้มากกว่าวันปัจจุบัน";
            return false;
        }else {
            document.getElementById("invalidStartRegister").innerHTML = "";
        }

        //-----------EndRegister-----------
        var endRegisterValue = document.getElementById('endRegister').value; // ค่าวันปิดรับสมัคร
        if (endRegisterValue.trim() === "") {
            document.getElementById("invalidEndRegister").innerHTML = "กรุณาเลือกวันปิดรับสมัคร";
            return false;
        }else if (new Date(endRegisterValue) < new Date(currentDate) || new Date(endRegisterValue) < new Date(startRegisterValue)){
            document.getElementById("invalidEndRegister").innerHTML = "กรุณาเลือกวันให้มากกว่าวันปัจจุบัน และให้มากกว่าวันเปิดรับสมัคร";
            return false;
        }else {
            document.getElementById("invalidEndRegister").innerHTML = "";
        }

        //-----------quantity-----------------
        var quantity = document.getElementById('quantity').value;

        var check = /^[0-9]+$/;
        if (quantity === "") {
            document.getElementById("invalidQuantity").innerHTML = "กรุณากรอกจำนวนที่เปิดรับ";
            return false;
        }else if (!check.test(quantity)){
            document.getElementById("invalidQuantity").innerHTML = "ต้องเป็นตัวเลขเท่านั้น";
            return false;
        }else if (parseInt(quantity) < 1 || parseInt(quantity) > 9999){
            document.getElementById("invalidQuantity").innerHTML = "ต้องอยู่ในช่วง 1 - 9999 เท่านั้น";
            return false;
        }else {
            document.getElementById("invalidQuantity").innerHTML = "";
        }

        //-----------startPayment-----------------
        var startPaymentValue = document.getElementById('startPayment').value;
        var Course_Fee = document.getElementById('display_Course_Fee_tap2').textContent;
        if (Course_Fee !== "ไม่มีค่าธรรมเนียม"){
            if (startPaymentValue.trim() === "") {
                document.getElementById("invalidStartPayment").innerHTML = "กรุณาเลือกวันเริ่มชำระเงิน";
                return false;
            }else if (new Date(startPaymentValue) < new Date(currentDate) || new Date(startPaymentValue) <= new Date(startRegisterValue)){
                document.getElementById("invalidStartPayment").innerHTML = "กรุณาเลือกวันให้มากกว่าวันปัจจุบัน และให้มากกว่าวันเปิดรับสมัคร";
                return false;
            }else {
                document.getElementById("invalidStartPayment").innerHTML = "";
            }
        } else {
            document.getElementById("invalidStartPayment").innerHTML = "";
        }

        //-----------endPayment-----------------
        var endPayment = document.getElementById('endPayment').value;
        // var Course_Fee = document.getElementById('display_Course_Fee_tap2').textContent;

         if (Course_Fee !== "ไม่มีค่าธรรมเนียม"){
             if (endPayment.trim() === "") {
                 document.getElementById("invalidEndPayment").innerHTML = "กรุณาเลือกวันสิ้นสุดการชำระเงิน";
                 return false;
             } else if (new Date(endPayment) < new Date(currentDate) || new Date(endPayment) < new Date(startPaymentValue) || new Date(endPayment) < new Date(endRegisterValue)){
                document.getElementById("invalidEndPayment").innerHTML = "กรุณาเลือกวันให้มากกว่าวันปัจจุบัน วันสิ้นสุดการสมัคร และวันเริ่มชำระเงิน";
                return false;
            }else {
                document.getElementById("invalidEndPayment").innerHTML = "";
            }
        } else {
            document.getElementById("invalidEndPayment").innerHTML = "";
        }

        //-----------applicationResult-----------------
        var applicationResult = document.getElementById('applicationResult').value;
        if (applicationResult.trim() === "") {
            document.getElementById("invalidApplicationResult").innerHTML = "กรุณาเลือกวันประกาศผลการสมัคร";
            return false;
        }else if (new Date(applicationResult) < new Date(currentDate) || new Date(applicationResult) < new Date(endPayment)){
            document.getElementById("invalidApplicationResult").innerHTML = "กรุณาเลือกวันให้มากกว่าวันปัจจุบัน และให้มากกว่าวันสิ้นสุดชำระเงิน";
            return false;
        }else {
            document.getElementById("invalidApplicationResult").innerHTML = "";
        }

        return true;
    }
    function checkScriptPage2(){
        //------------Check Box Day-------------
        var selectedCountElement = document.getElementById("selectedCount").textContent;
        if(selectedCountElement === "0"){
            alert("กรุณาเลือกวันในการเรียนอย่างน้อง 1 วัน");
            return false;
        }
        //----dtime---
        var days = ["mo", "tu", "we", "th", "fr", "sa", "su"];
        var total_study = "";
        for (var i = 0; i < days.length; i++) {
            var day = days[i];
            var checkbox = document.getElementById("chk_" + day);
            var startInput = document.getElementById("start_chk_" + day);
            var endInput = document.getElementById("end_chk_" + day);
            var invalidLabel = document.getElementById("invalid_chk_" + day);
            var total_to_save = document.getElementById("total_to_save_chk_" + day).value;

            if (checkbox.checked) {
                if (startInput.value.trim() === "" || endInput.value.trim() === "") {
                    // ถ้า Checkbox ถูกเลือก และมีค่าว่าง ให้แสดงข้อความเตือนให้ผู้ใช้ระบุเวลาที่ถูกต้อง
                    invalidLabel.textContent = "กรุณากรอกเวลาให้ครบ";
                    return false;
                } else {
                    invalidLabel.textContent = "";
                    total_study += total_to_save;
                }
            } else {
                // ถ้า Checkbox ไม่ถูกเลือก ให้ลบข้อความเตือน
                invalidLabel.textContent = "";
            }
            document.getElementById("display_for_submit").value = total_study;
        }

        //-----------Start Study Date-----------
        var startStudyDateValue = document.getElementById('startStudyDate').value;
        var applicationResult = document.getElementById('applicationResult').value;
        if (startStudyDateValue.trim() === "") {
            document.getElementById("invalidStartStudyDate").innerHTML = "กรุณาเลือกวันเริ่มเรียน";
            return false;
        }else if (new Date(startStudyDateValue) < new Date(currentDate) || new Date(startStudyDateValue) < new Date(applicationResult)){
            document.getElementById("invalidStartStudyDate").innerHTML = "กรุณาเลือกวันให้มากกว่าวันปัจจุบัน และให้มากกว่าวันประกาศผล";
            return false;
        }else {
            document.getElementById("invalidStartStudyDate").innerHTML = "";
        }

        //-----------End Study Date-----------
        var endStudyDateValue = document.getElementById('endStudyDate').value;
        if (endStudyDateValue.trim() === "") {
            document.getElementById("invalidEndStudyDate").innerHTML = "กรุณาเลือกวันสิ้นสุดการเรียน";
            return false;
        }else if (new Date(endStudyDateValue) < new Date(currentDate) || new Date(endStudyDateValue) < new Date(startStudyDateValue)){
            document.getElementById("invalidEndStudyDate").innerHTML = "กรุณาเลือกวันให้มากกว่าวันปัจจุบัน และให้มากกว่าวันเริ่มเรียน";
            return false;
        }else {
            document.getElementById("invalidEndStudyDate").innerHTML = "";
        }

        //-----------เช็ค Script ก่อนข้ามหน้าไปStep3-----------
        var invalidStudyDate = document.getElementById("invalid_StudyDate").textContent;
        if (invalidStudyDate !== ""){
            alert("กรุณาเลือกระยะเวลาในการสอนใหม่");
            document.getElementById("startStudyDate").value = "";
            document.getElementById("endStudyDate").value = "";

            document.getElementById("startStudyDate").focus();
            return false;

        }

        return true;
    }
    function showHideFields() {
        var typeLearnSelect = document.getElementById("type_learn");
        var locationRow = document.getElementById("locationRow");
        var moocRow = document.getElementById("moocRow");

        var selectedOption = typeLearnSelect.value;

        if (selectedOption === "เรียนในสถานศึกษา") {
            locationRow.style.display = "block";
            moocRow.style.display = "none";

            document.getElementById('link_mooc').value = "invalid";
            document.getElementById('floatingTextarea2').value = "";
        } else if (selectedOption === "เรียนออนไลน์") {
            locationRow.style.display = "none";
            moocRow.style.display = "block";

            document.getElementById('link_mooc').value = "";
            document.getElementById('floatingTextarea2').value = "invalid";
        } else if (selectedOption === "เรียนทั้งออนไลน์และในสถานศึกษา") {
            locationRow.style.display = "block";
            moocRow.style.display = "block";

            document.getElementById('link_mooc').value = "";
            document.getElementById('floatingTextarea2').value = "";
        } else {
            locationRow.style.display = "none";
            moocRow.style.display = "none";

            document.getElementById('link_mooc').value = "invalid";
            document.getElementById('floatingTextarea2').value = "invalid";
        }
    }
    function checkScriptPage3(){
        //------------Type Teach-------------
        var type_teach = document.getElementById("type_teach").value;
        if (type_teach === "") {
            document.getElementById("invalidTypeTeach").innerHTML = "กรุณาเลือกรูปแบบการสอน";
            return false;
        }else {
            document.getElementById("invalidTypeTeach").innerHTML = "";
        }

        //------------Type Teach-------------
        var typeLearnSelect = document.getElementById("type_learn").value;
        if (typeLearnSelect === "") {
            document.getElementById("invalidTypeLearn").innerHTML = "กรุณาเลือกประเภทการเรียน";
            return false;
        }else {
            document.getElementById("invalidTypeLearn").innerHTML = "";
        }

        //------------Link Mooc-------------
        var linkMooc = document.getElementById('link_mooc').value;
        // var regExName = /^[ก-์A-Za-z0-9]{2,225}$/;
        // ตรวจสอบข้อมูลเกี่ยวกับ link mooc (สำหรับเรียนออนไลน์)
        if (document.getElementById("type_learn").value === "เรียนออนไลน์" && linkMooc.trim() === "") {
            document.getElementById("invalidLinkMooc").innerHTML = "กรุณากรอก link mooc";
            return false;
        }else if (document.getElementById("type_learn").value === "เรียนออนไลน์" && (linkMooc.trim().length < 2 || linkMooc.trim().length > 225)){
            document.getElementById("invalidLinkMooc").innerHTML = "ต้องมีจำนวน 2-225 ตัวอักษร";
            return false;
        } else {
            document.getElementById("invalidLinkMooc").innerHTML = "";
        }

        //------------Location-------------
        var location = document.getElementById('floatingTextarea2').value;
        // ตรวจสอบข้อมูลเกี่ยวกับสถานที่ (สำหรับเรียนในสถานศึกษา)
        if (document.getElementById("type_learn").value === "เรียนในสถานศึกษา" && location.trim() === "") {
            document.getElementById("invalidLocation").innerHTML = "กรุณากรอกสถานที่";
            return false;
        }else if (document.getElementById("type_learn").value === "เรียนในสถานศึกษา") {
            if (location.trim().length < 2 || location.trim().length > 225) {
                document.getElementById("invalidLocation").innerHTML = "ต้องมีจำนวน 2-225 ตัวอักษร";
                return false;
            }
        } else {
            document.getElementById("invalidLocation").innerHTML = "";
        }

        //------------Location And LinkMooc-------------
        // ตรวจสอบข้อมูลเกี่ยวกับสถานที่ (สำหรับเรียนในสถานศึกษา)
        if (document.getElementById("type_learn").value === "เรียนทั้งออนไลน์และในสถานศึกษา" && location.trim() === "") {
            document.getElementById("invalidLocation").innerHTML = "กรุณากรอกสถานที่";
            return false;
        }else if (document.getElementById("type_learn").value === "เรียนทั้งออนไลน์และในสถานศึกษา"){
            if (location.trim().length < 2 || location.trim().length > 225) {
                document.getElementById("invalidLocation").innerHTML = "ต้องมีจำนวน 2-225 ตัวอักษร";
                return false;
            }
        } else {
            document.getElementById("invalidLocation").innerHTML = "";
        }
        if (document.getElementById("type_learn").value === "เรียนทั้งออนไลน์และในสถานศึกษา" && linkMooc.trim() === "") {
            document.getElementById("invalidLinkMooc").innerHTML = "กรุณากรอก link mooc";
            return false;
        }else if (document.getElementById("type_learn").value === "เรียนทั้งออนไลน์และในสถานศึกษา"){
            if (linkMooc.trim().length < 2 || linkMooc.trim().length > 225) {
                document.getElementById("invalidLinkMooc").innerHTML = "ต้องมีจำนวน 2-225 ตัวอักษร";
                return false;
            }
        } else {
            document.getElementById("invalidLinkMooc").innerHTML = "";
        }

        return true;
    }

    function display(){
        const courseType = document.getElementById("course_type").value;
        const courseName = document.getElementById("course_name").value;
        const certificateName = document.getElementById("certificateName").value;
        const major = document.getElementById("major_id").value;
        const editorContent = document.getElementById("editor").textContent;

        const objectives = document.querySelectorAll("input[name='course_objectives[]']");
        const totalHours = document.getElementById("course_totalHours").value;
        const fee = document.getElementById("course_fee").value;
        const courseFile = document.getElementById("course_file").value;
        const targetOccupation = document.getElementById("floatingTextarea3").value;

        document.getElementById("displayCourseName").innerHTML = courseName;
        document.getElementById("displayCourseType").innerHTML = courseType;
        document.getElementById("displayCertificateName").innerHTML = certificateName;

        // document.getElementById("displayMajor").innerHTML = major;
        document.getElementById("displayCoursePrinciple").innerHTML = editorContent;
        document.getElementById('coursePrinciple').value = editorContent;
        document.getElementById("displayObjectives").innerHTML = Array.from(objectives).map(obj => obj.value).join(", ");
        document.getElementById("displayTotalHours").innerHTML = totalHours;
        if (fee === 0.0){
            document.getElementById("displayFee").innerHTML = "ไม่มีค่าธรรมเนียม";
        }else {
            document.getElementById("displayFee").innerHTML = fee+" บาท";
        }
        document.getElementById("displayCourseFile").innerHTML = courseFile;
        document.getElementById("displayTargetOccupation").innerHTML = targetOccupation;
    }
</script>
<%--เช็คประเภทหลักสูตร--%>
<script>
    var type = "inputGroupSelect01";

    document.getElementById("inputGroupSelect01").style.display = "block";
    document.getElementById("inputGroupSelect02").style.display = "none";
    document.getElementById("inputGroupSelect03").style.display = "none";

    // ตรวจสอบเมื่อเลือก "หลักสูตรอบรมระยะสั้น"
    var noCTypeRadio = document.querySelector('input[name="CType"][value="หลักสูตรอบรมระยะสั้น"]');
    noCTypeRadio.addEventListener("change", function() {
        if (noCTypeRadio.checked) {
            document.getElementById("select_course").style.display = "block";

            document.getElementById("CName").innerHTML = "หลักสูตรอบรมระยะสั้น";
            document.getElementById("inputGroupSelect01").style.display = "none";
            document.getElementById("inputGroupSelect02").style.display = "block";
            document.getElementById("inputGroupSelect03").style.display = "none";

            document.getElementById("display_Course_Name").textContent = "ชื่อหลักสูตร";

            document.getElementById('display_Course_Type').textContent = "ประเภทหลักสูตร";
            document.getElementById('display_Course_Major').textContent = "สาขาวิชา";
            document.getElementById('display_Course_Total_hours').textContent = "0";
            document.getElementById('display_Course_Fee').textContent = "0.0 บาท";
            // เปลี่ยน URL ของรูปภาพโดยใช้ JavaScript
            var newImageUrl = "${pageContext.request.contextPath}/uploads/course_img/gallery.png";
            var imageElement = document.getElementById("myImage");
            imageElement.setAttribute("src", newImageUrl);
            // document.getElementById('myImage').style.display = "none";

            document.getElementById("inputGroupSelect01").value = "";
            document.getElementById("inputGroupSelect03").value = "";
            type = "inputGroupSelect02";


            document.getElementById(type).addEventListener("change", function () {
                // รับค่าที่ถูกเลือก
                var selectedMajor = document.getElementById(type).value;
                // ค้นหาชื่อสาขาที่ถูกเลือกจาก dropdown
                var courses = document.querySelectorAll("#inputGroupSelect02 option");
                var selectElement = document.getElementById("inputGroupSelect02");

                var selectedOption = selectElement.options[selectElement.selectedIndex];
                var course_type = selectedOption.getAttribute("data-course_type");
                var major = selectedOption.getAttribute("data-major");
                var totalHours = selectedOption.getAttribute("data-totalHours");
                var fee = selectedOption.getAttribute("data-fee");
                var img = selectedOption.getAttribute("data-img");


                var selectedCourseName = "";
                for (var i = 0; i < courses.length; i++) {
                    if (courses[i].value === selectedMajor) {
                        selectedCourseName = courses[i].textContent;
                        break;
                    }
                }
                // แสดงชื่อสาขาใน <h4> element
                if(selectedCourseName === "เลือกหลักสูตร"){
                    selectedCourseName = "กรุณาเลือกหลักสูตร";
                    totalHours = "0";
                    fee = "0.0"
                }
                document.getElementById("display_Course_Name").textContent = selectedCourseName;
                if(course_type === null){
                    course_type = "ประเภทหลักสูตร";
                }
                document.getElementById('display_Course_Type').textContent = course_type;
                if(major === null){
                    major = "สาขาวิชา";
                }
                document.getElementById('display_Course_Major').textContent = major;
                document.getElementById('display_Course_Total_hours').textContent = totalHours;
                if (fee === "0.0"){
                    document.getElementById('startPayment_display').style.display = "none";
                    document.getElementById('endPayment_display').style.display = "none";
                    applicationResultElement.min = endRegisterElement.value;
                    startPaymentElement.value = currentDate;
                    endPaymentElement.value = currentDate;
                    applicationResultElement.value = "";
                    fee = "ไม่มีค่าธรรมเนียม";
                }else {
                    document.getElementById('startPayment_display').style.display = "block";
                    document.getElementById('endPayment_display').style.display = "block";
                    startPaymentElement.value = "";
                    endPaymentElement.value = "";
                    fee = fee+" บาท";
                    applicationResultElement.value = "";
                }
                document.getElementById('display_Course_Fee').textContent = fee;
                if(img === null){
                    img = "gallery.png";
                }
                document.getElementById('display_Course_IMG').textContent = img;
                document.getElementById('myImage').style.display = "block";
                // เปลี่ยน URL ของรูปภาพโดยใช้ JavaScript
                var newImageUrl = "${pageContext.request.contextPath}/uploads/course_img/" + img;
                var imageElement = document.getElementById("myImage");
                imageElement.setAttribute("src", newImageUrl);

                // โชว์ข้อมูลใน tap2
                document.getElementById('display_Course_Name_tap2').textContent = selectedCourseName;
                document.getElementById('display_Course_Major_tap2').textContent = major;
                document.getElementById('display_Course_Type_tap2').textContent = course_type;
                document.getElementById('display_Course_Total_hours_tap2').textContent = totalHours;
                document.getElementById('display_Course_Fee_tap2').textContent = fee;
                // เปลี่ยน URL ของรูปภาพโดยใช้ JavaScript
                var imageElement_tap2 = document.getElementById("myImage_tap2");
                imageElement_tap2.setAttribute("src", newImageUrl);

                // โชว์ข้อมูลใน tap3
                document.getElementById('display_Course_Name_tap3').textContent = selectedCourseName;
                document.getElementById('display_Course_Major_tap3').textContent = major;
                document.getElementById('display_Course_Type_tap3').textContent = course_type;
                document.getElementById('display_Course_Total_hours_tap3').textContent = totalHours;
                document.getElementById('display_Course_Fee_tap3').textContent = fee;
                // เปลี่ยน URL ของรูปภาพโดยใช้ JavaScript
                var imageElement_tap3 = document.getElementById("myImage_tap3");
                imageElement_tap3.setAttribute("src", newImageUrl);

                // โชว์ข้อมูลใน tap4
                document.getElementById('display_Course_Name_tap4').textContent = selectedCourseName;
                document.getElementById('display_Course_Major_tap4').textContent = major;
                document.getElementById('display_Course_Type_tap4').textContent = course_type;
                document.getElementById('display_Course_Total_hours_tap4').textContent = totalHours;
                document.getElementById('display_Course_Fee_tap4').textContent = fee;
                // เปลี่ยน URL ของรูปภาพโดยใช้ JavaScript
                var imageElement_tap4 = document.getElementById("myImage_tap4");
                imageElement_tap4.setAttribute("src", newImageUrl);
            });
        }
    });

    // ตรวจสอบเมื่อเลือก "Non-Degree"
    var cTypeRadio = document.querySelector('input[name="CType"][value="Non-Degree"]');
    cTypeRadio.addEventListener("change", function() {
        if (cTypeRadio.checked) {
            document.getElementById("select_course").style.display = "block";

            document.getElementById("CName").innerHTML = "Non-Degree";
            document.getElementById("inputGroupSelect01").style.display = "none";
            document.getElementById("inputGroupSelect02").style.display = "none";
            document.getElementById("inputGroupSelect03").style.display = "block";

            document.getElementById("display_Course_Name").textContent = "ชื่อหลักสูตร";

            document.getElementById('display_Course_Type').textContent = "ประเภทหลักสูตร";
            document.getElementById('display_Course_Major').textContent = "สาขาวิชา";
            document.getElementById('display_Course_Total_hours').textContent = "0";
            document.getElementById('display_Course_Fee').textContent = "0.0 บาท";
            // เปลี่ยน URL ของรูปภาพโดยใช้ JavaScript
            var newImageUrl = "${pageContext.request.contextPath}/uploads/course_img/gallery.png";
            var imageElement = document.getElementById("myImage");
            imageElement.setAttribute("src", newImageUrl);
            // document.getElementById('myImage').style.display = "none";

            document.getElementById("inputGroupSelect01").value = "";
            document.getElementById("inputGroupSelect02").value = "";
            type = "inputGroupSelect03";

            document.getElementById(type).addEventListener("change", function () {
                // รับค่าที่ถูกเลือก
                var selectedMajor = document.getElementById(type).value;
                // ค้นหาชื่อสาขาที่ถูกเลือกจาก dropdown
                var courses = document.querySelectorAll("#inputGroupSelect03 option");

                var selectElement = document.getElementById("inputGroupSelect03");

                var selectedOption = selectElement.options[selectElement.selectedIndex];
                var course_type = selectedOption.getAttribute("data-course_type");
                var major = selectedOption.getAttribute("data-major");
                var totalHours = selectedOption.getAttribute("data-totalHours");
                var fee = selectedOption.getAttribute("data-fee");
                var img = selectedOption.getAttribute("data-img");

                var selectedCourseName = "";
                for (var i = 0; i < courses.length; i++) {
                    if (courses[i].value === selectedMajor) {
                        selectedCourseName = courses[i].textContent;
                        break;
                    }
                }
                // แสดงชื่อสาขาใน <h4> element
                if(selectedCourseName === "เลือกหลักสูตร"){
                    selectedCourseName = "กรุณาเลือกหลักสูตร";
                    totalHours = "0";
                    fee = "0.0"
                }
                document.getElementById("display_Course_Name").textContent = selectedCourseName;
                if(course_type === null){
                    course_type = "ประเภทหลักสูตร";
                }
                document.getElementById('display_Course_Type').textContent = course_type;
                if(major === null){
                    major = "สาขาวิชา";
                }
                document.getElementById('display_Course_Major').textContent = major;
                document.getElementById('display_Course_Total_hours').textContent = totalHours;
                if (fee === "0.0"){
                    document.getElementById('startPayment_display').style.display = "none";
                    document.getElementById('endPayment_display').style.display = "none";
                    applicationResultElement.min = endRegisterElement.value;
                    startPaymentElement.value = currentDate;
                    endPaymentElement.value = currentDate;
                    applicationResultElement.value = "";
                    fee = "ไม่มีค่าธรรมเนียม";
                }else {
                    document.getElementById('startPayment_display').style.display = "block";
                    document.getElementById('endPayment_display').style.display = "block";
                    startPaymentElement.value = "";
                    endPaymentElement.value = "";
                    fee = fee+" บาท";
                    applicationResultElement.value = "";
                }
                document.getElementById('display_Course_Fee').textContent = fee;
                if(img === null){
                    img = "gallery.png";
                }
                document.getElementById('display_Course_IMG').textContent = img;
                document.getElementById('myImage').style.display = "block";
                // เปลี่ยน URL ของรูปภาพโดยใช้ JavaScript
                var newImageUrl = "${pageContext.request.contextPath}/uploads/course_img/" + img;
                var imageElement = document.getElementById("myImage");
                imageElement.setAttribute("src", newImageUrl);

                // โชว์ข้อมูลใน tap2
                document.getElementById('display_Course_Name_tap2').textContent = selectedCourseName;
                document.getElementById('display_Course_Major_tap2').textContent = major;
                document.getElementById('display_Course_Type_tap2').textContent = course_type;
                document.getElementById('display_Course_Total_hours_tap2').textContent = totalHours;
                document.getElementById('display_Course_Fee_tap2').textContent = fee;
                // เปลี่ยน URL ของรูปภาพโดยใช้ JavaScript
                var imageElement_tap2 = document.getElementById("myImage_tap2");
                imageElement_tap2.setAttribute("src", newImageUrl);

                // โชว์ข้อมูลใน tap3
                document.getElementById('display_Course_Name_tap3').textContent = selectedCourseName;
                document.getElementById('display_Course_Major_tap3').textContent = major;
                document.getElementById('display_Course_Type_tap3').textContent = course_type;
                document.getElementById('display_Course_Total_hours_tap3').textContent = totalHours;
                document.getElementById('display_Course_Fee_tap3').textContent = fee;
                // เปลี่ยน URL ของรูปภาพโดยใช้ JavaScript
                var imageElement_tap3 = document.getElementById("myImage_tap3");
                imageElement_tap3.setAttribute("src", newImageUrl);

                // โชว์ข้อมูลใน tap4
                document.getElementById('display_Course_Name_tap4').textContent = selectedCourseName;
                document.getElementById('display_Course_Major_tap4').textContent = major;
                document.getElementById('display_Course_Type_tap4').textContent = course_type;
                document.getElementById('display_Course_Total_hours_tap4').textContent = totalHours;
                document.getElementById('display_Course_Fee_tap4').textContent = fee;
                // เปลี่ยน URL ของรูปภาพโดยใช้ JavaScript
                var imageElement_tap4 = document.getElementById("myImage_tap4");
                imageElement_tap4.setAttribute("src", newImageUrl);
            });
        }
    });

    // ตรวจสอบเมื่อเลือก "หลักสูตรทั้งหมด"
    var allCTypeRadio = document.querySelector('input[name="CType"][value="หลักสูตรทั้งหมด"]');
    allCTypeRadio.addEventListener("change", function() {
        if (allCTypeRadio.checked) {
            document.getElementById("select_course").style.display = "block";

            document.getElementById("CName").innerHTML = "หลักสูตรทั้งหมด";
            document.getElementById("inputGroupSelect01").style.display = "block";
            document.getElementById("inputGroupSelect02").style.display = "none";
            document.getElementById("inputGroupSelect03").style.display = "none";

            document.getElementById("display_Course_Name").textContent = "ชื่อหลักสูตร";

            document.getElementById('display_Course_Type').textContent = "ประเภทหลักสูตร";
            document.getElementById('display_Course_Major').textContent = "สาขาวิชา";
            document.getElementById('display_Course_Total_hours').textContent = "0";
            document.getElementById('display_Course_Fee').textContent = "0.0 บาท";
            // เปลี่ยน URL ของรูปภาพโดยใช้ JavaScript
            var newImageUrl = "${pageContext.request.contextPath}/uploads/course_img/gallery.png";
            var imageElement = document.getElementById("myImage");
            imageElement.setAttribute("src", newImageUrl);
            // document.getElementById('myImage').style.display = "none";

            document.getElementById("inputGroupSelect02").value = "";
            document.getElementById("inputGroupSelect03").value = "";
            type = "inputGroupSelect01";

            document.getElementById(type).addEventListener("change", function () {
                // รับค่าที่ถูกเลือก
                var selectedMajor = document.getElementById(type).value;
                // ค้นหาชื่อสาขาที่ถูกเลือกจาก dropdown
                var courses = document.querySelectorAll("#inputGroupSelect01 option");

                var selectElement = document.getElementById("inputGroupSelect01");

                var selectedOption = selectElement.options[selectElement.selectedIndex];
                var course_type = selectedOption.getAttribute("data-course_type");
                var major = selectedOption.getAttribute("data-major");
                var totalHours = selectedOption.getAttribute("data-totalHours");
                var fee = selectedOption.getAttribute("data-fee");
                var img = selectedOption.getAttribute("data-img");

                var selectedCourseName = "";
                for (var i = 0; i < courses.length; i++) {
                    if (courses[i].value === selectedMajor) {
                        selectedCourseName = courses[i].textContent;
                        break;
                    }
                }
                // แสดงชื่อสาขาใน <h4> element
                if(selectedCourseName === "เลือกหลักสูตร"){
                    selectedCourseName = "กรุณาเลือกหลักสูตร";
                    totalHours = "0";
                    fee = "0.0"
                }
                document.getElementById("display_Course_Name").textContent = selectedCourseName;
                if(course_type === null){
                    course_type = "ประเภทหลักสูตร";
                }
                document.getElementById('display_Course_Type').textContent = course_type;
                if(major === null){
                    major = "สาขาวิชา";
                }
                document.getElementById('display_Course_Major').textContent = major;
                document.getElementById('display_Course_Total_hours').textContent = totalHours;
                if (fee === "0.0"){
                    document.getElementById('startPayment_display').style.display = "none";
                    document.getElementById('endPayment_display').style.display = "none";
                    applicationResultElement.min = endRegisterElement.value;
                    startPaymentElement.value = currentDate;
                    endPaymentElement.value = currentDate;
                    applicationResultElement.value = "";
                    fee = "ไม่มีค่าธรรมเนียม";
                }else {
                    document.getElementById('startPayment_display').style.display = "block";
                    document.getElementById('endPayment_display').style.display = "block";
                    startPaymentElement.value = "";
                    endPaymentElement.value = "";
                    fee = fee+" บาท";
                    applicationResultElement.value = "";
                }
                document.getElementById('display_Course_Fee').textContent = fee;
                if(img === null){
                    img = "gallery.png";
                }
                document.getElementById('display_Course_IMG').textContent = img;
                document.getElementById('myImage').style.display = "block";
                // เปลี่ยน URL ของรูปภาพโดยใช้ JavaScript
                var newImageUrl = "${pageContext.request.contextPath}/uploads/course_img/" + img;
                var imageElement = document.getElementById("myImage");
                imageElement.setAttribute("src", newImageUrl);

                // โชว์ข้อมูลใน tap2
                document.getElementById('display_Course_Name_tap2').textContent = selectedCourseName;
                document.getElementById('display_Course_Major_tap2').textContent = major;
                document.getElementById('display_Course_Type_tap2').textContent = course_type;
                document.getElementById('display_Course_Total_hours_tap2').textContent = totalHours;
                document.getElementById('display_Course_Fee_tap2').textContent = fee;
                // เปลี่ยน URL ของรูปภาพโดยใช้ JavaScript
                var imageElement_tap2 = document.getElementById("myImage_tap2");
                imageElement_tap2.setAttribute("src", newImageUrl);

                // โชว์ข้อมูลใน tap3
                document.getElementById('display_Course_Name_tap3').textContent = selectedCourseName;
                document.getElementById('display_Course_Major_tap3').textContent = major;
                document.getElementById('display_Course_Type_tap3').textContent = course_type;
                document.getElementById('display_Course_Total_hours_tap3').textContent = totalHours;
                document.getElementById('display_Course_Fee_tap3').textContent = fee;
                // เปลี่ยน URL ของรูปภาพโดยใช้ JavaScript
                var imageElement_tap3 = document.getElementById("myImage_tap3");
                imageElement_tap3.setAttribute("src", newImageUrl);

                // โชว์ข้อมูลใน tap4
                document.getElementById('display_Course_Name_tap4').textContent = selectedCourseName;
                document.getElementById('display_Course_Major_tap4').textContent = major;
                document.getElementById('display_Course_Type_tap4').textContent = course_type;
                document.getElementById('display_Course_Total_hours_tap4').textContent = totalHours;
                document.getElementById('display_Course_Fee_tap4').textContent = fee;
                // เปลี่ยน URL ของรูปภาพโดยใช้ JavaScript
                var imageElement_tap4 = document.getElementById("myImage_tap4");
                imageElement_tap4.setAttribute("src", newImageUrl);
            });
        }
    });
</script>
<script>
    // สร้างวันที่ปัจจุบันในรูปแบบ yyyy-mm-dd
    var currentDate = new Date().toISOString().split('T')[0];

    // กำหนดค่าต่ำสุด <input>
    document.getElementById("startRegister").min = currentDate;
    document.getElementById("endRegister").min = currentDate;
    document.getElementById("startPayment").min = currentDate;
    document.getElementById("endPayment").min = currentDate;
    document.getElementById("applicationResult").min = currentDate;
    document.getElementById("startStudyDate").min = currentDate;
    document.getElementById("endStudyDate").min = currentDate;

    var startRegisterElement = document.getElementById("startRegister");
    var endRegisterElement = document.getElementById("endRegister");
    var startPaymentElement = document.getElementById("startPayment");
    var endPaymentElement = document.getElementById("endPayment");
    var applicationResultElement = document.getElementById("applicationResult");
    var startStudyDateElement = document.getElementById("startStudyDate");
    var endStudyDateElement = document.getElementById("endStudyDate");

    // กำหนดค่าเริ่มต้น endRegister
    // ตรวจสอบเมื่อผู้ใช้เปลี่ยนค่าใน startRegister
    startRegisterElement.addEventListener("change", function() {
        var selectedStartDate = new Date(startRegisterElement.value);
        var setSelectedEndDate = new Date(startRegisterElement.value);
        var setSelectedEndDate2 = new Date(startRegisterElement.value);
        var selectedEndDate = new Date(endRegisterElement.value);
        var selectedStartPayDate = new Date(startPaymentElement.value);

        // เพิ่ม 1 วันลงในวันปัจจุบัน
        setSelectedEndDate.setDate(setSelectedEndDate.getDate() + 1);
        // แปลงวันปัจจุบันให้เป็นรูปแบบ YYYY-MM-DD (ตรงกับรูปแบบ input type="date")
        var formattedDate = setSelectedEndDate.toISOString().split("T")[0];

        var formattedDate2 = setSelectedEndDate2.toISOString().split("T")[0];

        endRegisterElement.min = formattedDate;
        startPaymentElement.min = formattedDate2;
        // startPaymentElement.min = formattedDate;
        // endPaymentElement.min = formattedDate;
        // applicationResultElement.min = formattedDate;
        if (selectedStartDate >= selectedEndDate) {
            endRegisterElement.value = selectedStartDate.toISOString().slice(0, 16);
        }
        if (selectedStartDate >= selectedStartPayDate) {
            startPaymentElement.value = selectedStartDate.toISOString().slice(0, 16);
        }
    });

    // กำหนดค่าเริ่มต้น endRegister
    // ตรวจสอบเมื่อผู้ใช้เปลี่ยนค่าใน startPayment
    endRegisterElement.addEventListener("change", function() {
        var selectedEndRegisterDate = new Date(endRegisterElement.value);
        var setSelectedEndRegisterDate = new Date(endRegisterElement.value);
        var selectedApplicationResultDate = new Date(applicationResultElement.value);
        const fee = document.getElementById("display_Course_Fee").textContent;



        // เพิ่ม 1 วันลงในวันปัจจุบัน
        setSelectedEndRegisterDate.setDate(setSelectedEndRegisterDate.getDate() + 1);
        // แปลงวันปัจจุบันให้เป็นรูปแบบ YYYY-MM-DD (ตรงกับรูปแบบ input type="date")
        var formattedDate = setSelectedEndRegisterDate.toISOString().split("T")[0];

        if (fee === "ไม่มีค่าธรรมเนียม"){
            applicationResultElement.min = formattedDate;
        }
        // endPaymentElement.min = formattedDate;
        // applicationResultElement.min = formattedDate;
        if (selectedEndRegisterDate >= selectedApplicationResultDate){
            applicationResultElement.value = selectedEndRegisterDate.toISOString().slice(0, 16);
        }
    });
    // กำหนดค่าเริ่มต้น startPayment
    // ตรวจสอบเมื่อผู้ใช้เปลี่ยนค่าใน endRegister
    startPaymentElement.addEventListener("change", function() {
        var selectedStartPaymentDate = new Date(startPaymentElement.value);
        var setSelectedStartPaymentDate = new Date(startPaymentElement.value);
        var selectedEndPaymentDate = new Date(endPaymentElement.value);

        // เพิ่ม 1 วันลงในวันปัจจุบัน
        setSelectedStartPaymentDate.setDate(setSelectedStartPaymentDate.getDate() + 1);
        // แปลงวันปัจจุบันให้เป็นรูปแบบ YYYY-MM-DD (ตรงกับรูปแบบ input type="date")
        var formattedDate = setSelectedStartPaymentDate.toISOString().split("T")[0];

        endPaymentElement.min = formattedDate;
        // applicationResultElement.min = formattedDate;
        if (selectedStartPaymentDate >= selectedEndPaymentDate) {
            endPaymentElement.value = selectedStartPaymentDate.toISOString().slice(0, 16);
        }
    });
    // กำหนดค่าเริ่มต้น endPayment
    // ตรวจสอบเมื่อผู้ใช้เปลี่ยนค่าใน applicationResult
    endPaymentElement.addEventListener("change", function() {
        var selectedEndPaymentDate = new Date(endPaymentElement.value);
        var setSelectedEndPaymentDate = new Date(endPaymentElement.value);
        var selectedApplicationResultDate = new Date(applicationResultElement.value);

        // เพิ่ม 1 วันลงในวันปัจจุบัน
        setSelectedEndPaymentDate.setDate(setSelectedEndPaymentDate.getDate() + 1);
        // แปลงวันปัจจุบันให้เป็นรูปแบบ YYYY-MM-DD (ตรงกับรูปแบบ input type="date")
        var formattedDate = setSelectedEndPaymentDate.toISOString().split("T")[0];

        applicationResultElement.min = formattedDate;
        if (selectedEndPaymentDate >= selectedApplicationResultDate) {
            applicationResultElement.value = selectedEndPaymentDate.toISOString().slice(0, 16);
        }
    });
    // กำหนดค่าเริ่มต้น endPayment
    // ตรวจสอบเมื่อผู้ใช้เปลี่ยนค่าใน applicationResult
    applicationResultElement.addEventListener("change", function() {
        var selectedStartStudyDate = new Date(startStudyDateElement.value);
        var setSelectedApplicationResultDate = new Date(applicationResultElement.value);
        var selectedApplicationResultDate = new Date(applicationResultElement.value);

        // เพิ่ม 1 วันลงในวันปัจจุบัน
        setSelectedApplicationResultDate.setDate(setSelectedApplicationResultDate.getDate() + 1);
        // แปลงวันปัจจุบันให้เป็นรูปแบบ YYYY-MM-DD (ตรงกับรูปแบบ input type="date")
        var formattedDate = setSelectedApplicationResultDate.toISOString().split("T")[0];

        startStudyDateElement.min = formattedDate;
        if (selectedApplicationResultDate >= selectedStartStudyDate) {
            startStudyDateElement.value = selectedApplicationResultDate.toISOString().slice(0, 16);
        }
    });
    // กำหนดค่าเริ่มต้น endPayment
    // ตรวจสอบเมื่อผู้ใช้เปลี่ยนค่าใน applicationResult
    //Check วันในการเรียนการสอนจาก DB
    startStudyDateElement.addEventListener("change", function() {
        var selectedEndStudyDate = new Date(endStudyDateElement.value);
        var setSelectedStartStudyDate = new Date(startStudyDateElement.value);
        var selectedStartStudyDate = new Date(startStudyDateElement.value);

        // เพิ่ม 1 วันลงในวันปัจจุบัน
        setSelectedStartStudyDate.setDate(setSelectedStartStudyDate.getDate() + 1);
        // แปลงวันปัจจุบันให้เป็นรูปแบบ YYYY-MM-DD (ตรงกับรูปแบบ input type="date")
        var formattedDate = setSelectedStartStudyDate.toISOString().split("T")[0];

        endStudyDateElement.min = formattedDate;
        if (selectedStartStudyDate >= selectedEndStudyDate) {
            endStudyDateElement.value = selectedStartStudyDate.toISOString().slice(0, 16);
        }
    });

    function checkEndDate(inputEndDate) {
        var inputStartDate = startStudyDateElement.value;
        var endStudyDate = new Date(inputEndDate);
        var timeDiff = Math.abs(endStudyDate - new Date(inputStartDate));
        var daysDiff = Math.ceil(timeDiff / (1000 * 3600 * 24));
        var totalWeek = document.getElementById("time_difference_study_course").textContent;

        if (daysDiff < (parseInt(totalWeek)*7)){
            document.getElementById('invalid_StudyDate').textContent = "ควรมีการเรียนการสอนอย่างน้อย " + totalWeek + " สัปดาห์";
            return;
        }else {
            document.getElementById('invalid_StudyDate').textContent = "";
        }
    }
</script>
<script>
    // ข้อมูลที่คุณระบุ
    var data = '${request_open_course.studyTime}';
    var days = ["mo", "tu", "we", "th", "fr", "sa", "su"];

    // วนลูปผ่านทุกวัน
    for (var i = 0; i < days.length; i++) {
        var day = days[i];
        var checkbox = document.getElementById("chk_" + day);
        var startInput = document.getElementById("start_chk_" + day);
        var endInput = document.getElementById("end_chk_" + day);
        var invalidLabel = document.getElementById("invalid_chk_" + day);
        var totalToSave = document.getElementById("total_to_save_chk_" + day);
        var totalToCal = document.getElementById("total_to_cal_chk_" + day);

        if (data.includes(day)) {
            var dayData = data.split(day + "/")[1].split("$%")[0];
            var [startTime, endTime] = dayData.split("/");

            checkbox.checked = true;
            startInput.value = startTime;
            endInput.value = endTime;
            totalToSave.value = dayData;
            totalToCal.value = calculateTime(day);
            invalidLabel.textContent = ""; // ลบข้อความเตือน
        }
    }
</script>
<script>
    // สมมติข้อมูลจากฐานข้อมูล
    var dataFromDB = "${request_open_course.studyTime}";
    var entries = dataFromDB.split("$%");

    // สร้างรายการเพื่อเก็บข้อมูลแต่ละวัน
    var dayData = {};

    entries.forEach(function(entry) {
        var parts = entry.split("/");
        var day = parts[0];
        var start = parts[1];
        var end = parts[2];

        dayData[day] = {
            start: start,
            end: end
        };
    });

    // ตั้งค่าสถานะ Checkbox และเวลาเริ่ม/สิ้นสุด
    for (var day in dayData) {
        var checkbox = document.getElementById("chk_" + day);
        var startInput = document.getElementById("start_chk_" + day);
        var endInput = document.getElementById("end_chk_" + day);

        if (checkbox && startInput && endInput) {
            checkbox.checked = true;
            startInput.disabled = false;
            endInput.disabled = false;
            startInput.value = dayData[day].start;
            endInput.value = dayData[day].end;
        }
    }
</script>
<%--เช็คประเภทหลักสูตร--%>
<script>
    function checkLabelValue() {
        var type = "inputGroupSelect01";
        var checkCTypeRadio = document.querySelector('input[name="CType"][value="หลักสูตรอบรมระยะสั้น"]');
        var checkNTypeRadio = document.querySelector('input[name="CType"][value="Non-Degree"]');
        var checkOTypeRadio = document.querySelector('input[name="CType"][value="หลักสูตรทั้งหมด"]');
        if(checkCTypeRadio.checked){
            document.getElementById("inputGroupSelect01").style.display = "none";
            document.getElementById("inputGroupSelect02").style.display = "block";
            document.getElementById("inputGroupSelect03").style.display = "none";
            document.getElementById("CName").innerHTML = "หลักสูตรอบรมระยะสั้น";
            toCheckCTypeRadio();
            CTypeRadio();
        }else if(checkNTypeRadio.checked){
            document.getElementById("inputGroupSelect01").style.display = "none";
            document.getElementById("inputGroupSelect02").style.display = "none";
            document.getElementById("inputGroupSelect03").style.display = "block";
            document.getElementById("CName").innerHTML = "Non-Degree";
            toCheckNTypeRadio();
            NTypeRadio();
        }else if(checkOTypeRadio.checked){
            document.getElementById("inputGroupSelect01").style.display = "block";
            document.getElementById("inputGroupSelect02").style.display = "none";
            document.getElementById("inputGroupSelect03").style.display = "none";
            document.getElementById("CName").innerHTML = "หลักสูตรทั้งหมด";
            toCheckOTypeRadio();
            OTypeRadio();
        }
    }
    window.addEventListener('load', checkLabelValue);

    function toCheckCTypeRadio() {
        document.getElementById("select_course").style.display = "block";

        document.getElementById("CName").innerHTML = "หลักสูตรอบรมระยะสั้น";
        document.getElementById("inputGroupSelect01").style.display = "none";
        document.getElementById("inputGroupSelect02").style.display = "block";
        document.getElementById("inputGroupSelect03").style.display = "none";

        document.getElementById("display_Course_Name").textContent = "ชื่อหลักสูตร";

        document.getElementById('display_Course_Type').textContent = "ประเภทหลักสูตร";
        document.getElementById('display_Course_Major').textContent = "สาขาวิชา";
        document.getElementById('display_Course_Total_hours').textContent = "0";
        document.getElementById('display_Course_Fee').textContent = "0.0 บาท";
        // เปลี่ยน URL ของรูปภาพโดยใช้ JavaScript
        var newImageUrl = "${pageContext.request.contextPath}/uploads/course_img/gallery.png";
        var imageElement = document.getElementById("myImage");
        imageElement.setAttribute("src", newImageUrl);
        // document.getElementById('myImage').style.display = "none";

        document.getElementById("inputGroupSelect01").value = "";
        document.getElementById("inputGroupSelect03").value = "";
        type = "inputGroupSelect02";


        document.getElementById(type).addEventListener("change", function () {
            CTypeRadio();
        });
    }
    function CTypeRadio() {
        // รับค่าที่ถูกเลือก
        var selectedMajor = document.getElementById("inputGroupSelect02").value;
        // ค้นหาชื่อสาขาที่ถูกเลือกจาก dropdown
        var courses = document.querySelectorAll("#inputGroupSelect02 option");
        var selectElement = document.getElementById("inputGroupSelect02");

        var selectedOption = selectElement.options[selectElement.selectedIndex];
        var course_type = selectedOption.getAttribute("data-course_type");
        var major = selectedOption.getAttribute("data-major");
        var totalHours = selectedOption.getAttribute("data-totalHours");
        var fee = selectedOption.getAttribute("data-fee");
        var img = selectedOption.getAttribute("data-img");


        var selectedCourseName = "";
        for (var i = 0; i < courses.length; i++) {
            if (courses[i].value === selectedMajor) {
                selectedCourseName = courses[i].textContent;
                document.getElementById("cId").value = courses[i].value;
                break;
            }
        }
        // แสดงชื่อสาขาใน <h4> element
        if(selectedCourseName === "เลือกหลักสูตร"){
            selectedCourseName = "กรุณาเลือกหลักสูตร";
            totalHours = "0";
            fee = "0.0"
        }
        document.getElementById("display_Course_Name").textContent = selectedCourseName;
        if(course_type === null){
            course_type = "ประเภทหลักสูตร";
        }
        document.getElementById('display_Course_Type').textContent = course_type;
        if(major === null){
            major = "สาขาวิชา";
        }
        document.getElementById('display_Course_Major').textContent = major;
        document.getElementById('display_Course_Total_hours').textContent = totalHours;
        if (fee === "0.0"){
            document.getElementById('startPayment_display').style.display = "none";
            document.getElementById('endPayment_display').style.display = "none";
            applicationResultElement.min = endRegisterElement.value;
            startPaymentElement.value = currentDate;
            endPaymentElement.value = currentDate;
            // applicationResultElement.value = "";
            fee = "ไม่มีค่าธรรมเนียม";
        }else {
            document.getElementById('startPayment_display').style.display = "block";
            document.getElementById('endPayment_display').style.display = "block";
            // startPaymentElement.value = "";
            // endPaymentElement.value = "";
            fee = fee+" บาท";
            // applicationResultElement.value = "";
        }
        document.getElementById('display_Course_Fee').textContent = fee;
        if(img === null){
            img = "gallery.png";
        }
        document.getElementById('display_Course_IMG').textContent = img;
        document.getElementById('myImage').style.display = "block";
        // เปลี่ยน URL ของรูปภาพโดยใช้ JavaScript
        var newImageUrl = "${pageContext.request.contextPath}/uploads/course_img/" + img;
        var imageElement = document.getElementById("myImage");
        imageElement.setAttribute("src", newImageUrl);

        // โชว์ข้อมูลใน tap2
        document.getElementById('display_Course_Name_tap2').textContent = selectedCourseName;
        document.getElementById('display_Course_Major_tap2').textContent = major;
        document.getElementById('display_Course_Type_tap2').textContent = course_type;
        document.getElementById('display_Course_Total_hours_tap2').textContent = totalHours;
        document.getElementById('display_Course_Fee_tap2').textContent = fee;
        // เปลี่ยน URL ของรูปภาพโดยใช้ JavaScript
        var imageElement_tap2 = document.getElementById("myImage_tap2");
        imageElement_tap2.setAttribute("src", newImageUrl);

        // โชว์ข้อมูลใน tap3
        document.getElementById('display_Course_Name_tap3').textContent = selectedCourseName;
        document.getElementById('display_Course_Major_tap3').textContent = major;
        document.getElementById('display_Course_Type_tap3').textContent = course_type;
        document.getElementById('display_Course_Total_hours_tap3').textContent = totalHours;
        document.getElementById('display_Course_Fee_tap3').textContent = fee;
        // เปลี่ยน URL ของรูปภาพโดยใช้ JavaScript
        var imageElement_tap3 = document.getElementById("myImage_tap3");
        imageElement_tap3.setAttribute("src", newImageUrl);

        // โชว์ข้อมูลใน tap4
        document.getElementById('display_Course_Name_tap4').textContent = selectedCourseName;
        document.getElementById('display_Course_Major_tap4').textContent = major;
        document.getElementById('display_Course_Type_tap4').textContent = course_type;
        document.getElementById('display_Course_Total_hours_tap4').textContent = totalHours;
        document.getElementById('display_Course_Fee_tap4').textContent = fee;
        // เปลี่ยน URL ของรูปภาพโดยใช้ JavaScript
        var imageElement_tap4 = document.getElementById("myImage_tap4");
        imageElement_tap4.setAttribute("src", newImageUrl);
    }

    function toCheckNTypeRadio() {
        document.getElementById("select_course").style.display = "block";

        document.getElementById("CName").innerHTML = "Non-Degree";
        document.getElementById("inputGroupSelect01").style.display = "none";
        document.getElementById("inputGroupSelect02").style.display = "none";
        document.getElementById("inputGroupSelect03").style.display = "block";

        document.getElementById("display_Course_Name").textContent = "ชื่อหลักสูตร";

        document.getElementById('display_Course_Type').textContent = "ประเภทหลักสูตร";
        document.getElementById('display_Course_Major').textContent = "สาขาวิชา";
        document.getElementById('display_Course_Total_hours').textContent = "0";
        document.getElementById('display_Course_Fee').textContent = "0.0 บาท";
        // เปลี่ยน URL ของรูปภาพโดยใช้ JavaScript
        var newImageUrl = "${pageContext.request.contextPath}/uploads/course_img/gallery.png";
        var imageElement = document.getElementById("myImage");
        imageElement.setAttribute("src", newImageUrl);
        // document.getElementById('myImage').style.display = "none";

        document.getElementById("inputGroupSelect01").value = "";
        document.getElementById("inputGroupSelect02").value = "";
        type = "inputGroupSelect03";

        document.getElementById(type).addEventListener("change", function () {
            NTypeRadio();
        });
    }
    function NTypeRadio() {
        // รับค่าที่ถูกเลือก
        var selectedMajor = document.getElementById("inputGroupSelect03").value;
        // ค้นหาชื่อสาขาที่ถูกเลือกจาก dropdown
        var courses = document.querySelectorAll("#inputGroupSelect03 option");

        var selectElement = document.getElementById("inputGroupSelect03");

        var selectedOption = selectElement.options[selectElement.selectedIndex];
        var course_type = selectedOption.getAttribute("data-course_type");
        var major = selectedOption.getAttribute("data-major");
        var totalHours = selectedOption.getAttribute("data-totalHours");
        var fee = selectedOption.getAttribute("data-fee");
        var img = selectedOption.getAttribute("data-img");

        var selectedCourseName = "";
        for (var i = 0; i < courses.length; i++) {
            if (courses[i].value === selectedMajor) {
                selectedCourseName = courses[i].textContent;
                document.getElementById("cId").value = courses[i].value;
                break;
            }
        }
        // แสดงชื่อสาขาใน <h4> element
        if(selectedCourseName === "เลือกหลักสูตร"){
            selectedCourseName = "กรุณาเลือกหลักสูตร";
            totalHours = "0";
            fee = "0.0"
        }
        document.getElementById("display_Course_Name").textContent = selectedCourseName;
        if(course_type === null){
            course_type = "ประเภทหลักสูตร";
        }
        document.getElementById('display_Course_Type').textContent = course_type;
        if(major === null){
            major = "สาขาวิชา";
        }
        document.getElementById('display_Course_Major').textContent = major;
        document.getElementById('display_Course_Total_hours').textContent = totalHours;
        if (fee === "0.0"){
            document.getElementById('startPayment_display').style.display = "none";
            document.getElementById('endPayment_display').style.display = "none";
            applicationResultElement.min = endRegisterElement.value;
            startPaymentElement.value = currentDate;
            endPaymentElement.value = currentDate;
            applicationResultElement.value = "";
            fee = "ไม่มีค่าธรรมเนียม";
        }else {
            document.getElementById('startPayment_display').style.display = "block";
            document.getElementById('endPayment_display').style.display = "block";
            // startPaymentElement.value = "";
            // endPaymentElement.value = "";
            fee = fee+" บาท";
            // applicationResultElement.value = "";
        }
        document.getElementById('display_Course_Fee').textContent = fee;
        if(img === null){
            img = "gallery.png";
        }
        document.getElementById('display_Course_IMG').textContent = img;
        document.getElementById('myImage').style.display = "block";
        // เปลี่ยน URL ของรูปภาพโดยใช้ JavaScript
        var newImageUrl = "${pageContext.request.contextPath}/uploads/course_img/" + img;
        var imageElement = document.getElementById("myImage");
        imageElement.setAttribute("src", newImageUrl);

        // โชว์ข้อมูลใน tap2
        document.getElementById('display_Course_Name_tap2').textContent = selectedCourseName;
        document.getElementById('display_Course_Major_tap2').textContent = major;
        document.getElementById('display_Course_Type_tap2').textContent = course_type;
        document.getElementById('display_Course_Total_hours_tap2').textContent = totalHours;
        document.getElementById('display_Course_Fee_tap2').textContent = fee;
        // เปลี่ยน URL ของรูปภาพโดยใช้ JavaScript
        var imageElement_tap2 = document.getElementById("myImage_tap2");
        imageElement_tap2.setAttribute("src", newImageUrl);

        // โชว์ข้อมูลใน tap3
        document.getElementById('display_Course_Name_tap3').textContent = selectedCourseName;
        document.getElementById('display_Course_Major_tap3').textContent = major;
        document.getElementById('display_Course_Type_tap3').textContent = course_type;
        document.getElementById('display_Course_Total_hours_tap3').textContent = totalHours;
        document.getElementById('display_Course_Fee_tap3').textContent = fee;
        // เปลี่ยน URL ของรูปภาพโดยใช้ JavaScript
        var imageElement_tap3 = document.getElementById("myImage_tap3");
        imageElement_tap3.setAttribute("src", newImageUrl);

        // โชว์ข้อมูลใน tap4
        document.getElementById('display_Course_Name_tap4').textContent = selectedCourseName;
        document.getElementById('display_Course_Major_tap4').textContent = major;
        document.getElementById('display_Course_Type_tap4').textContent = course_type;
        document.getElementById('display_Course_Total_hours_tap4').textContent = totalHours;
        document.getElementById('display_Course_Fee_tap4').textContent = fee;
        // เปลี่ยน URL ของรูปภาพโดยใช้ JavaScript
        var imageElement_tap4 = document.getElementById("myImage_tap4");
        imageElement_tap4.setAttribute("src", newImageUrl);
    }

    function toCheckOTypeRadio() {
        document.getElementById("select_course").style.display = "block";

        document.getElementById("CName").innerHTML = "หลักสูตรทั้งหมด";
        document.getElementById("inputGroupSelect01").style.display = "block";
        document.getElementById("inputGroupSelect02").style.display = "none";
        document.getElementById("inputGroupSelect03").style.display = "none";

        document.getElementById("display_Course_Name").textContent = "ชื่อหลักสูตร";

        document.getElementById('display_Course_Type').textContent = "ประเภทหลักสูตร";
        document.getElementById('display_Course_Major').textContent = "สาขาวิชา";
        document.getElementById('display_Course_Total_hours').textContent = "0";
        document.getElementById('display_Course_Fee').textContent = "0.0 บาท";
        // เปลี่ยน URL ของรูปภาพโดยใช้ JavaScript
        var newImageUrl = "${pageContext.request.contextPath}/uploads/course_img/gallery.png";
        var imageElement = document.getElementById("myImage");
        imageElement.setAttribute("src", newImageUrl);
        // document.getElementById('myImage').style.display = "none";

        document.getElementById("inputGroupSelect02").value = "";
        document.getElementById("inputGroupSelect03").value = "";
        type = "inputGroupSelect01";

        document.getElementById(type).addEventListener("change", function () {
            OTypeRadio();
        });
    }
    function OTypeRadio() {
        // รับค่าที่ถูกเลือก
        var selectedMajor = document.getElementById("inputGroupSelect01").value;
        // ค้นหาชื่อสาขาที่ถูกเลือกจาก dropdown
        var courses = document.querySelectorAll("#inputGroupSelect01 option");

        var selectElement = document.getElementById("inputGroupSelect01");

        var selectedOption = selectElement.options[selectElement.selectedIndex];
        var course_type = selectedOption.getAttribute("data-course_type");
        var major = selectedOption.getAttribute("data-major");
        var totalHours = selectedOption.getAttribute("data-totalHours");
        var fee = selectedOption.getAttribute("data-fee");
        var img = selectedOption.getAttribute("data-img");

        var selectedCourseName = "";
        for (var i = 0; i < courses.length; i++) {
            if (courses[i].value === selectedMajor) {
                selectedCourseName = courses[i].textContent;
                document.getElementById("cId").value = courses[i].value;
                break;
            }
        }
        // แสดงชื่อสาขาใน <h4> element
        if(selectedCourseName === "เลือกหลักสูตร"){
            selectedCourseName = "กรุณาเลือกหลักสูตร";
            totalHours = "0";
            fee = "0.0"
        }
        document.getElementById("display_Course_Name").textContent = selectedCourseName;
        if(course_type === null){
            course_type = "ประเภทหลักสูตร";
        }
        document.getElementById('display_Course_Type').textContent = course_type;
        if(major === null){
            major = "สาขาวิชา";
        }
        document.getElementById('display_Course_Major').textContent = major;
        document.getElementById('display_Course_Total_hours').textContent = totalHours;
        if (fee === "0.0"){
            document.getElementById('startPayment_display').style.display = "none";
            document.getElementById('endPayment_display').style.display = "none";
            applicationResultElement.min = endRegisterElement.value;
            startPaymentElement.value = currentDate;
            endPaymentElement.value = currentDate;
            applicationResultElement.value = "";
            fee = "ไม่มีค่าธรรมเนียม";
        }else {
            document.getElementById('startPayment_display').style.display = "block";
            document.getElementById('endPayment_display').style.display = "block";
            // startPaymentElement.value = "";
            // endPaymentElement.value = "";
            fee = fee+" บาท";
            // applicationResultElement.value = "";
        }
        document.getElementById('display_Course_Fee').textContent = fee;
        if(img === null){
            img = "gallery.png";
        }
        document.getElementById('display_Course_IMG').textContent = img;
        document.getElementById('myImage').style.display = "block";
        // เปลี่ยน URL ของรูปภาพโดยใช้ JavaScript
        var newImageUrl = "${pageContext.request.contextPath}/uploads/course_img/" + img;
        var imageElement = document.getElementById("myImage");
        imageElement.setAttribute("src", newImageUrl);

        // โชว์ข้อมูลใน tap2
        document.getElementById('display_Course_Name_tap2').textContent = selectedCourseName;
        document.getElementById('display_Course_Major_tap2').textContent = major;
        document.getElementById('display_Course_Type_tap2').textContent = course_type;
        document.getElementById('display_Course_Total_hours_tap2').textContent = totalHours;
        document.getElementById('display_Course_Fee_tap2').textContent = fee;
        // เปลี่ยน URL ของรูปภาพโดยใช้ JavaScript
        var imageElement_tap2 = document.getElementById("myImage_tap2");
        imageElement_tap2.setAttribute("src", newImageUrl);

        // โชว์ข้อมูลใน tap3
        document.getElementById('display_Course_Name_tap3').textContent = selectedCourseName;
        document.getElementById('display_Course_Major_tap3').textContent = major;
        document.getElementById('display_Course_Type_tap3').textContent = course_type;
        document.getElementById('display_Course_Total_hours_tap3').textContent = totalHours;
        document.getElementById('display_Course_Fee_tap3').textContent = fee;
        // เปลี่ยน URL ของรูปภาพโดยใช้ JavaScript
        var imageElement_tap3 = document.getElementById("myImage_tap3");
        imageElement_tap3.setAttribute("src", newImageUrl);

        // โชว์ข้อมูลใน tap4
        document.getElementById('display_Course_Name_tap4').textContent = selectedCourseName;
        document.getElementById('display_Course_Major_tap4').textContent = major;
        document.getElementById('display_Course_Type_tap4').textContent = course_type;
        document.getElementById('display_Course_Total_hours_tap4').textContent = totalHours;
        document.getElementById('display_Course_Fee_tap4').textContent = fee;
        // เปลี่ยน URL ของรูปภาพโดยใช้ JavaScript
        var imageElement_tap4 = document.getElementById("myImage_tap4");
        imageElement_tap4.setAttribute("src", newImageUrl);
    }

    // ตรวจสอบเมื่อเลือก "หลักสูตรอบรมระยะสั้น"
    var noCTypeRadio = document.querySelector('input[name="CType"][value="หลักสูตรอบรมระยะสั้น"]');
    noCTypeRadio.addEventListener("change", function() {
        if (noCTypeRadio.checked) {
            toCheckCTypeRadio();
        }
    });

    // ตรวจสอบเมื่อเลือก "Non-Degree"
    var cTypeRadio = document.querySelector('input[name="CType"][value="Non-Degree"]');
    cTypeRadio.addEventListener("change", function() {
        if (cTypeRadio.checked) {
            toCheckNTypeRadio();
        }
    });

    // ตรวจสอบเมื่อเลือก "หลักสูตรทั้งหมด"
    var allCTypeRadio = document.querySelector('input[name="CType"][value="หลักสูตรทั้งหมด"]');
    allCTypeRadio.addEventListener("change", function() {
        if (allCTypeRadio.checked) {
            toCheckOTypeRadio();
        }
    });
</script>
</html>