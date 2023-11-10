<%@ page import="java.text.DecimalFormat" %>
<%@ page import="lifelong.model.Admin" %>
<%@ page import="lifelong.model.Member" %>
<%@ page import="lifelong.model.Lecturer" %>
<%@ page import="lifelong.controller.MemberController" %>
<%@ page import="lifelong.dao.RegisterDaoImpl" %>
<%@ page import="java.util.List" %>
<%@ page import="lifelong.model.Register" %>
<%@ page import="org.springframework.beans.factory.annotation.Autowired" %>
<%@ page import="lifelong.service.RequestOpCourseService" %>
<%@ page import="java.time.LocalDate" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html lang="en">

<head>
    <meta charset="utf-8">
    <title>Science MJU LifeLong Learning</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="Free HTML Templates" name="keywords">
    <meta content="Free HTML Templates" name="description">
    <%--  <link href="${pageContext.request.contextPath}/assets/css/home_style.css" rel="stylesheet"/>--%>
    <link href="https://fonts.googleapis.com/css2?family=Mitr:wght@500&display=swap" rel="stylesheet">
    <jsp:include page="/WEB-INF/view/layouts/detail-all-style.jsp"/>

    <style>
        .btn_register_course_detail {
            border-radius: 15px;
            background-color: #ff4900;
            color: white;
            font-weight: 600;
            width: 100%;
            height: 41px;
            border: 0;
        }

        .search_bar {
            width: 97%;
            height: 50px;
            border-radius: 7px;
            color: black;
            margin-left: 21px;
            font-size: 19px;
            border: 1px solid black;
            text-align: center;
        }

        .block {
            display: inline-block;
            float: left;
        }

        div [class="block col-lg-4 col-md-6 wow zoomIn"]:hover {
            margin-top: 15px;
            transition: 0.5s;
        }

        .font-ab {
            font-size: 40px;
            color: black;
            font-weight: bold;
            font-family: Kanit SemiBold;
        }

        .btn-register-ab {
            width: 175px;
            height: 47px;
            margin-top: -7px;
            border-radius: 16px;
            border: 0;
            font-weight: bold;
            background-color: #005f00;
            color: white;
            transition: 0.5s;
        }

        .btn-register-ab:hover {
            background-color: #0ca90c;
            transition: 0.5s;
        }

        #courseSelect option {
            white-space: pre-wrap;
        }

        .text_ellipsis {
            display: -webkit-box;
            max-width: 500px;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .course_name {
            color: #e24c07;
            font-size: 94%;
            font-weight: bold;
            height: 45px;
        }

        /****User****/
        table[class='icon'] tr td:first-child {
            width: 44px;
            vertical-align: top;
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
    <c:when test="${flag.equals('admin')}">
        <jsp:include page="/WEB-INF/view/admin/nav_admin.jsp"/>
    </c:when>
    <c:when test="${flag.equals('lecturer')}">
        <jsp:include page="/WEB-INF/view/lecturer/nav_lecturer.jsp"/>
    </c:when>
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
    <c:otherwise>
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
            <div class="collapse navbar-collapse" style="margin-right: 43px;">
                <div class="navbar-nav ms-auto py-0">
                    <a href="${pageContext.request.contextPath}/" class="nav-item nav-link" style="font-size: 17px">หน้าหลัก</a>
                        <%--                    <a href="#" class="nav-item nav-link" style="font-size: 17px">เกี่ยวกับคณะ</a>--%>
                    <a href="${pageContext.request.contextPath}/search_course" class="nav-item nav-link active"
                       style="font-size: 17px">หลักสูตรการอบรม</a>
                    <a href="${pageContext.request.contextPath}/view_activity" class="nav-item nav-link"
                       style="font-size: 17px">ข่าวสารและกิจกรรม</a>
                        <%--                    <a href="#" class="nav-item nav-link" style="font-size: 17px">เกี่ยวกับเรา</a>--%>
                    <div class="nav-item dropdown">
                        <a href="#" class="nav-link dropdown-toggle nav-item" data-bs-toggle="dropdown"
                           style="font-size: 17px">เข้าสู่ระบบ</a>
                        <div class="dropdown-menu m-0">
                            <a href="${pageContext.request.contextPath}/loginMember" class="dropdown-item"
                               style="font-size: 17px">สำหรับสมาชิก</a>
                            <a href="${pageContext.request.contextPath}/loginLecturer" class="dropdown-item"
                               style="font-size: 17px">สำหรับบุคลากร</a>
                            <a href="${pageContext.request.contextPath}/loginAdmin" class="dropdown-item"
                               style="font-size: 17px">สำหรับผู้ดูแลระบบ</a>
                        </div>
                    </div>
                </div>
            </div>
        </nav>
        <!-- Navbar End -->
    </c:otherwise>
</c:choose>
<!-- Navbar End -->
<!-- Services Start -->
<div class="container-fluid py-5 wow fadeInUp" data-wow-delay="0.1s">
    <div class="container">
        <div class="text-center mx-auto mb-5" style="max-width: 600px;">
            <h5 class="text-primary text-uppercase" style="letter-spacing: 5px;">หลักสูตร</h5>
            <h1 class="display-5 mb-0">แนะนำสำหรับคุณ</h1>
        </div>

        <div class="row g-5">
            <!----------Search------------>
            <input type="text" class="form-control me-2 search_bar" id="searchInput" onkeyup="search()"
                   placeholder="ค้นหาหลักสูตรที่คุณสนใจ...">
            <%--            <select class="form-select" name="majorId" id="majorSelect" style="width: 40%"--%>
            <%--                    onchange="document.location.href = '${pageContext.request.contextPath}/search_course/' + this.value">--%>
            <%--                &lt;%&ndash;                    <select name="majorId" id="majorSelect" style="width: 40%">&ndash;%&gt;--%>
            <%--                &lt;%&ndash;                    <select class="form-select" name="majorId" id="majorSelect" style="width: 40%" onchange="document.location.href = 'https://itsci.mju.ac.th/sci_mju_lifelonglearning/search_course/' + this.value">&ndash;%&gt;--%>
            <%--                <option value="หลักสูตรทั้งหมด">--กรุณาเลือกรายการ--</option>--%>

            <%--                <c:forEach items="${majors}" var="major">--%>
            <%--                    <option value="${major.name}">${major.name}</option>--%>
            <%--                </c:forEach>--%>
            <%--            </select>--%>
            <%--            <%! String majorName = "";%>--%>

            <%--            <h3 id="showlist">${majorName}</h3>--%>

            <!----------End Search------------>

            <!----------Show List Course------------>

            <c:forEach var="course" items="${courses}">
                <c:if test="${course.status ne 'ถูกยกเลิก'}">
                    <%
                        DecimalFormat f = new DecimalFormat("#,###");
                    %>
                    <fmt:parseNumber var="courseFee" type="number" value="${course.fee}"/>

                    <div class="block col-lg-3 col-md-6 wow zoomIn" style="transition: 0.5s" data-name=${course.name}>
                        <div class="col-lg-3 col-md-6 wow zoomIn" style="cursor: pointer" data-wow-delay="0.3s">
                            <div class="bg-light border-bottom border-5 border-primary rounded"
                                 style="width: 300px; height: 605px; box-shadow: 2px -2px 6px 1px #9c9c9c;">

                                <c:choose>
                                    <c:when test="${flag.equals('member')}">
                                        <div class="p-4">
                                            <img src="${pageContext.request.contextPath}/uploads/course_img/${course.img}"
                                                 style="height: 300px; width: 300px; margin-top: -24px;margin-left: -24px;">
                                            <br><br>
                                            <b><p class="item text_ellipsis course_name">${course.name}</p></b>
                                            <p style="font-size: 85%; font-weight: bold; color: dodgerblue">${course.course_type}</p>
                                            <table class="icon">
                                                <c:set var="notFoundTypeLearn" value="false"/>
                                                <c:forEach var="list" items="${list_req}">
                                                    <c:if test="${list.course.course_id eq course.course_id && list.requestStatus.equals('ผ่าน')}">
                                                        <tr style="height: 40px">
                                                            <fmt:formatDate value="${list.startRegister}"
                                                                            pattern="dd/MM/yyyy" var="startRegister"/>
                                                            <fmt:formatDate value="${list.endRegister}"
                                                                            pattern="dd/MM/yyyy" var="endRegister"/>

                                                            <td colspan="2"
                                                                style="width: 310px; color: black; font-weight: bold; font-size: 85%">
                                                                เริ่มลงทะเบียน ${startRegister} - ${endRegister}</td>
                                                        </tr>
                                                        <c:if test="${list.type_learn.equals('เรียนในสถานศึกษา')}">
                                                            <tr>
                                                                <td><img
                                                                        src="${pageContext.request.contextPath}/assets/img/onsite.png"
                                                                        style="height: 20px;"></td>
                                                                <td>
                                                                    <p style="color: #000000; font-weight: bold; font-size: 85%">${list.type_learn}</p>
                                                                </td>
                                                            </tr>
                                                            <c:set var="notFoundTypeLearn" value="true"/>
                                                        </c:if>
                                                        <c:if test="${list.type_learn.equals('เรียนออนไลน์')}">
                                                            <tr>
                                                                <td><img
                                                                        src="${pageContext.request.contextPath}/assets/img/online.png"
                                                                        style="height: 20px;"></td>
                                                                <td>
                                                                    <p style="color: #000000; font-weight: bold; font-size: 85%">${list.type_learn}</p>
                                                                </td>
                                                            </tr>
                                                            <c:set var="notFoundTypeLearn" value="true"/>
                                                        </c:if>
                                                        <c:if test="${list.type_learn.equals('เรียนทั้งออนไลน์และในสถานศึกษา')}">
                                                            <tr>
                                                                <td><img
                                                                        src="${pageContext.request.contextPath}/assets/img/onsite.png"
                                                                        style="height: 20px;"></td>
                                                                <td>
                                                                    <p style="color: #000000; font-weight: bold; font-size: 85%">${list.type_learn}</p>
                                                                </td>
                                                            </tr>
                                                            <c:set var="notFoundTypeLearn" value="true"/>
                                                        </c:if>
                                                    </c:if>
                                                </c:forEach>
                                                <c:if test="${!notFoundTypeLearn}">
                                                    <tr style="height: 40px">
                                                        <td colspan="2"
                                                            style="width: 310px; color: black; font-weight: bold; font-size: 85%">
                                                            เริ่มลงทะเบียน -
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td><img
                                                                src="${pageContext.request.contextPath}/assets/img/onsite.png"
                                                                style="height: 20px;"></td>
                                                        <td>
                                                            <p style="color: #000000; font-weight: bold; font-size: 85%">
                                                                ยังไม่เปิด</p></td>
                                                    </tr>
                                                </c:if>
                                                <tr>
                                                    <td><img
                                                            src="${pageContext.request.contextPath}/assets/img/money.png"
                                                            style="height: 20px;"></td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${courseFee == 0}">
                                                                <b><p style="color: #12b100; font-size: 95%">ฟรี</p></b>
                                                            </c:when>
                                                            <c:when test="${courseFee != 0}">
                                                                <b><p style="color: #12b100; font-size: 95%">ราคา
                                                                    <fmt:formatNumber value="${courseFee}"/> บาท</p></b>
                                                            </c:when>
                                                        </c:choose>
                                                    </td>
                                                </tr>
                                            </table>
                                            <hr style="background-color: black; margin-top: 0">

                                            <c:set var="username" value="<%= member.getUsername() %>"/>
                                            <table>
                                                <tr>
                                                    <td>
                                                            <c:set var="notFoundCourse" value="true"/>
                                                        <c:forEach var="listReq" items="${listRequest}">
                                                        <c:choose>
                                                        <c:when test="${listReq.course.course_id eq course.course_id && listReq.requestStatus.equals('ผ่าน')}">
                                                            <c:set var="status" value="true"/>
                                                        <c:forEach var="invoices" items="${list_invoice}">
                                                        <c:choose>
                                                        <c:when test="${invoices.register.member.username.equals(username) && invoices.register.requestOpenCourse.request_id == listReq.request_id}">
                                                    <td style="width: 590px; vertical-align: baseline;">
                                                        <a href="${pageContext.request.contextPath}/member/${username}/register_course/${course.course_id}/${listReq.request_id}"
                                                           style="font-family: 'Mitr', sans-serif; font-size: 18px; font-weight: 100;">อ่านเพิ่มเติม<i
                                                                class="bi bi-arrow-right ms-2"></i></a>
                                                    </td>
                                                    <c:if test="${invoices.pay_status == true && invoices.approve_status.equals('ผ่าน')}">
                                                        <td style="width: 305px;">
                                                            <p style="color: green; font-family: 'Mitr', sans-serif; font-size: 100%; font-weight: 100;">
                                                                ลงทะเบียนแล้ว</p>
                                                        </td>
                                                        <c:set var="status" value="false"/>
                                                    </c:if>

                                                    <c:if test="${invoices.pay_status == true && invoices.approve_status.equals('ไม่ผ่าน')}">
                                                        <td style="width: 360px;">
                                                            <p style="color: red; font-family: 'Mitr', sans-serif; font-size: 92%; font-weight: 100; margin-top: 2px;">
                                                                ชำระเงินไม่สำเร็จ</p>
                                                        </td>
                                                        <c:set var="status" value="false"/>
                                                    </c:if>

                                                    <c:if test="${invoices.pay_status == false && invoices.approve_status.equals('รอดำเนินการ')}">
                                                        <td style="width: 200px;">
                                                            <p style="color: #e8b904; font-family: 'Mitr', sans-serif; font-size: 100%; font-weight: 100;">
                                                                รอชำระเงิน</p>
                                                        </td>
                                                        <c:set var="status" value="false"/>
                                                    </c:if>

                                                    <c:if test="${invoices.pay_status == false && invoices.approve_status.equals('เลยกำหนดชำระเงิน')}">
                                                        <td style="width: 500px;">
                                                            <p style="color: #ff1c1c; font-family: 'Mitr', sans-serif; font-size: 94%; font-weight: 100;">
                                                                เลยกำหนดชำระเงิน</p>
                                                        </td>
                                                        <c:set var="status" value="false"/>
                                                    </c:if>

                                                    <c:if test="${invoices.pay_status == true && invoices.approve_status.equals('รอดำเนินการ')}">
                                                        <td style="width: 305px;">
                                                            <p style="color: #e8b904; font-family: 'Mitr', sans-serif; font-size: 100%; font-weight: 100;">
                                                                รอดำเนินการ</p>
                                                        </td>
                                                        <c:set var="status" value="false"/>
                                                    </c:if>
                                                    <c:set var="notFoundCourse" value="false"/>
                                                    </c:when>
                                                    </c:choose>
                                                    </c:forEach>

                                                    <c:if test="${empty list_invoice || status == true}">
                                                        <td style="width: 180px; vertical-align: baseline;">
                                                            <a href="${pageContext.request.contextPath}/member/${username}/register_course/${course.course_id}/${listReq.request_id}"
                                                               style="font-family: 'Mitr', sans-serif; font-size: 110%; font-weight: 500;">ลงทะเบียน<i
                                                                    class="bi bi-arrow-right ms-2"></i></a>
                                                        </td>
                                                        <td style="width: 150px">
                                                            <c:set var="sttOpen" value="false"/>

                                                            <c:forEach var="listReq" items="${listRequest}">
                                                                <c:set var="current" value="<%=LocalDate.now()%>"/>
                                                                <c:set var="SttStartRegister" value="${listReq.startRegister.toLocalDate()}"/>
                                                                <c:set var="SttEndRegister" value="${listReq.endRegister.toLocalDate()}"/>

                                                                <c:choose>
                                                                    <c:when test="${listReq.course.course_id eq course.course_id && listReq.requestStatus.equals('ผ่าน')}">
                                                                        <c:if test="${current.isBefore(SttStartRegister)}">
                                                                            <p style="color: #ff8000; font-weight: 500; font-family: 'Mitr', sans-serif; font-size: 110%;text-align: right;">เร็วนี้ๆ</p>
                                                                        </c:if>

                                                                        <c:if test="${(current.equals(SttStartRegister) || current.isAfter(SttStartRegister)) && (current.equals(SttEndRegister) || current.isBefore(SttEndRegister))}">
                                                                            <c:set var="paid" value="${0}"/>
                                                                            <c:forEach var="listPaid" items="${amount}">
                                                                                <c:if test="${listPaid.requestOpenCourse.request_id == listReq.request_id}">
                                                                                    <c:set var="paid" value="${paid + 1}"/>
                                                                                    <c:set var="remaining" value="${listReq.quantity - paid}"/>

                                                                                    <c:choose>
                                                                                        <c:when test="${remaining == 0}">
                                                                                            <p style="color: #ff0000; font-weight: 500; font-family: 'Mitr', sans-serif; font-size: 110%;text-align: right;">เต็มแล้ว</p>
                                                                                            <c:set var="sttOpen" value="true"/>
                                                                                        </c:when>
                                                                                    </c:choose>
                                                                                </c:if>
                                                                            </c:forEach>
                                                                        </c:if>

                                                                        <c:choose>
                                                                            <c:when test="${current.isAfter(SttEndRegister)}">
                                                                                <p style="color: #6c6b6b; font-weight: 500; font-family: 'Mitr', sans-serif; font-size: 110%;text-align: right;">ปิดรับสมัคร</p>
                                                                            </c:when>
                                                                            <c:otherwise>
                                                                                <c:if test="${!sttOpen}">
                                                                                    <p style="color: #008000; font-weight: 500; font-family: 'Mitr', sans-serif; font-size: 110%;text-align: right;">เปิด</p>
                                                                                </c:if>
                                                                            </c:otherwise>
                                                                        </c:choose>
                                                                    </c:when>
                                                                </c:choose>
                                                            </c:forEach>
                                                        </td>
                                                        <c:set var="notFoundCourse" value="false"/>
                                                    </c:if>
                                                    </c:when>
                                                    </c:choose>
                                                    </c:forEach>

                                                    <c:if test="${notFoundCourse}">
                                                        <!-- เมื่อไม่พบ course_id ใน listRequest -->
                                                        <td style="width: 250px; vertical-align: top;">
                                                            <a href="${pageContext.request.contextPath}/${course.course_id}"
                                                               style="font-family: 'Mitr', sans-serif; font-size: 100%; font-weight: 500;">อ่านเพิ่มเติม<i
                                                                    class="bi bi-arrow-right ms-2"></i></a>
                                                        </td>
                                                        <td></td>
                                                    </c:if>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </c:when>

                                    <%-------- User ---------%>
                                    <c:otherwise>
                                        <a href="${pageContext.request.contextPath}/${course.course_id}">
                                            <div class="p-4">
                                                <img src="${pageContext.request.contextPath}/uploads/course_img/${course.img}"
                                                     style="height: 300px;width:300px;margin-top: -24px;margin-left: -24px;">
                                                <div>
                                                    <br>
                                                    <b><p class="item text_ellipsis course_name">${course.name}</p></b>
                                                </div>
                                                <p style="font-size: 85%;font-weight: bold; color: dodgerblue">${course.course_type}</p>
                                                <table class="icon">
                                                    <c:set var="notFoundCourse" value="false"/>
                                                    <c:set var="notFoundTypeLearn" value="false"/>
                                                    <c:forEach var="list" items="${list_req}">
                                                        <c:if test="${list.course.course_id eq course.course_id && list.requestStatus.equals('ผ่าน')}">
                                                            <tr style="height: 40px">
                                                                <fmt:formatDate value="${list.startRegister}" pattern="dd/MM/yyyy" var="startRegister"/>
                                                                <fmt:formatDate value="${list.endRegister}" pattern="dd/MM/yyyy" var="endRegister"/>

                                                                <td colspan="2" style="width: 310px; color: black; font-weight: bold; font-size: 85%">เริ่มลงทะเบียน ${startRegister}- ${endRegister}</td>
                                                            </tr>
                                                            <c:if test="${list.type_learn.equals('เรียนในสถานศึกษา')}">
                                                                <tr>
                                                                    <td><img
                                                                            src="${pageContext.request.contextPath}/assets/img/onsite.png"
                                                                            style="height: 20px;"></td>
                                                                    <td>
                                                                        <p style="color: #000000; font-weight: bold;font-size: 85%">${list.type_learn}</p>
                                                                    </td>
                                                                </tr>
                                                                <c:set var="notFoundCourse" value="true"/>
                                                                <c:set var="notFoundTypeLearn" value="true"/>
                                                            </c:if>
                                                            <c:if test="${list.type_learn.equals('เรียนออนไลน์')}">
                                                                <tr>
                                                                    <td><img
                                                                            src="${pageContext.request.contextPath}/assets/img/online.png"
                                                                            style="height: 20px;"></td>
                                                                    <td>
                                                                        <p style="color: #000000; font-weight: bold;font-size: 85%">${list.type_learn}</p>
                                                                    </td>
                                                                </tr>
                                                                <c:set var="notFoundCourse" value="true"/>
                                                                <c:set var="notFoundTypeLearn" value="true"/>
                                                            </c:if>
                                                            <c:if test="${list.type_learn.equals('เรียนทั้งออนไลน์และในสถานศึกษา')}">
                                                                <tr>
                                                                    <td><img
                                                                            src="${pageContext.request.contextPath}/assets/img/onsite.png"
                                                                            style="height: 20px;"></td>
                                                                    <td>
                                                                        <p style="color: #000000; font-weight: bold;font-size: 85%">${list.type_learn}</p>
                                                                    </td>
                                                                </tr>
                                                                <c:set var="notFoundCourse" value="true"/>
                                                                <c:set var="notFoundTypeLearn" value="true"/>
                                                            </c:if>

                                                            <c:if test="${list.requestStatus.equals('กำลังดำเนินการ')}">
                                                                <c:set var="notFoundCourse" value="false"/>
                                                            </c:if>
                                                        </c:if>
                                                    </c:forEach>
                                                    <c:if test="${!notFoundTypeLearn}">
                                                        <tr style="height: 40px">
                                                            <td colspan="2"
                                                                style="width: 310px; color: black; font-weight: bold; font-size: 85%">
                                                                เริ่มลงทะเบียน -
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td><img
                                                                    src="${pageContext.request.contextPath}/assets/img/onsite.png"
                                                                    style="height: 20px;"></td>
                                                            <td>
                                                                <p style="color: #000000; font-weight: bold;font-size: 85%">
                                                                    ยังไม่เปิด</p></td>
                                                        </tr>
                                                    </c:if>

                                                    <tr>
                                                        <td><img
                                                                src="${pageContext.request.contextPath}/assets/img/money.png"
                                                                style="height: 20px;"></td>
                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${courseFee == 0}">
                                                                    <b><p style="color: #12b100;font-size: 95%">ฟรี</p>
                                                                    </b>
                                                                </c:when>
                                                                <c:when test="${courseFee != 0}">
                                                                    <b><p style="color: #12b100;font-size: 95%">ราคา
                                                                        <fmt:formatNumber value="${courseFee}"/> บาท</p>
                                                                    </b>
                                                                </c:when>
                                                            </c:choose>
                                                        </td>
                                                    </tr>
                                                </table>

                                                <hr style="background-color: black;margin-top: 0;">

                                                <table>
                                                    <tr>
                                                        <td style="width: 250px; vertical-align: top;">
                                                            <a href="${pageContext.request.contextPath}/${course.course_id}"
                                                               style="font-family: 'Mitr', sans-serif; font-size: 100%; font-weight: 500;">อ่านเพิ่มเติม<i
                                                                    class="bi bi-arrow-right ms-2"></i></a>
                                                        </td>
                                                        <td style="width: 130px;">
                                                            <c:set var="sttOpen" value="false"/>

                                                            <c:forEach var="listReq" items="${listRequest}">
                                                                <c:set var="current" value="<%=LocalDate.now()%>"/>
                                                                <c:set var="SttStartRegister" value="${listReq.startRegister.toLocalDate()}"/>
                                                                <c:set var="SttEndRegister" value="${listReq.endRegister.toLocalDate()}"/>

                                                                    <c:choose>
                                                                        <c:when test="${listReq.course.course_id eq course.course_id && listReq.requestStatus.equals('ผ่าน')}">
                                                                            <c:if test="${current.isBefore(SttStartRegister)}">
                                                                                <p style="color: #ff8000; font-weight: 500; font-family: 'Mitr', sans-serif; font-size: 110%;text-align: right;">เร็วนี้ๆ</p>
                                                                            </c:if>

                                                                            <c:if test="${(current.equals(SttStartRegister) || current.isAfter(SttStartRegister)) && (current.equals(SttEndRegister) || current.isBefore(SttEndRegister))}">
                                                                                <c:set var="paid" value="${0}"/>
                                                                                <c:forEach var="listPaid" items="${amount}">
                                                                                    <c:if test="${listPaid.requestOpenCourse.request_id == listReq.request_id}">
                                                                                        <c:set var="paid" value="${paid + 1}"/>
                                                                                        <c:set var="remaining" value="${listReq.quantity - paid}"/>
                                                                                        <c:choose>
                                                                                            <c:when test="${remaining == 0}">
                                                                                                <p style="color: #ff0000; font-weight: 500; font-family: 'Mitr', sans-serif; font-size: 110%;text-align: right;">เต็มแล้ว</p>
                                                                                                <c:set var="sttOpen" value="true"/>
                                                                                            </c:when>
                                                                                        </c:choose>
                                                                                    </c:if>
                                                                                </c:forEach>
                                                                            </c:if>

                                                                            <c:choose>
                                                                                <c:when test="${current.isAfter(SttEndRegister)}">
                                                                                    <p style="color: #6c6b6b; font-weight: 500; font-family: 'Mitr', sans-serif; font-size: 110%;text-align: right;">ปิดรับสมัคร</p>
                                                                                </c:when>
                                                                                <c:otherwise>
                                                                                    <c:if test="${!sttOpen}">
                                                                                        <p style="color: #008000; font-weight: 500; font-family: 'Mitr', sans-serif; font-size: 110%;text-align: right;">เปิด</p>
                                                                                    </c:if>
                                                                                </c:otherwise>
                                                                            </c:choose>
                                                                        </c:when>
                                                                    </c:choose>
                                                            </c:forEach>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </a>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                </c:if>
            </c:forEach>
        </div>
    </div>
</div>
<!-- Blog End -->
<jsp:include page="/WEB-INF/view/layouts/footer.jsp"/>
</body>
<script>
    $(document).ready(function () {
        $("#majorSelect").change(function () {
            $("#majorSelect").val();
            var list = $("#majorSelect").val();
            $("#showlist").html(list);
        });
    });

    function search() {
        var input = document.getElementById("searchInput").value.toLowerCase();
        var blocks = document.getElementsByClassName("block");

        for (var i = 0; i < blocks.length; i++) {
            var block = blocks[i];
            var text = block.getAttribute("data-name").toLowerCase();

            if (text.includes(input)) {
                block.style.display = "block";
            } else {
                block.style.display = "none";
            }
        }
    }
</script>


</html>