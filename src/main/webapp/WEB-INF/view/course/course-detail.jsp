<%@ page import="lifelong.model.Admin" %>
<%@ page import="lifelong.model.Member" %>
<%@ page import="lifelong.model.Lecturer" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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
    <link href="https://fonts.googleapis.com/css2?family=Mitr:wght@200&family=Prompt:wght@200&display=swap" rel="stylesheet">

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

        .header_1{
            font-family: 'Archivo', sans-serif;
            position: absolute;
            font-size: 60px;
            font-weight: 900;
            top: 30%;
            left: 49%;
            transform: translate(-50%, -50%);
            color: white;
        }

        .header_2{
            font-family: 'Archivo', sans-serif;
            position: absolute;
            font-size: 33px;
            font-weight: 700;
            top: 39%;
            left: 35.5%;
            letter-spacing: 1px;
            transform: translate(-50%, -50%);
            color: white;
        }

        .bt_register{
            position: absolute;
            top: 47%;
            left: 20%;
            width: 177px;
            height: 49px;
            transform: translate(37%, -50%);
            border: 2px solid white;
            border-radius: 4px;
            color: black;
            font-weight: 700;
            transition: 0.5s;
        }
        .bt_register:hover{
            color: white;
            background-color: rgba(255, 255, 255, 0);
            transition: 0.5s;
        }

        .block_position {
            margin-left: 370px;
            margin-top: 54px;
            width: 830px;
            display: inline-block;
        }

        .c_name {
            color: black;
            width: 860px;
            font-size: 42px;
            font-weight: bold;
        }

        .major_name {
            color: black;
            font-size: 20px;
        }

        .img {
            height: 770px;
            width: 832px;
            border-radius: 15px;
            box-shadow: 0px 0px 10px 2px #b8b6b6;
        }

        .c_principle {
            width: 833px;
            text-align: justify;
            color: black;
        }

        table[class='detail'] tr td:first-child{
            width: 155px;
        }
        table[class='detail'] tr td{
            font-weight: bold;
        }
        tr{
            height: 50px;
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
        <jsp:include page="/WEB-INF/view/layouts/nav.jsp"/>
    </c:otherwise>
</c:choose>

<c:set var="object" value="${course_detail.object}"/>
<c:set var="parts" value="${fn:split(object, '$%')}"/>
<img src="${pageContext.request.contextPath}/assets/img/banner3.png" class="banner" alt="banner"/>
<p class="header_1">LIFELONG EDUCATION</p>
<p class="header_2">MAEJO UNIVERSITY</p>
<button class="bt_register" href="${pageContext.request.contextPath}/register_member">สมัครเลย!</button>


<div class="block_position">
    <p class="c_name">${course_detail.name}</p>

    <!--Major name--->
    <p class="major_name">${course_detail.major.name}</p>
    <br>
    <!--Image--->
    <img src="${pageContext.request.contextPath}/assets/img/course_img/${course_detail.img}" alt="course_image" class="img">
    <br><br><br>
    <!--Detail-->
    <div>
        <h1 style="font-size: 30px;">รายละเอียดหลักสูตร</h1>
        <p class="c_principle">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ${course_detail.principle}</p>
        <hr>
        <!---Sub_Detail-->
        <table class="detail" style="color: black;">
            <tr>
                <td>ประเภทหลักสูตร</td>
                <td>${course_detail.course_type}</td>
            </tr>
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
            <tr>
                <td>ค่าธรรมเนียม</td>
                <td>${course_detail.fee} บาท</td>
            </tr>
        </table>
        <%--        <div class="swiper-container">--%>
        <%--            <div class="swiper-wrapper">--%>
        <%--                <c:forEach var="list" items="${list_activities}">--%>
        <%--                    <c:set var="imgNames" value="${list.imgNamesJson}" />--%>
        <%--                    <c:forEach var="listImg" items="${fn:split(imgNames, ',')}">--%>
        <%--                        <c:set var="listImg" value="${fn:replace(fn:replace(fn:replace(listImg, '\"', ''), '[', ''), ']', '')}" />--%>

        <%--                        <div class="swiper-slide">--%>
        <%--                            <label>รูปภาพ :--%>
        <%--                                <img src="${pageContext.request.contextPath}/assets/img/addImg/${listImg}" alt="course_image" class="c_img" style="width: 20%">--%>
        <%--                                <br>IMG : ${listImg}--%>
        <%--                            </label><br>--%>
        <%--                        </div>--%>
        <%--                    </c:forEach>--%>
        <%--                    <label>รายละเอียด : ${list.detail}</label><br>--%>
        <%--                </c:forEach>--%>
        <%--            </div>--%>
        <%--            <div class="swiper-button-next"></div>--%>
        <%--            <div class="swiper-button-prev"></div>--%>
        <%--        </div>--%>
        <%--    </div>--%>
        <!--Course News--->

    </div>
</div>
<jsp:include page="/WEB-INF/view/layouts/footer.jsp"/>
</body>

</html>
