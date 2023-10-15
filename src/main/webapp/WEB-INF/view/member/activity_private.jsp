<%--
  Created by IntelliJ IDEA.
  User: asus
  Date: 9/27/2023
  Time: 9:06 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="lifelong.model.Admin" %>
<%@ page import="lifelong.model.Member" %>
<%@ page import="lifelong.model.Lecturer" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>Private Activity</title>
    <jsp:include page="/WEB-INF/view/layouts/detail-all-style.jsp"/>
    <style>
        .blog_private {
            margin-left: 10%;
            margin-right: 10%;
            margin-top: 3%;
            border-radius: 5px;
            padding: 30px;
            box-shadow: 0px 0px 10px 2px #d2d1d1;
        }

        .header_news {
            font-size: 30px;
            color: black;
            font-weight: bold;
            margin-left: 11px;
        }

        .txt_date {
            color: black;
            font-size: 17px;
            margin-bottom: 28px;
            margin-left: 11px;
        }

        .img_activity {
            height: 250px;
            width: 366px;
            object-fit: cover;
            border-radius: 5px;
            margin-left: 11px;
            margin-bottom: 15px;
        }

        .ac_detail{
            margin-top: 20px;
            color: black;
            text-align: justify;
            margin-left: 11px;
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
                    <a href="${pageContext.request.contextPath}/search_course" class="nav-item nav-link active" style="font-size: 17px">หลักสูตรการอบรม</a>
                        <%--                <div class="dropdown-menu m-0">--%>
                        <%--                    <a href="#" class="dropdown-item">Reskill/Upskill</a>--%>
                        <%--                    <a href="#" class="dropdown-item">อบรมระยะสั้น</a>--%>
                        <%--                </div>--%>
                        <%--            </div>--%>
                    <a href="${pageContext.request.contextPath}/member/<%=member.getUsername()%>/listcourse" class="nav-item nav-link" style="font-size: 17px">หลักสูตรของฉัน</a>
                    <a href="${pageContext.request.contextPath}/view_activity" class="nav-item nav-link" style="font-size: 17px">ข่าวสารและกิจกรรม</a>
<%--                    <a href="#" class="nav-item nav-link" style="font-size: 17px">เกี่ยวกับเรา</a>--%>
                    <a href="${pageContext.request.contextPath}/member/<%=member.getUsername()%>/edit_profile" class="nav-item nav-link" style="font-size: 17px">ข้อมูลส่วนตัว</a>
                    <a href="${pageContext.request.contextPath}/doLogout" class="nav-item nav-link" style="font-size: 17px">ออกจากระบบ</a>
                </div>
            </div>
        </nav>
        <!-- Navbar End -->
    </c:when>
</c:choose>

<div class="blog_private">
    <p class="header_news">${ac_detail.name}</p>
    <fmt:formatDate value="${ac_detail.date}" pattern="dd/MM/yyyy" var="activity_date"/>
    <c:set var="format_date" value="${fn:substring(activity_date, 0, 10)}"/>
    <p class="txt_date">วันที่ : ${format_date}</p>

    <c:set var="imgNames" value="${ac_detail.img}"/>
    <c:forEach var="listImg" items="${fn:split(imgNames, ',')}">
        <c:set var="listImg" value="${fn:replace(fn:replace(fn:replace(listImg, '\"', ''), '[', ''), ']', '')}"/>
            <img src="${pageContext.request.contextPath}/uploads/activity/private/${ac_detail.ac_id}/${listImg}" alt="News_img" class="img_activity">
        </c:forEach>


    <p class="ac_detail">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${ac_detail.detail}</p>
</div>

<center>
    <br>
    <a href="${pageContext.request.contextPath}/" style="font-weight: bold;">กลับหน้าแรก</a>
</center>

<jsp:include page="/WEB-INF/view/layouts/footer.jsp"/>

</body>
</html>
