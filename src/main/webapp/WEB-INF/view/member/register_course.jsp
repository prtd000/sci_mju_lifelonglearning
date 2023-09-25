<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="lifelong.model.Admin" %>
<%@ page import="lifelong.model.Member" %>
<%@ page import="lifelong.model.Lecturer" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<html>
<head>
    <title>Course Detail</title>
    <%--    bootstrap--%>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>

    <%--    Google Font--%>
    <link href="https://fonts.googleapis.com/css2?family=Mitr:wght@200&family=Prompt:wght@200&display=swap" rel="stylesheet">
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

        .header_1{
            font-family: 'Archivo', sans-serif;
            position: absolute;
            font-size: 60px;
            font-weight: 900;
            top: 30%;
            left: 50%;
            transform: translate(-50%, -50%);
            color: white;
        }

        .header_2{
            font-family: 'Archivo', sans-serif;
            position: absolute;
            font-size: 33px;
            font-weight: 700;
            top: 39%;
            left: 38%;
            letter-spacing: 1px;
            transform: translate(-50%, -50%);
            color: white;
        }

        .bt_register{
            position: absolute;
            top: 47%;
            left: 24%;
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
            margin-left: 461px;
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
    }else if (lecturer != null) {
        flag = "lecturer";
    } else if (member != null) {
        flag = "member";
    }else {
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

<c:set var="object" value="${req.course.object}"/>
<c:set var="parts" value="${fn:split(object, '$%')}"/>
<img src="${pageContext.request.contextPath}/assets/img/banner3.png" class="banner" alt="banner"/>
<p class="header_1">LIFELONG EDUCATION</p>
<p class="header_2">MAEJO UNIVERSITY</p>
<%--<button class="bt_register" href="${pageContext.request.contextPath}/register_member">สมัครเลย!</button>--%>

<div class="block_position">
    <p class="c_name">${course.name}</p>

    <!--Major name--->
    <p class="major_name">${course.major.name}</p>
    <br>
    <!--Image--->
    <img src="${pageContext.request.contextPath}/assets/img/course_img/${course.img}" alt="course_image" class="img">
    <br><br><br>
    <!--Detail-->
    <div>
        <h1 style="font-size: 30px;">รายละเอียดหลักสูตร</h1>
        <p class="c_principle">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ${course.principle}</p>
        <hr>
        <!---Sub_Detail-->
        <table class="detail" style="color: black;">
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
            <tr>
                <td>ค่าธรรมเนียม</td>
                <td>${course.fee} บาท</td>
            </tr>

            <c:choose>
                <c:when test="${req.type_learn.equals('เรียนออนไลน์')}">
                    <tr>
                        <td>ลิ้ง Mooc</td>
                        <td><a href="${pageContext.request.contextPath}/${req.linkMooc}">${req.linkMooc}</a></td>
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
                        <td>ลิ้ง Mooc</td>
                        <td><a href="${pageContext.request.contextPath}/${req.linkMooc}">${req.linkMooc}</a></td>
                    </tr>
                    <tr>
                        <td>สถานที่เรียน</td>
                        <td>${req.location}</td>
                    </tr>
                </c:when>
            </c:choose>

            <tr>
                <td class="t1">เนื้อหาของหลักสูตร</td>
                <td class="t2"><a href="${pageContext.request.contextPath}/assets/file/${course.file}" download>เอกสารประกอบการเรียน.pdf</a>
                </td>
            </tr>
            <tr>
                <td></td>
                <td>
                    <%--    Now--%>
                    <c:if test="${registered == true}">
                        <button class="btn btn-danger" disabled>ลงทะเบียนแล้ว</button>
                    </c:if>
                    <c:if test="${registered == false}">
                        <button class="btn btn-success" onclick="if((confirm('ยืนยันการลงทะเบียน'))){ window.location.href='${pageContext.request.contextPath}/member/<%=member.getUsername()%>/register_course/${course.course_id}/${req.request_id}/register';return false; }">สมัคร</button>
                    </c:if>
                </td>
            </tr>
        </table>
    </div>
    <br>


    <br><br>
<%--    Course News--%>
    <c:choose>
        <c:when test="${activity.size() == 0}">
            <h1 style="display: none">ข่าวสารเกี่ยวกับหลักสูตร</h1>
        </c:when>
        <c:otherwise>
            <h1 style="display: block">ข่าวสารเกี่ยวกับหลักสูตร</h1>
        </c:otherwise>
    </c:choose>

    <c:forEach var="list" items="${activity}">
        <div class="block_news_big" style="float: left">
            <div class="block_news">
                <c:set var="imgNames" value="${list.img}"/>
                <c:forEach var="listImg" items="${fn:split(imgNames, ',')}">
                    <c:set var="listImg" value="${fn:replace(fn:replace(fn:replace(listImg, '\"', ''), '[', ''), ']', '')}"/>
                    <td><img src="${pageContext.request.contextPath}/assets/img/activity/private/${list.ac_id}/${listImg}" alt="News_img" class="news_img"></td>
                </c:forEach>
<%--                <div><img src="img/banner1.jpeg" alt="News_img" class="news_img"></div>--%>
                <div class="news_content">
                    <h1>${list.name}</h1>
                    <h4>${list.type}</h4>
                    <p>${list.detail}</p>
                    <p>${list.date}</p>
                </div>
            </div>
        </div>
    </c:forEach>
</div>


<jsp:include page="/WEB-INF/view/layouts/footer.jsp"/>
</body>
</html>
