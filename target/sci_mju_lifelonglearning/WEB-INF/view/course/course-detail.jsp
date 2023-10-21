<%@ page import="lifelong.model.Admin" %>
<%@ page import="lifelong.model.Member" %>
<%@ page import="lifelong.model.Lecturer" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.time.LocalDate" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--<link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css" />--%>
<%--<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>--%>
<html>
<head>
    <title>${course_detail.name}</title>
    <jsp:include page="/WEB-INF/view/layouts/detail-all-style.jsp"/>
    <%--    <link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet">--%>
    <%--    <link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet">--%>
    <link href="${pageContext.request.contextPath}/assets/css/course_detail.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Mitr:wght@200&family=Prompt:wght@200&display=swap"
          rel="stylesheet">

    <%--    Google Font--%>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <%--    <link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css" />--%>

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

        .bt_register {
            position: absolute;
            top: 44%;
            left: 10%;
            width: 177px;
            height: 49px;
            border: 2px solid white;
            border-radius: 4px;
            color: black;
            font-weight: 700;
            transition: 0.5s;
        }

        .bt_register:hover {
            color: white;
            background-color: rgba(255, 255, 255, 0);
            transition: 0.5s;
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

        .block_c_type {
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
            height: 414px;
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

        .block_contactor {
            background-color: #ffffff;
            padding: 20px 0px 30px 0px;
            width: 65%;
            margin-left: 5%;
            border-radius: 8px;
            box-shadow: 0px 0px 10px 2px #dedddd;
        }

        .contact {
            color: black;
            margin-left: 33px;
            margin-top: 25px;
        }


    </style>
</head>
<body>
<!-- Navbar -->
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
        <jsp:include page="/WEB-INF/view/member/nav_member.jsp"/>
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
            <div class="collapse navbar-collapse" id="navbarCollapse" style="margin-right: 43px;">
                <div class="navbar-nav ms-auto py-0">
                    <a href="${pageContext.request.contextPath}/" class="nav-item nav-link " style="font-size: 16px">หน้าหลัก</a>
                    <a href="#" class="nav-item nav-link" style="font-size: 16px">เกี่ยวกับคณะ</a>
                    <a href="${pageContext.request.contextPath}/search_course" class="nav-item nav-link active"
                       style="font-size: 16px">หลักสูตรการอบรม</a>
                    <a href="${pageContext.request.contextPath}/view_activity" class="nav-item nav-link"
                       style="font-size: 16px">ข่าวสารและกิจกรรม</a>
                    <a href="#" class="nav-item nav-link" style="font-size: 16px">เกี่ยวกับเรา</a>
                    <div class="nav-item dropdown">
                        <a href="#" class="nav-link dropdown-toggle nav-item" data-bs-toggle="dropdown"
                           style="font-size: 16px">เข้าสู่ระบบ</a>
                        <div class="dropdown-menu m-0">
                            <a href="${pageContext.request.contextPath}/loginMember" class="dropdown-item"
                               style="font-size: 16px">สำหรับสมาชิก</a>
                            <a href="${pageContext.request.contextPath}/loginLecturer" class="dropdown-item"
                               style="font-size: 16px">สำหรับบุคลากร</a>
                            <a href="${pageContext.request.contextPath}/loginAdmin" class="dropdown-item"
                               style="font-size: 16px">สำหรับผู้ดูแลระบบ</a>
                        </div>
                    </div>
                </div>
            </div>
        </nav>
        <!-- Navbar End -->
    </c:otherwise>
</c:choose>

<c:set var="object" value="${course_detail.object}"/>
<c:set var="parts" value="${fn:split(object, '$%')}"/>
<img src="${pageContext.request.contextPath}/assets/img/banner3.png" class="banner" alt="banner"/>
<p class="header_1">LIFELONG EDUCATION</p>
<p class="header_2">MAEJO UNIVERSITY</p>
<c:choose>
    <c:when test="${flag ne 'member'}">
        <a href="${pageContext.request.contextPath}/register_member">
            <button class="bt_register">สมัครเลย!</button>
        </a>
    </c:when>
</c:choose>

<div class="block_position">
    <p class="c_name">${course_detail.name}</p>

    <!--Course_Type--->
    <c:if test="${course_detail.course_type.equals('Non-Degree')}">
        <div class="block_c_type" style="width: 10%">
            <p class="course_type">${course_detail.course_type}</p>
        </div>
    </c:if>
    <c:if test="${course_detail.course_type.equals('หลักสูตรอบรมระยะสั้น')}">
        <div class="block_c_type" style="width: 13%">
            <p class="course_type">${course_detail.course_type}</p>
        </div>
    </c:if>

    <br>
    <table>
        <tr>
            <td style="width: 53%; vertical-align: top;">
                <!--Detail-->
                <div style="width: 45%">
                    <h1 style="font-size: 150%;">รายละเอียดหลักสูตร</h1>
                    <p class="c_principle">
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ${course_detail.principle}</p>
                    <hr style="width: 220%;">
                    <!---Sub_Detail-->
                    <table class="detail" style="color: black; width: 210%">
                        <c:if test="${req != null}">
                            <tr>
                                <td>ช่วงวันรับสมัคร</td>
                                <td>
                                    <fmt:formatDate value="${req.startRegister}" pattern="dd/MM/yyyy"
                                                    var="startRegister"/>
                                    <fmt:formatDate value="${req.endRegister}" pattern="dd/MM/yyyy" var="endRegister"/>
                                        ${startRegister} - ${endRegister}
                                </td>
                            </tr>
                            <tr>
                                <td>ช่วงวันชำระค่าสมัคร</td>
                                <td>
                                    <fmt:formatDate value="${req.startPayment}" pattern="dd/MM/yyyy"
                                                    var="startPayment"/>
                                    <fmt:formatDate value="${req.endPayment}" pattern="dd/MM/yyyy" var="endPayment"/>

                                        ${startPayment} - ${endPayment}
                                </td>
                            </tr>
                            <tr>
                                <td>วันประกาศผล</td>
                                <td>
                                    <fmt:formatDate value="${req.applicationResult}" pattern="dd/MM/yyyy"
                                                    var="applicationResult"/>
                                        ${applicationResult}
                                </td>
                            </tr>
                            <tr>
                                <td>ระยะเวลาในการเรียน</td>
                                <td>
                                    <fmt:formatDate value="${req.startStudyDate}" pattern="dd/MM/yyyy"
                                                    var="startStudyDate"/>
                                    <fmt:formatDate value="${req.endStudyDate}" pattern="dd/MM/yyyy"
                                                    var="endStudyDate"/>
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

<%--                                    <c:set var="newText" value="${fn:replace(subText, '/', ' ')}"/>--%>
<%--                                    <c:forEach var="text" items="${newText}">--%>
<%--                                        ${text}--%>
<%--                                    </c:forEach>--%>
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
                            <td>หมวดสาขาวิชา</td>
                            <td>${course_detail.major.name}</td>
                        </tr>
                        <tr>
                            <td>ชื่อเกียรติบัตร</td>
                            <td>${course_detail.certificateName}</td>
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
                            <td>${course_detail.totalHours} ชั่วโมง</td>
                        </tr>
                        <tr>
                            <td>เป้าหมายกลุ่มอาชีพ</td>
                            <td>${course_detail.targetOccupation}</td>
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
                            <td>ค่าธรรมเนียม</td>
                            <td style="color: #12b100;">
                                <c:choose>
                                    <c:when test="${course_detail.fee == 0}">
                                        ไม่มีค่าธรรมเนียม
                                    </c:when>
                                    <c:when test="${course_detail.fee != 0}">
                                        ราคา <fmt:formatNumber value="${course_detail.fee}"/> บาท
                                    </c:when>
                                </c:choose>
                            </td>
                        </tr>

                        <c:choose>
                            <c:when test="${flag ne 'member'}">
                                <c:if test="${stt_remaining == true}">
                                    <c:set var="current" value="<%=LocalDate.now()%>"/>
                                    <c:set var="theStartRegister" value="${req.startRegister.toLocalDate()}"/>
                                    <c:set var="theLastRegister" value="${req.endRegister.toLocalDate()}"/>
                                    <c:choose>
                                        <c:when test="${current.isBefore(theStartRegister)}">
                                            <tr>
                                                <td></td>
                                                <td>
                                                    <button class="btn btn-secondary" disabled
                                                            style="color: #ffffff;background-color: #434343;border: none;">
                                                        ยังไม่เปิดรับลงทะเบียน
                                                    </button>
                                                </td>
                                            </tr>
                                        </c:when>
                                        <c:when test="${current.isAfter(theLastRegister)}">
                                            <tr>
                                                <td></td>
                                                <td>
                                                    <button class="btn btn-secondary" disabled style="color: #ffffff;">
                                                        ปิดรับสมัครแล้ว
                                                    </button>
                                                </td>
                                            </tr>
                                        </c:when>
                                        <c:otherwise>
                                            <tr>
                                                <td></td>
                                                <td>
                                                    <a href="${pageContext.request.contextPath}/register_member">
                                                        <button class="btn btn-success" style="width: 30%;">สมัครเลย!
                                                        </button>
                                                    </a>
                                                </td>
                                            </tr>
                                        </c:otherwise>
                                    </c:choose>
                                </c:if>
                            </c:when>
                        </c:choose>
                    </table>
                </div>
            </td>
            <td style="vertical-align: top;">
                <!--Image--->
                <img src="${pageContext.request.contextPath}/uploads/course_img/${course_detail.img}" alt="course_image"
                     class="img">
                <br><br><br>
                <div class="block_contactor">
                    <table class="contact">
                        <tr>
                            <td>
                                <%-- Declare a variable --%>
                                <c:set var="delimiter" value="$%"/>

                                <%-- Use the variable in fn:split --%>
                                <c:set var="contact" value="${fn:split(course_detail.contact, delimiter)}"/>
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


</div>
<jsp:include page="/WEB-INF/view/layouts/footer.jsp"/>
</body>

</html>
