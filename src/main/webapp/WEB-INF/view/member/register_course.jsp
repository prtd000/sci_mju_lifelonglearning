<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="lifelong.model.Admin" %>
<%@ page import="lifelong.model.Member" %>
<%@ page import="lifelong.model.Lecturer" %>
<%@ page import="java.time.LocalDate" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
    <title>Course Detail</title>
    <%--    bootstrap--%>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
            crossorigin="anonymous"></script>

    <%--    Google Font--%>
    <link href="https://fonts.googleapis.com/css2?family=Mitr:wght@200&family=Prompt:wght@200&display=swap"
          rel="stylesheet">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>

    <jsp:include page="/WEB-INF/view/layouts/detail-all-style.jsp"/>

    <style>
        .banner {
            width: 100%;
            height: 54%;
            object-fit: cover;
            object-position: top;
            filter: brightness(0.7);
        }

        .header_1 {
            font-family: 'Archivo', sans-serif;
            position: absolute;
            font-size: 60px;
            font-weight: 900;
            top: 24%;
            left: 10%;
            color: white;
        }

        .header_2 {
            font-family: 'Archivo', sans-serif;
            position: absolute;
            font-size: 33px;
            font-weight: 700;
            top: 35%;
            left: 10%;
            letter-spacing: 1px;
            color: white;
        }


        .block_position {
            margin-left: 10%;
            margin-top: 5%;
        }

        .c_name {
            color: black;
            width: 85%;
            font-size: 35px;
            font-weight: bold;
        }

        .block_c_type{
            height: 7%;
            background-color: white;
            border-radius: 21px;
            box-shadow: 0px 0px 10px 2px #dedddd;
            padding: 12px 0px 0px 19px;
        }

        .course_type {
            color: #f37509;
            font-weight: bold;
            font-size: 100%;
        }

        .img {
            width: 65%;
            margin-left: 5%;
            border-radius: 15px;
            box-shadow: 0px 0px 10px 2px #b8b6b6;
        }

        .c_principle {
            width: 220%;
            text-align: justify;
            color: black;
            font-size: 90%;
        }

        table[class='detail'] tr td:first-child {
            vertical-align: middle;
            width: 20%;
            font-size: 90%;
        }

        table[class='detail'] tr td {
            vertical-align: middle;
            font-weight: bold;
            font-size: 90%;
        }

        tr {
            height: 50px;
        }

        .block_contactor{
            background-color: #ffffff;
            padding: 20px 0px 30px 0px;
            width: 65%;
            margin-left: 5%;
            border-radius: 8px;
            box-shadow: 0px 0px 10px 2px #dedddd;
        }
        .contact{
            color: black;
            margin-left: 33px;
            margin-top: 25px;
        }


        /**************** Activity *****************/
        .block_news_big{
            margin-bottom: 50px;
        }

        .block_news {
            box-shadow: 0px 0px 10px 2px #bebcbc;
            border-radius: 14px;
            width: 350px;
            height: 510px;
            margin-right: 30px;
            margin-bottom: 10%;
        }

        .news_img {
            height: 250px;
            width: 350px;
            object-fit: cover;
            border-radius: 14px 14px 0px 0px;
        }

        .news_content {
            padding: 21px 25px 2px 25px;
        }

        .header_news {
            color: black;
            font-weight: bold;
            font-size: 28px;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
            width: 300px;
        }

        div.block_detail_news {
            max-height: calc(5 * 1.4em); /* 5 บรรทัด * ความสูงของแต่ละบรรทัด (1.2em) */
            overflow: hidden;
            position: relative;
        }

        div.block_detail_news::before {
            content: " ..."; /* เพิ่ม ellipsis นำหน้าข้อความที่ตัด */
            position: absolute;
            bottom: 0;
            right: 0;
            background: white; /* สีพื้นหลังของ ellipsis */
            padding-left: 5px; /* ระยะห่างระหว่าง ellipsis และข้อความ */
        }

        .detail_news {
            color: black;
            font-size: 15px;
        }



    </style>
