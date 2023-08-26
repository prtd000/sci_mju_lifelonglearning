<%@ page import="lifelong.model.Member" %>
<%@ page import="lifelong.model.Admin" %>
<%@ page import="lifelong.model.Lecturer" %><%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 5/30/2023
  Time: 1:26 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPEhtml>
<html>
<head>
  <title>เพิ่ม${title}</title>
  <jsp:include page="/WEB-INF/view/layouts/detail-all-style.jsp"/>
</head>
<style>
  .txt_input {
    width: 70%;
  }
</style>
<body>
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
<c:set var="flag" value="<%= flag %>"></c:set>
<c:choose>
  <c:when test="${flag.equals('lecturer')}">
    <jsp:include page="/WEB-INF/view/lecturer/nav_lecturer.jsp"/>
  </c:when>
  <c:when test="${flag.equals('member')}">
    <jsp:include page="/WEB-INF/view/member/nav_member.jsp"/>
  </c:when>
  <c:when test="${flag.equals('null')}">
    <jsp:include page="/WEB-INF/view/layouts/nav.jsp"/>
  </c:when>
</c:choose>
<c:choose>
  <c:when test="${flag.equals('admin')}">
    <% assert admin != null; %>
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
          <a href="${pageContext.request.contextPath}/" class="nav-item nav-link">หน้าหลัก</a>
          <a href="#" class="nav-item nav-link">เกี่ยวกับคณะ</a>
            <%--            <div class="nav-item dropdown">--%>
            <%--                <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">หลักสูตรการอบรม</a>--%>
          <a href="${pageContext.request.contextPath}/course/<%=admin.getUsername()%>/list_all_course" class="nav-item nav-link active">หลักสูตรทั้งหมด</a>
          <a href="#" class="nav-item nav-link">ข่าวสารและกิจกรรม</a>
          <a href="#" class="nav-item nav-link">Admin</a>
          <a href="${pageContext.request.contextPath}/doLogout" class="nav-item nav-link">ออกจากระบบ</a>

            <%--            <a href="${pageContext.request.contextPath}/login" class="nav-item nav-link">เข้าสู่ระบบ</a>--%>
        </div>
      </div>
    </nav>
    <!-- Navbar End -->
    <div id="header">
      <h1>เพิ่ม${title}</h1>
    </div>
    <div class="container">
      <div id="container">
        <i>กรอกข้อมูลในฟอร์ม. เครื.องหมายดอกจัน(*) หมายถึงห้ามว่าง</i>
        <br><br>
        <form action="${pageContext.request.contextPath}/course/<%=admin.getUsername()%>/save_public_add_activity" method="POST" enctype="multipart/form-data">
          <table style="width: 100%">
            <colgroup>
              <col style="width: 160px;">
              <col style="width: auto;">
            </colgroup>
            <tbody>
            <tr>
              <td><label>ชื่อข่าว:</label></td>
              <td><input class="txt_input" style="width: 70%" name="ac_name" type="text" id="ac_name"/></td>
            </tr>
            <tr>
              <td><label>รายละเอียด:</label></td>
              <td><textarea class="txt_input" name="ac_detail" id="ac_detail"></textarea></td>
            </tr>
            <tr>
              <td><label>รูปภาพ:</label></td>
              <td><input class="txt_input" name="ac_img" type="file" id="ac_img" multiple/></td>
            </tr>
            <tr>
              <td></td>
              <td><input type="submit" value="บันทึก" class="save"/>
                  <%--                        <input type="button" value="ยกเลิก"onclick="window.location.href='list'; return false;"class="cancel-button"/>--%>
              </td>
            </tr>
            </tbody>
          </table>
        </form>
      </div>
    </div>
  </c:when>
  <c:when test="${flag.equals('null')}">
    <h1>กรุณา Log in ใหม่</h1>
    <a href="${pageContext.request.contextPath}/">กลับหน้าหลัก</a>
  </c:when>
  <c:otherwise>
    <h1>คุณไม่มีสิทธิในหน้านี้</h1>
  </c:otherwise>
</c:choose>
</body>
</html>
