<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %><%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 8/28/2023
  Time: 9:00 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Upload Image</title>
</head>
<body>
<%--<form action="${pageContext.request.contextPath}/course/add_Test_ListImg" method="post" enctype="multipart/form-data">--%>
<%--    <input type="file" name="imageFile" multiple>--%>
<%--    <input type="submit" value="Upload Image">--%>
<%--</form>--%>
<h1>Pagination Example</h1>

<%-- ข้อมูลทั้งหมดที่คุณต้องการแสดง --%>
<%
    List<Integer> allData = new ArrayList<>();
    for (int i = 1; i <= 100; i++) {
        allData.add(i);
    }
%>

<%-- หน้าที่คุณต้องการแสดงและรายการต่อหน้า --%>
<%
    int page1 = (request.getParameter("page") != null) ? Integer.parseInt(request.getParameter("page")) : 1;
    int perPage = 10;  // จำนวนรายการต่อหน้า
    int totalPages = (int) Math.ceil((double) allData.size() / perPage);
%>

<%-- คำนวณดัชนีเริ่มต้นและดัชนีสิ้นสุดของข้อมูลในหน้านี้ --%>
<%
    int startIndex = (page1 - 1) * perPage;
    int endIndex = Math.min(startIndex + perPage, allData.size());
%>

<%-- ดึงข้อมูลจากดัชนีเริ่มต้นถึงดัชนีสิ้นสุด --%>
<%
    List<Integer> paginatedData = allData.subList(startIndex, endIndex);
%>

<%-- แสดงข้อมูลที่ได้ --%>
<ul>
    <% for (Integer item : paginatedData) { %>
    <li><%= item %></li>
    <% } %>
</ul>

<%-- สร้างลิงก์หรือปุ่มเพื่อให้ผู้ใช้สามารถเปลี่ยนหน้า --%>
<div>
    <% if (page1 > 1) { %>
    <a href="?page=<%= page1 - 1 %>">ก่อนหน้า</a>
    <% } %>

    <% if (page1 < totalPages) { %>
    <a href="?page=<%= page1 + 1 %>">ถัดไป</a>
    <% } %>
</div>
</body>
</html>

