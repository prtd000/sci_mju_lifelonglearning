<%--
  Created by IntelliJ IDEA.
  User: asus
  Date: 8/27/2023
  Time: 3:31 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>

<html>
<head>
    <title>Public Activity</title>
    <jsp:include page="/WEB-INF/view/layouts/detail-all-style.jsp"/>
    <%--    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">--%>


    <style>
        .activity_public_position{
            margin-left: 350px;
        }

        .blog_header_page {
            box-shadow: 0px 0px 10px 2px #d2d1d1;
            width: 845px;
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
            width: 845px;
            border-radius: 5px;
            padding: 30px;
            box-shadow: 0px 0px 10px 2px #d2d1d1;
            margin-bottom: 25px;
        }

        .header_news {
            font-size: 26px;
            font-weight: bold;
            color: black;
        }

        .date_news {
            font-size: 17px;
            color: black;
        }

        .img_activity {
            height: 260px;
            width: 365px;
            object-fit: cover;
            border-radius: 5px;
            margin-right: 10px;
            margin-bottom: 20px;
        }

    </style>
</head>
<body>
<jsp:include page="/WEB-INF/view/layouts/check_nav.jsp"/>
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

                <p style="color: black;">วันที่ : ${format_date}</p>


                <c:set var="imgNames" value="${list.img}"/>
                <c:forEach var="listImg" items="${fn:split(imgNames, ',')}">
                    <c:set var="listImg"
                           value="${fn:replace(fn:replace(fn:replace(listImg, '\"', ''), '[', ''), ']', '')}"/>
                    <td>
                        <img src="${pageContext.request.contextPath}/assets/img/activity/public/${list.ac_id}/${listImg}" alt="News_img" class="img_activity">
                    </td>
                </c:forEach>
                <p style="color: black; text-align: justify;width: 745px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${list.detail}</p>
            </div>
        </div>
    </c:forEach>
</div>

<jsp:include page="/WEB-INF/view/layouts/footer.jsp"/>
</body>
</html>