</head>
<body>
<!-- Navbar Start -->
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

<c:set var="flag" value="<%= flag %>"/>
<c:choose>
    <c:when test="${flag.equals('member')}">
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
                    <a href="${pageContext.request.contextPath}/" class="nav-item nav-link" style="font-size: 17px">หน้าหลัก</a>
                        <%--                    <a href="#" class="nav-item nav-link" style="font-size: 17px">เกี่ยวกับคณะ</a>--%>
                        <%--            <div class="nav-item dropdown">--%>
                        <%--                <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">หลักสูตรการอบรม</a>--%>
                    <a href="${pageContext.request.contextPath}/search_course" class="nav-item nav-link active"
                       style="font-size: 17px">หลักสูตรการอบรม</a>
                        <%--                <div class="dropdown-menu m-0">--%>
                        <%--                    <a href="#" class="dropdown-item">Reskill/Upskill</a>--%>
                        <%--                    <a href="#" class="dropdown-item">อบรมระยะสั้น</a>--%>
                        <%--                </div>--%>
                        <%--            </div>--%>
                    <a href="${pageContext.request.contextPath}/member/<%=member.getUsername()%>/listcourse"
                       class="nav-item nav-link" style="font-size: 17px">หลักสูตรของฉัน</a>
                    <a href="${pageContext.request.contextPath}/view_activity" class="nav-item nav-link"
                       style="font-size: 17px">ข่าวสารและกิจกรรม</a>
                        <%--                    <a href="#" class="nav-item nav-link" style="font-size: 17px">เกี่ยวกับเรา</a>--%>
                    <a href="${pageContext.request.contextPath}/member/<%=member.getUsername()%>/edit_profile"
                       class="nav-item nav-link" style="font-size: 17px">ข้อมูลส่วนตัว</a>
                    <a href="${pageContext.request.contextPath}/doLogout" class="nav-item nav-link"
                       style="font-size: 17px">ออกจากระบบ</a>
                </div>
            </div>
        </nav>
        <!-- Navbar End -->
    </c:when>
</c:choose>

<c:set var="object" value="${req.course.object}"/>
<c:set var="parts" value="${fn:split(object, '$%')}"/>
<img src="${pageContext.request.contextPath}/assets/img/banner3.png" class="banner" alt="banner"/>
<p class="header_1">LIFELONG EDUCATION</p>
<p class="header_2">MAEJO UNIVERSITY</p>
<%--<button class="bt_register" href="${pageContext.request.contextPath}/register_member">สมัครเลย!</button>--%>

