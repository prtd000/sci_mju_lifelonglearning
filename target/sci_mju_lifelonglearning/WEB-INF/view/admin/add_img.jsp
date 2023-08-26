<%@ page import="java.util.List" %>
<%@ page import="lifelong.model.Member" %>
<%@ page import="lifelong.model.AddImg" %>
<%@ page import="lifelong.service.ActivityServiceImpl" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css" />
<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>

<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 8/16/2023
  Time: 9:33 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Image Slideshow</title>
    <link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css" />
</head>
<body>

<%--    <form action="${pageContext.request.contextPath}/course/addImg" method="post" enctype="multipart/form-data">--%>
<%--        <input type="text" name="detail" placeholder="Image Detail"><br>--%>
<%--        <input type="file" name="file"><br>--%>
<%--        <button type="submit">Upload Image</button>--%>
<%--    </form>--%>

<form action="${pageContext.request.contextPath}/course/addListImg" method="post" enctype="multipart/form-data">
    <input type="text" name="detail" placeholder="Image Detail"><br>
    <input type="file" name="files" multiple><br> <!-- ใช้ 'files' แทน 'file' และเพิ่ม 'multiple' เพื่ออัปโหลดหลายไฟล์ -->
    <button type="submit">Upload Images</button>
</form>

<%--    <c:forEach var="list" items="${list_img}">--%>
<%--        <label>รูปภาพ :--%>
<%--            <img src="${pageContext.request.contextPath}/assets/img/addImg/${list.img}" alt="course_image" class="c_img" style="width: 20%">--%>
<%--        </label><br>--%>
<%--&lt;%&ndash;        <c:set var="path" value="${pageContext.request.contextPath}/${list.img}"></c:set>&ndash;%&gt;--%>
<%--&lt;%&ndash;        path : ${path}<br>&ndash;%&gt;--%>
<%--        <label>รายละเอียด : ${list.detail}</label><br>--%>
<%--    </c:forEach>--%>

<div class="swiper-container">
    <div class="swiper-wrapper">
        <c:forEach var="list" items="${list_img}">
            <c:set var="imgNames" value="${list.imgNamesJson}" />
            <c:forEach var="listImg" items="${fn:split(imgNames, ',')}">
                <c:set var="listImg" value="${fn:replace(fn:replace(fn:replace(listImg, '\"', ''), '[', ''), ']', '')}" />

                <div class="swiper-slide">
                    <label>รูปภาพ :
                        <img src="${pageContext.request.contextPath}/assets/img/addImg/${listImg}" alt="course_image" class="c_img" style="width: 20%">
                        <br>IMG : ${listImg}
                    </label><br>
                </div>
            </c:forEach>
            <label>รายละเอียด : ${list.detail}</label><br>
        </c:forEach>
    </div>
    <div class="swiper-button-next"></div>
    <div class="swiper-button-prev"></div>
</div>


<%--<div class="swiper-container">--%>
<%--    <div class="swiper-wrapper">--%>
<%--        <c:forEach var="list" items="${list_img}">--%>
<%--            &lt;%&ndash; Call the method to parse image names using EL &ndash;%&gt;--%>
<%--            <c:set var="imgArray" value="${activityServiceImpl.parseImageNames(list.imgNamesJson)}" />--%>
<%--            <c:forEach var="listImg" items="${imgArray}">--%>
<%--                <div class="swiper-slide">--%>
<%--                    <label>รูปภาพ :--%>
<%--                        <img src="${pageContext.request.contextPath}/assets/img/addImg/${listImg}" alt="course_image" class="c_img" style="width: 20px">--%>
<%--                        <br>IMG : ${listImg}--%>
<%--                    </label><br>--%>
<%--                </div>--%>
<%--            </c:forEach>--%>
<%--            <label>รายละเอียด : ${list.detail}</label><br>--%>
<%--        </c:forEach>--%>
<%--    </div>--%>
<%--    <div class="swiper-button-next"></div>--%>
<%--    <div class="swiper-button-prev"></div>--%>
<%--</div>--%>
<%--<%--%>
<%--    String list_img = (String) request.getAttribute("list_img");--%>

<%--    // Remove square brackets and quotes from the input string--%>
<%--    list_img = list_img.replace("[", "").replace("]", "").replace("\"", "");--%>

<%--    // Split the comma-separated values into an array--%>
<%--    String[] imgNames = list_img.split(",");--%>
<%--%>--%>
<%--<div class="swiper-container">--%>
<%--    <div class="swiper-wrapper">--%>
<%--        <c:forEach var="imgName" items="<%= imgNames %>">--%>
<%--            <div class="swiper-slide">--%>
<%--                <label>รูปภาพ :--%>
<%--                    <img src="${pageContext.request.contextPath}/assets/img/addImg/${imgName}" alt="course_image" class="c_img" style="width: 20%">--%>
<%--                    <br>IMG : ${imgName}--%>
<%--                </label><br>--%>
<%--            </div>--%>
<%--        </c:forEach>--%>
<%--    </div>--%>
<%--    <div class="swiper-button-next"></div>--%>
<%--    <div class="swiper-button-prev"></div>--%>
<%--</div>--%>


<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
<script>
    document.addEventListener("DOMContentLoaded", function () {
        var swiper = new Swiper(".swiper-container", {
            slidesPerView: 1,
            spaceBetween: 10,
            navigation: {
                nextEl: ".swiper-button-next",
                prevEl: ".swiper-button-prev",
            },
        });
    });
</script>

</body>

</html>
