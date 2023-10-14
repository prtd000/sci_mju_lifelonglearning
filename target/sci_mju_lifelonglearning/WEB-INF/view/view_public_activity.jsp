<%--
  Created by IntelliJ IDEA.
  User: asus
  Date: 8/27/2023
  Time: 3:31 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="lifelong.model.Admin" %>
<%@ page import="lifelong.model.Member" %>
<%@ page import="lifelong.model.Lecturer" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
<link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css">


<html>
<head>
    <title>News And Activities</title>
    <jsp:include page="/WEB-INF/view/layouts/detail-all-style.jsp"/>
    <%--    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">--%>


    <style>
        .activity_public_position{
            margin-left: 5%;
            margin-right: 5%;
        }

        .blog_header_page {
            box-shadow: 0px 0px 10px 2px #d2d1d1;
            margin-left: 5%;
            margin-right: 5%;
            text-align: center;
            padding: 16px;
            border-radius: 5px;
        }

        .header {
            font-size: 28px;
            color: black;
            font-weight: bold;
            margin-top: 15px;
        }

        .blog_news {
            margin-left: 5%;
            margin-right: 5%;
            border-radius: 5px;
            padding: 30px;
            box-shadow: 0px 0px 10px 2px #d2d1d1;
            margin-bottom: 25px;
        }

        .header_news {
            font-size: 31px;
            font-weight: bold;
            color: black;
            text-align: left;
            margin-left: 11px;
        }

        .date_news {
            color: black;
            text-align: left;
            margin-left: 11px;
        }

        .img_activity {
            height: 260px;
            width: 365px;
            object-fit: cover;
            border-radius: 5px;
            margin-left: 10px;
            margin-bottom: 20px;
        }

        .news_details{
            color: black;
            text-align: justify;
            width: 745px;
            font-weight: bold;
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
                    <a href="${pageContext.request.contextPath}/search_course" class="nav-item nav-link " style="font-size: 17px">หลักสูตรการอบรม</a>
                        <%--                <div class="dropdown-menu m-0">--%>
                        <%--                    <a href="#" class="dropdown-item">Reskill/Upskill</a>--%>
                        <%--                    <a href="#" class="dropdown-item">อบรมระยะสั้น</a>--%>
                        <%--                </div>--%>
                        <%--            </div>--%>
                    <a href="${pageContext.request.contextPath}/member/<%=member.getUsername()%>/listcourse" class="nav-item nav-link" style="font-size: 17px">หลักสูตรของฉัน</a>
                    <a href="${pageContext.request.contextPath}/view_activity" class="nav-item nav-link active" style="font-size: 17px">ข่าวสารและกิจกรรม</a>
<%--                    <a href="#" class="nav-item nav-link" style="font-size: 17px">เกี่ยวกับเรา</a>--%>
                    <a href="${pageContext.request.contextPath}/member/<%=member.getUsername()%>/edit_profile" class="nav-item nav-link" style="font-size: 17px">ข้อมูลส่วนตัว</a>
                    <a href="${pageContext.request.contextPath}/doLogout" class="nav-item nav-link" style="font-size: 17px">ออกจากระบบ</a>
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
                    <a href="${pageContext.request.contextPath}/search_course" class="nav-item nav-link " style="font-size: 17px">หลักสูตรการอบรม</a>
                    <a href="${pageContext.request.contextPath}/view_activity" class="nav-item nav-link active" style="font-size: 17px">ข่าวสารและกิจกรรม</a>
<%--                    <a href="#" class="nav-item nav-link" style="font-size: 17px">เกี่ยวกับเรา</a>--%>
                    <div class="nav-item dropdown">
                        <a href="#" class="nav-link dropdown-toggle nav-item" data-bs-toggle="dropdown" style="font-size: 17px">เข้าสู่ระบบ</a>
                        <div class="dropdown-menu m-0">
                            <a href="${pageContext.request.contextPath}/loginMember" class="dropdown-item" style="font-size: 17px">สำหรับสมาชิก</a>
                            <a href="${pageContext.request.contextPath}/loginLecturer" class="dropdown-item" style="font-size: 17px">สำหรับบุคลากร</a>
                            <a href="${pageContext.request.contextPath}/loginAdmin" class="dropdown-item" style="font-size: 17px">สำหรับผู้ดูแลระบบ</a>
                        </div>
                    </div>
                </div>
            </div>
        </nav>
        <!-- Navbar End -->
    </c:otherwise>
</c:choose>
<!-- Navbar End -->

    <div class="activity_public_position">
        <br>
        <div class="blog_header_page">
            <p class="header">ข่าวสารและกิจกรรม</p>
        </div>
        <br>

        <c:forEach var="list" items="${list_activities}">
            <div class="blog_news">
                <div>

                    <p class="header_news">${list.name}</p>

                    <fmt:formatDate value="${list.date}" pattern="dd/MM/yyyy" var="activity_date"/>
                    <c:set var="format_date" value="${fn:substring(activity_date, 0, 10)}"/>

                    <p class="date_news">วันที่ : ${format_date}</p>


                    <c:set var="imgNames" value="${list.img}"/>
                    <c:forEach var="listImg" items="${fn:split(imgNames, ',')}">
                        <c:set var="listImg"
                               value="${fn:replace(fn:replace(fn:replace(listImg, '\"', ''), '[', ''), ']', '')}"/>
                        <td>
                            <img src="${pageContext.request.contextPath}/assets/img/activity/public/${list.ac_id}/${listImg}" alt="News_img" class="img_activity">
                        </td>
                    </c:forEach>
                    <p class="news_details">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${list.detail}</p>
                </div>
            </div>
        </c:forEach>
    </div>

<center>
    <br>
    <a href="${pageContext.request.contextPath}/" style="font-weight: bold;">กลับหน้าแรก</a>
</center>

<jsp:include page="/WEB-INF/view/layouts/footer.jsp"/>
</body>
</html>
