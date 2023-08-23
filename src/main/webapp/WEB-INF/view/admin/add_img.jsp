<%@ page import="java.util.List" %>
<%@ page import="lifelong.model.Member" %>
<%@ page import="lifelong.model.AddImg" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 8/16/2023
  Time: 9:33 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    List<AddImg> addImgs = (List<AddImg>) session.getAttribute("list_img");
%>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%for(AddImg a : addImgs){%>
    <%=a.getId()%>
<%}%>
<%--    <form action="${pageContext.request.contextPath}/course/addPDF" method="post" enctype="multipart/form-data">--%>
<%--        <input type="text" name="detail" placeholder="Image Detail"><br>--%>
<%--        <input type="file" name="file"><br>--%>
<%--        <button type="submit">Upload Image</button>--%>
<%--    </form>--%>

<%--    <c:forEach var="list" items="${list_img}">--%>
<%--        <label>รูปภาพ :--%>
<%--            <img src="${pageContext.request.contextPath}/assets/img/addImg/${list.img}" alt="course_image" class="c_img" style="width: 20%">--%>
<%--        </label><br>--%>
<%--&lt;%&ndash;        <c:set var="path" value="${pageContext.request.contextPath}/${list.img}"></c:set>&ndash;%&gt;--%>
<%--&lt;%&ndash;        path : ${path}<br>&ndash;%&gt;--%>
<%--        <label>รายละเอียด : ${list.detail}</label><br>--%>
<%--    </c:forEach>--%>

<form action="/checkImage" method="get">
    <input type="text" name="search_img" id="search_img">
</form>
<div id="alert_check"></div>
</body>
<script>
    document.getElementById("search_img").addEventListener("input", function() {
        const searchImgValue = document.getElementById("search_img").value;
        const alertCheckElement = document.getElementById("alert_check");

        if (searchImgValue.trim() === "") {
            alertCheckElement.textContent = "";
            return;
        }

        // เรียกใช้งาน URL ของการตรวจสอบค่าในฐานข้อมูล
        const checkImageUrl = "/checkImage?search_img=" + searchImgValue;
        console.log("searchImgValue : "+searchImgValue);
        fetch(checkImageUrl)
            .then(response => response.text())
            .then(result => {
                console.log("Result from server:", result); // ดูค่าที่ได้จาก Server ใน Console
                if (result === "exists") {
                    alertCheckElement.textContent = "Image exists in the database.";
                } else {
                    alertCheckElement.textContent = "Image does not exist in the database.";
                }
            })
            .catch(error => {
                console.error("Request failed:", error);
            });
    });

</script>


</html>
