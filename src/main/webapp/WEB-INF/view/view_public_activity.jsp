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

    <style>
        .blog_header_page{
            box-shadow: 0px 0px 10px 2px #d2d1d1;
            width: 900px;
            text-align: center;
            padding: 16px;
            border-radius: 5px;
        }
        .header{
            font-size: 28px;
            color: black;
            font-weight: bold;
            margin-top: 15px;
        }

        .blog_news{
            width: 900px;
            border-radius: 5px;
            padding: 30px;
            box-shadow: 0px 0px 10px 2px #d2d1d1;
            margin-bottom: 25px;
        }

        .header_news{
            font-size: 26px;
            font-weight: bold;
            color: black;
        }
        .date_news{
            font-size: 17px;
            color: black;
        }

        .img_activity{
            height: 230px;
            width: 350px;
            object-fit: cover;
            border-radius: 5px;
        }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/view/layouts/check_nav.jsp"/>
    <center>
        <br>
        <div class="blog_header_page">
            <p class="header">ข่าวสารและกิจกรรม</p>
        </div>
        <br>

        <c:forEach var="list" items="${list_activities}">
            <div class="blog_news">
                    <div>
                        <table>
                            <tr>
                                <td colspan="2">
                                    <p class="header_news">${list.name}</p>
                                </td>
                            </tr>
                            <tr>
                                <c:set var="date" value="${list.date}"/>
                                <c:set var="format_date" value="${fn:substring(date, 0, 10)}"/>
                                <td colspan="2"><p class="date_news">วันที่ : ${format_date}</p></td>
                            </tr>
                            <tr>
                                <c:set var="imgNames" value="${list.img}"/>
                                <c:forEach var="listImg" items="${fn:split(imgNames, ',')}">
                                    <c:set var="listImg" value="${fn:replace(fn:replace(fn:replace(listImg, '\"', ''), '[', ''), ']', '')}"/>
                                    <td><img src="${pageContext.request.contextPath}/assets/img/activity/public/${list.ac_id}/${listImg}" alt="News_img" class="img_activity"></td>
                                </c:forEach>

                                <td style="vertical-align: top; padding-left: 23px; color: black;">
                                    <p>${list.detail}</p>
                                </td>
                            </tr>
                        </table>
                    </div>
            </div>
        </c:forEach>
    </center>
    <jsp:include page="/WEB-INF/view/layouts/footer.jsp"/>
</body>

<script>
    /******** Format Date to dd/mm/yyyy **************/

    function formatDateElement(elementId) {
        var text = document.getElementById(elementId).textContent;
        var date = new Date(text);

        var day = date.getDate();
        var month = date.getMonth() + 1; // เพิ่ม 1 เนื่องจากเดือนเริ่มต้นจาก 0
        var year = date.getFullYear();

        return day + '/' + month + '/' + year;
    }

    var formattedNews_date = formatDateElement("news_date");
    document.getElementById("news_date").textContent = formattedNews_date;
</script>
</html>
