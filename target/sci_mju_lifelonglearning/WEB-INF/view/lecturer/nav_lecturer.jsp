<%@ page import="lifelong.model.Lecturer" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<form:form action="${pageContext.request.contextPath}/logout" method="post" name="frmLogout"></form:form>
<%
  Lecturer lecturer = (Lecturer) session.getAttribute("lecturer");
%>
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
      <a href="${pageContext.request.contextPath}/" class="nav-item nav-link active">หน้าหลัก</a>
      <a href="#" class="nav-item nav-link">เกี่ยวกับคณะ</a>
      <%--            <div class="nav-item dropdown">--%>
      <%--                <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">หลักสูตรการอบรม</a>--%>
      <a href="${pageContext.request.contextPath}/search_course" class="nav-item nav-link">หลักสูตรการอบรม</a>
      <a href="${pageContext.request.contextPath}/lecturer/<%=lecturer.getUsername()%>/list_request_open_course" class="nav-item nav-link">รายการร้องขอ</a>
      <%--                <div class="dropdown-menu m-0">--%>
      <%--                    <a href="#" class="dropdown-item">Reskill/Upskill</a>--%>
      <%--                    <a href="#" class="dropdown-item">อบรมระยะสั้น</a>--%>

      <%--                </div>--%>
      <%--            </div>--%>
      <a href="#" class="nav-item nav-link">ข่าวสารและกิจกรรม</a>
      <a href="#" class="nav-item nav-link">เกี่ยวกับเรา</a>
      <a href="#" class="nav-item nav-link">Lecturer</a>
      <a href="${pageContext.request.contextPath}/doLogout" class="nav-item nav-link">ออกจากระบบ</a>

      <%--            <a href="${pageContext.request.contextPath}/login" class="nav-item nav-link">เข้าสู่ระบบ</a>--%>
    </div>
  </div>
</nav>
<!-- Navbar End -->