<div class="block_position">
    <p class="c_name">${course.name}</p>

    <!--Course_Type--->
    <c:if test="${course.course_type.equals('Non-Degree')}" >
        <div class="block_c_type" style="width: 10%">
            <p class="course_type">${course.course_type}</p>
        </div>
    </c:if>
    <c:if test="${course.course_type.equals('หลักสูตรอบรมระยะสั้น')}" >
        <div class="block_c_type" style="width: 13%">
            <p class="course_type">${course.course_type}</p>
        </div>
    </c:if>
    <br>

    <table>
        <tr>
            <td style="width: 53%; vertical-align: top;">
                <!--Detail-->
                <div style="width: 45%;">
                    <h1 style="font-size: 150%;">รายละเอียดหลักสูตร</h1>
                    <p class="c_principle">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ${course.principle}</p>
                    <hr style="width: 220%;">
                    <!---Sub_Detail-->
                    <table class="detail" style="color: black; width: 210%">
                        <c:if test="${req != null}">
                            <tr>
                                <td>ช่วงวันรับสมัคร</td>
                                <td>
                                    <fmt:formatDate value="${req.startRegister}" pattern="dd/MM/yyyy" var="startRegister"/>
                                    <fmt:formatDate value="${req.endRegister}" pattern="dd/MM/yyyy" var="endRegister"/>
                                        ${startRegister} - ${endRegister}
                                </td>
                            </tr>
                            <tr>
                                <td>ช่วงวันชำระค่าสมัคร</td>
                                <td>
                                    <fmt:formatDate value="${req.startPayment}" pattern="dd/MM/yyyy" var="startPayment"/>
                                    <fmt:formatDate value="${req.endPayment}" pattern="dd/MM/yyyy" var="endPayment"/>
                                        ${startPayment} - ${endPayment}
                                </td>
                            </tr>
                            <tr>
                                <td>วันประกาศผล</td>
                                <td>
                                    <fmt:formatDate value="${req.applicationResult}" pattern="dd/MM/yyyy" var="applicationResult"/>
                                        ${applicationResult}
                                </td>
                            </tr>
                            <tr>
                                <td>ระยะเวลาในการเรียน</td>
                                <td>
                                    <fmt:formatDate value="${req.startStudyDate}" pattern="dd/MM/yyyy" var="startStudyDate"/>
                                    <fmt:formatDate value="${req.endStudyDate}" pattern="dd/MM/yyyy" var="endStudyDate"/>
                                        ${startStudyDate} - ${endStudyDate}
                                </td>
                            </tr>
                            <tr>
                                <td>วันที่เรียน</td>
                                <td>
                                    <c:set var="delimiter" value="$%"/>
                                    <c:set var="subText" value="${fn:split(req.studyTime, delimiter)}"/>
                                    <c:forEach var="ogText" items="${subText}" >
                                        <c:set var="replaceSlash" value="${fn:replace(ogText, '/', ' เวลา ')}"/>
                                        <c:set var="newText" value="${fn:replace(replaceSlash, ',', ' ถึง ')}"/>
                                        ${newText} <br>
                                    </c:forEach>
                                </td>
                            </tr>
                            <tr>
                                <td>จำนวนรับสมัคร</td>
                                <td>
                                    <c:set var="stt_remaining" value="true"/>
                                    <c:set var="remaining" value="${req.quantity - amount}"/>
                                    <c:choose>
                                        <c:when test="${amount == req.quantity}">
                                            <p style="color: #ea0000; font-weight: bold; margin-top: 13px;">เต็มแล้ว</p>
                                            <c:set var="stt_remaining" value="false"/>
                                        </c:when>
                                        <c:otherwise>
                                            ${req.quantity} (คงเหลือ ${remaining} ที่นั่ง)
                                            <c:set var="stt_remaining" value="true"/>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:if>
                        <tr>
                            <td>ประเภทหลักสูตร</td>
                            <td>${course.course_type}</td>
                        </tr>
                        <tr>
                            <td>หมวดสาขาวิชา</td>
                            <td>${course.major.name}</td>
                        </tr>
                        <tr>
                            <td>ชื่อเกียรติบัตร</td>
                            <td>${course.certificateName}</td>
                        </tr>
                        <tr>
                            <c:set var="count" value="0"/>
                            <td>วัตถุประสงค์</td>
                            <td>
                                <c:forEach items="${parts}" var="part">
                                    <c:set var="count" value="${count+1}"/>
                                    ${count} ) <c:out value="${part}"/><br/>
                                </c:forEach>
                            </td>
                        </tr>
                        <tr>
                            <td>ระยะเวลาเรียน</td>
                            <td>${course.totalHours} ชั่วโมง</td>
                        </tr>
                        <tr>
                            <td>เป้าหมายกลุ่มอาชีพ</td>
                            <td>${course.targetOccupation}</td>
                        </tr>


                        <c:if test="${req != null}">
                            <tr>
                                <td>รูปแบบการเรียน</td>
                                <td>${req.type_learn}</td>
                            </tr>

                            <c:choose>
                                <c:when test="${req.type_learn.equals('เรียนออนไลน์')}">
                                    <tr>
                                        <td>Link Mooc</td>
                                        <td><a href="${req.linkMooc}">${req.linkMooc}</a></td>
                                    </tr>
                                </c:when>
                                <c:when test="${req.type_learn.equals('เรียนในสถานศึกษา')}">
                                    <tr>
                                        <td>สถานที่เรียน</td>
                                        <td>${req.location}</td>
                                    </tr>
                                </c:when>
                                <c:when test="${req.type_learn.equals('เรียนทั้งออนไลน์และในสถานศึกษา')}">
                                    <tr>
                                        <td>Link Mooc</td>
                                        <td><a href="${req.linkMooc}">${req.linkMooc}</a></td>
                                    </tr>
                                    <tr>
                                        <td>สถานที่เรียน</td>
                                        <td>${req.location}</td>
                                    </tr>
                                </c:when>
                            </c:choose>
                        </c:if>

                        <tr>
                            <td class="t1">เนื้อหาของหลักสูตร</td>
                            <td class="t2"><a href="${pageContext.request.contextPath}/uploads/course_pdf/${course.file}" download>เอกสารประกอบการเรียน.pdf</a>
                            </td>
                        </tr>
                        <tr>
                            <td>ค่าธรรมเนียม</td>
                            <td style="color: #12b100;">
                                <c:choose>
                                    <c:when test="${course.fee == 0}">
                                        ไม่มีค่าธรรมเนียม
                                    </c:when>
                                    <c:when test="${course.fee != 0}">
                                        ราคา <fmt:formatNumber value="${course.fee}"/> บาท
                                    </c:when>
                                </c:choose>
                            </td>
                        </tr>
                        <tr>
                            <td></td>
                            <td>
                                <%--    Now--%>
                                <c:set var="stt_btn" value="true"/>
                                <c:if test="${stt_remaining == true}">
                                    <c:if test="${registered == true}">
                                        <button class="btn btn-danger" disabled>ลงทะเบียนแล้ว</button>
                                    </c:if>
                                    <c:if test="${registered == false}">
                                        <c:set var="current" value="<%=LocalDate.now()%>"/>
                                        <c:set var="theStartRegister" value="${req.startRegister.toLocalDate()}"/>
                                        <c:set var="theLastRegister" value="${req.endRegister.toLocalDate()}"/>
                                        <c:choose>
                                            <c:when test="${current.isBefore(theStartRegister)}">
                                                <button class="btn btn-secondary" disabled
                                                        style="color: #ffffff;background-color: #434343;border: none;">
                                                    ยังไม่เปิดรับลงทะเบียน
                                                </button>
                                            </c:when>
                                            <c:when test="${current.isAfter(theLastRegister)}">
                                                <button class="btn btn-secondary" disabled style="color: #ffffff;">ปิดรับสมัครแล้ว
                                                </button>
                                            </c:when>
                                            <c:otherwise>
                                                <%--                                    <button class="btn btn-success" id="btnRegister" onclick="if((confirm('ยืนยันการลงทะเบียน'))){ window.location.href='${pageContext.request.contextPath}/member/<%=member.getUsername()%>/register_course/${course.course_id}/${req.request_id}/register';return false; }">สมัครเลย !</button>--%>
                                                <button class="btn btn-success" id="btnRegister">สมัครเลย !</button>
                                                <br><br>
                                                <label id="messageAlertLengthDate" style="color: #ff0000;"></label>
                                                <br>
                                                <label id="messageAskAgain" style="color: #03a200;"></label>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:if>
                                </c:if>

                                <c:if test="${stt_remaining == false && registered == true}">
                                    <button class="btn btn-danger" disabled>ลงทะเบียนแล้ว</button>
                                    <c:set var="stt_btn" value="false"/>
                                </c:if>

                                <c:if test="${stt_remaining == false && stt_btn == true}">
                                    <button class="btn btn-danger" disabled>เต็มแล้ว</button>
                                </c:if>
                            </td>
                        </tr>
                    </table>
                </div>
            </td>
            <td style="vertical-align: top;">
                <!--Image--->
                <img src="${pageContext.request.contextPath}/uploads/course_img/${course.img}" alt="course_image" class="img">
                <br><br><br>
                <div class="block_contactor">
                    <table class="contact">
                        <tr>
                            <td>
                                <%-- Declare a variable --%>
                                <c:set var="delimiter" value="$%" />

                                <%-- Use the variable in fn:split --%>
                                <c:set var="contact" value="${fn:split(course.contact, delimiter)}" />
                                <p style="font-weight: bold; font-size: 120%;">ติดต่อสอบถามเจ้าหน้าที่</p>
                                <p style="font-weight: bold;">${contact[0]} ${contact[1]} ${contact[2]}</p>
                                <p>${contact[3]}</p> <br>
                                <p style="font-weight: bold; font-size: 120%;">ช่องทางในการติดต่อสอบถาม</p>
                                <p>อีเมล ${contact[5]}</p>
                                <p>เบอร์โทรศัพท์ ${contact[4]}</p>
                                <a href="https://www.facebook.com/sciencemjupage">${contact[6]}</a>
                            </td>
                        </tr>
                    </table>
                </div>
            </td>
        </tr>
    </table>

    <br><br><br>
    <%--    Course News--%>

    <c:if test="${registerMember.study_result.equals('กำลังเรียน') || registerMember.study_result.equals('ผ่าน')}">
        <c:choose>
            <c:when test="${activity.size() == 0}">
                <h1 style="display: none">ข่าวสารประจำหลักสูตร</h1>
            </c:when>
            <c:otherwise>
                <h1 style="display: block">ข่าวสารประจำหลักสูตร</h1>
                <hr>
                <br>
            </c:otherwise>
        </c:choose>

        <c:forEach var="list" items="${activity}">
            <a href="${pageContext.request.contextPath}/member/private_activity/${list.ac_id}">
                <div class="block_news_big" style="float: left;">
                    <div class="block_news">
                        <c:set var="looped" value="false"/>
                        <c:set var="imgNames" value="${list.img}"/>
                        <c:forEach var="listImg" items="${fn:split(imgNames, ',')}">
                            <c:set var="listImg" value="${fn:replace(fn:replace(fn:replace(listImg, '\"', ''), '[', ''), ']', '')}"/>
                            <c:if test="${!looped}">
                                <td><img
                                        src="${pageContext.request.contextPath}/uploads/activity/private/${list.ac_id}/${listImg}"
                                        alt="News_img" class="news_img"></td>
                                <c:set var="looped" value="true"/>
                            </c:if>
                        </c:forEach>

                        <div class="news_content">
                            <p class="header_news">${list.name}</p>
                            <fmt:formatDate value="${list.date}" pattern="dd/MM/yyyy" var="activity_date"/>
                            <c:set var="format_date" value="${fn:substring(activity_date, 0, 10)}"/>
                            <p style="color: black;">${format_date}</p>
                            <div class="block_detail_news">
                                <p class="detail_news">${list.detail}</p>
                            </div>
                        </div>
                    </div>
                </div>
            </a>
        </c:forEach>
    </c:if>

