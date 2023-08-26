<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
    <title>Title</title>
</head>
<body>
<%--<form action="${pageContext.request.contextPath}/course/editPDF/${pdf.id}" method="post" enctype="multipart/form-data">--%>
<%--    <input type="text" name="detail" placeholder="Image Detail" value="${pdf.detail}"><br>--%>
<%--    <input name="file" type="file" id="file" /><br>--%>
<%--    <c:if test="${not empty pdf.img}">--%>
<%--        <input type="hidden" name="existingFileName" value="${pdf.img}" />--%>
<%--        <a target="_blank">${pdf.img}</a>--%>
<%--    </c:if>--%>
<%--    <button type="submit">Update PDF</button>--%>
<%--</form>--%>
<form action="${pageContext.request.contextPath}/course/editListImg/${pdf.id}" method="post" enctype="multipart/form-data">
    <%--@declare id="detail"--%><label for="detail">Image Detail:</label>
    <input type="text" name="detail" value="${pdf.detail}" /><br>

    <label for="file">PDF File:</label>
    <input type="file" name="file" id="file" multiple/><br>

    <c:if test="${not empty pdf.imgNamesJson}">
        <h2>Existing Images:</h2>
        <c:set var="imgNames" value="${pdf.imgNamesJson}" />
        <c:forEach var="listImg" items="${fn:split(imgNames, ',')}">
            <c:set var="listImg" value="${fn:replace(fn:replace(fn:replace(listImg, '\"', ''), '[', ''), ']', '')}" />
            <p>IMG: ${listImg}</p>
        </c:forEach>
    </c:if>

    <button type="submit">Update PDF</button>
</form>
</body>
</html>
