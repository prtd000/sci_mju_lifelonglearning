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
    <title>Private Activity Detail</title>
    <jsp:include page="/WEB-INF/view/layouts/detail-all-style.jsp"/>
    <style>
        .blog_private {
            width: 840px;
            margin-left: 346px;
            margin-top: 68px;
            box-shadow: 0px 0px 10px 2px #d2d1d1;
            padding: 44px;
            border-radius: 6px;
        }

        .header_news {
            font-size: 30px;
            color: black;
            font-weight: bold;
        }

        .txt_date {
            color: black;
            font-size: 17px;
            margin-bottom: 28px;
        }

        .img_activity {
            height: 250px;
            width: 366px;
            object-fit: cover;
            border-radius: 5px;
            margin-right: 5px;
            margin-bottom: 10px;
        }

        .ac_detail{
            margin-top: 20px;
            color: black;
            text-align: justify;
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

<div class="blog_private">
    <p class="header_news">${ac_detail.name}</p>
    <fmt:formatDate value="${ac_detail.date}" pattern="dd/MM/yyyy" var="activity_date"/>
    <c:set var="format_date" value="${fn:substring(activity_date, 0, 10)}"/>
    <p class="txt_date">วันที่ : ${format_date}</p>

    <c:set var="imgNames" value="${ac_detail.img}"/>
    <c:forEach var="listImg" items="${fn:split(imgNames, ',')}">
        <c:set var="listImg" value="${fn:replace(fn:replace(fn:replace(listImg, '\"', ''), '[', ''), ']', '')}"/>
            <img src="${pageContext.request.contextPath}/assets/img/activity/private/${ac_detail.ac_id}/${listImg}" alt="News_img" class="img_activity">
        </c:forEach>


    <p class="ac_detail">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${ac_detail.detail}</p>
</div>

<jsp:include page="/WEB-INF/view/layouts/footer.jsp"/>

</body>
</html>
