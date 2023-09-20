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
<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
<html>
<head>
    <title>Title</title>
    <jsp:include page="/WEB-INF/view/layouts/detail-all-style.jsp"/>
</head>
<body>
<jsp:include page="/WEB-INF/view/layouts/check_nav.jsp"/>
<div class="block_news_big">
    <h1>ข่าวสารเกี่ยวและกิจกรรม</h1>
    <c:forEach var="list" items="${list_activities}">
        <div class="block_news" style="width: 100%">
            <div class="news_content">
                <h1>${list.name}</h1>
                <p>${list.date}</p>
                <p>${list.detail}</p>
            </div>
            <table>
                <tr>
                    <c:set var="imgNames" value="${list.img}"/>
                    <c:forEach var="listImg" items="${fn:split(imgNames, ',')}">
                        <c:set var="listImg" value="${fn:replace(fn:replace(fn:replace(listImg, '\"', ''), '[', ''), ']', '')}"/>
                        <td><img src="${pageContext.request.contextPath}/assets/img/activity/public/${list.ac_id}/${listImg}" alt="News_img" class="news_img"></td>
                    </c:forEach>
                </tr>
            </table>
        </div>
    </c:forEach>
</div>
</body>
</html>