</div>
<script>
    // เพิ่มการฟังก์ชันเมื่อปุ่มถูกคลิก
    let n = 1;
    document.getElementById('btnRegister').addEventListener('click', function () {

        /********************* Backup ****************************/
        var messageAlertLengthDate = document.getElementById('messageAlertLengthDate');
        var messageAskAgain = document.getElementById('messageAskAgain');
        let isAvailable = false;
        <c:forEach var="register" items="${list_register}" >
            var startStudy = '${req.startStudyDate}'
            var endStudy = '${req.endStudyDate}'
            if (new Date(startStudy) > new Date('${register.requestOpenCourse.startStudyDate}') && new Date(endStudy) < new Date('${register.requestOpenCourse.endStudyDate}')) {
                messageAlertLengthDate.innerHTML = "*หมายเหตุ* คุณมีเรียนหลักสูตร " + `${register.requestOpenCourse.course.name}` + " ซึ่งอยู่ช่วงเวลาเรียนเดียวกับหลักสูตรนี้";
                messageAskAgain.innerHTML = 'หากต้องการเรียน ให้กดลงทะเบียนใหม่อีกครั้ง';
                isAvailable = true;
                n++;
            }else if (new Date(startStudy) < new Date('${register.requestOpenCourse.startStudyDate}') && (new Date(endStudy) > new Date('${register.requestOpenCourse.startStudyDate}') && new Date(endStudy) < new Date('${register.requestOpenCourse.endStudyDate}'))) {
                messageAlertLengthDate.innerHTML = "*หมายเหตุ* คุณมีเรียนหลักสูตร " + `${register.requestOpenCourse.course.name}` + " ซึ่งอยู่ช่วงเวลาเรียนเดียวกับหลักสูตรนี้";
                messageAskAgain.innerHTML = 'หากต้องการเรียน ให้กดลงทะเบียนใหม่อีกครั้ง';
                isAvailable = true;
                n++;
            }else if ((new Date(startStudy) > new Date('${register.requestOpenCourse.startStudyDate}') && new Date(startStudy) < new Date('${register.requestOpenCourse.endStudyDate}')) && new Date(endStudy) > new Date('${register.requestOpenCourse.endStudyDate}')) {
                messageAlertLengthDate.innerHTML = "*หมายเหตุ* คุณมีเรียนหลักสูตร " + `${register.requestOpenCourse.course.name}` + " ซึ่งอยู่ช่วงเวลาเรียนเดียวกับหลักสูตรนี้";
                messageAskAgain.innerHTML = 'หากต้องการเรียน ให้กดลงทะเบียนใหม่อีกครั้ง';
                isAvailable = true;
                n++;
            }else if (startStudy === '${register.requestOpenCourse.startStudyDate}' && endStudy === '${register.requestOpenCourse.endStudyDate}'){
                messageAlertLengthDate.innerHTML = "*หมายเหตุ* คุณมีเรียนหลักสูตร " + `${register.requestOpenCourse.course.name}` + " ซึ่งอยู่ช่วงเวลาเรียนเดียวกับหลักสูตรนี้";
                messageAskAgain.innerHTML = 'หากต้องการเรียน ให้กดลงทะเบียนใหม่อีกครั้ง';
                isAvailable = true;
                n++;
            }else if (startStudy === '${register.requestOpenCourse.endStudyDate}' || endStudy === '${register.requestOpenCourse.startStudyDate}'){
                messageAlertLengthDate.innerHTML = "*หมายเหตุ* คุณมีเรียนหลักสูตร " + `${register.requestOpenCourse.course.name}` + " ซึ่งอยู่ช่วงเวลาเรียนเดียวกับหลักสูตรนี้";
                messageAskAgain.innerHTML = 'หากต้องการเรียน ให้กดลงทะเบียนใหม่อีกครั้ง';
                isAvailable = true;
                n++;
            }
        </c:forEach>
        if (n >= 3) {
            if (confirm('ยืนยันการลงทะเบียน')) {
                window.location.href = '${pageContext.request.contextPath}/member/' + `${memId}` + '/register_course/' + `${course.course_id}` + '/' + `${req.request_id}` + '/register';
                return false;
            }
        }
        if (isAvailable === false){
            if ((confirm('ยืนยันการลงทะเบียน'))) {
                window.location.href = '${pageContext.request.contextPath}/member/' + `${memId}` + '/register_course/' + `${course.course_id}` + '/' + `${req.request_id}` + '/register';
                return false;
            }
        }
    });
</script>
</body>
</html>
