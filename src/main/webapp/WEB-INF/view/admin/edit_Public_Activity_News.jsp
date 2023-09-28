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
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPEhtml>
<html>
<head>
  <title>เพิ่ม${title}</title>
  <jsp:include page="/WEB-INF/view/layouts/detail-all-style.jsp"/>
  <!-- google font -->
  <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&display=swap" rel="stylesheet">

  <link href="${pageContext.request.contextPath}/assets/css/admin/style_addcourse.css" rel="stylesheet">
</head>
<style>
  .txt_input {
    width: 70%;
  }
</style>
<script>
  function previewImages() {
    var preview = document.getElementById('imagePreview');
    var loadImg = document.getElementById('loadImg');
    var ac_img = document.getElementById('ac_img');
    var img_label = document.getElementById('img_label');
    var files = document.getElementById('ac_img').files;
    var maxImagesToShow = 3; // จำนวนรูปภาพที่ต้องการแสดงเป็นตัวอย่าง
    var remainingImages = files.length - maxImagesToShow; // จำนวนรูปภาพที่เหลือ

    preview.innerHTML = ''; // ล้างเนื้อหาที่แสดงรูปภาพตัวอย่างเก่า
    img_label.innerHTML = '';

    for (var i = 0; i < maxImagesToShow; i++) {
      var file = files[i];
      var reader = new FileReader();

      reader.onload = function (e) {
        var img = document.createElement('img');
        img.src = e.target.result;
        img.style.maxWidth = '200px'; // ตั้งความกว้างสูงสุดของรูปภาพ
        img.style.maxHeight = '200px'; // ตั้งความสูงสูงสุดของรูปภาพ
        preview.appendChild(img); // เพิ่มรูปภาพลงในตัวแสดงรูปภาพตัวอย่าง
      };

      reader.readAsDataURL(file); // อ่านไฟล์ภาพและแสดงผล
    }

    if (remainingImages > 0) {
      var remainingImagesText = 'และรูปภาพอีก ' + remainingImages + ' รูป';
      var message = document.createElement('p');
      message.textContent = remainingImagesText;
      // preview.appendChild(message);
      img_label.appendChild(message);
    }
    loadImg.style.display = 'none';
    preview.style.display = 'block';
    img_label.style.display = 'block';
  }

</script>
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
          <a href="${pageContext.request.contextPath}/course/<%=admin.getUsername()%>/list_all_course" class="nav-item nav-link">หลักสูตรทั้งหมด</a>
          <a href="${pageContext.request.contextPath}/course/public/list_activity" class="nav-item nav-link active">ข่าวสารและกิจกรรม</a>
          <a href="#" class="nav-item nav-link">Admin</a>
          <a href="${pageContext.request.contextPath}/doLogout" class="nav-item nav-link">ออกจากระบบ</a>

            <%--            <a href="${pageContext.request.contextPath}/login" class="nav-item nav-link">เข้าสู่ระบบ</a>--%>
        </div>
      </div>
    </nav>
    <!-- Navbar End -->
    <div class="container">
      <div id="container">

        <form id="signUpForm" onsubmit="return confirmAction();" action="${pageContext.request.contextPath}/course/<%=admin.getUsername()%>/${activities.ac_id}/update_public_add_activity" method="POST" enctype="multipart/form-data">
          <!-- step one -->
          <div class="step">
            <h3>แก้ไขข่าวสารทั่วไป</h3>
            <hr>
            <table style="width: 100%">
              <tr>
                <td>
                  <label>ชื่อข่าวสาร</label>
                  <div class="mb-3">
                    <div class="course-totalHours-container">
                      <input name="ac_name" id="ac_name" type="text" autocomplete="off" oninput="this.className = ''" class="flex-td" value="${activities.name}"/>
                    </div>
                  </div>
                </td>
              </tr>
              <tr>
                <td>
                  <div class="mb-3">
                    <div class="form-floating">
                      <textarea class="form-control" placeholder="" id="ac_detail" name="ac_detail" style="height: 100px">${activities.detail}</textarea>
                      <label for="ac_detail">รายละเอียด</label>
                    </div>
                  </div>
                </td>
              </tr>
              <tr>
                <td>
                  <label>รูปภาพ</label>
                </td>
              </tr>
              <tr>
                <td>
                  <div class="mb-3">
                    <div class="form-floating">
                      <input class="txt_input" name="ac_img" type="file" id="ac_img" accept="image/*" multiple onchange="previewImages()"/>
                    </div>
                  </div>
                </td>
              </tr>
              <tr>
                <td>
                  <div id="loadImg">
                    <c:if test="${not empty activities.img}">
                      <c:set var="imgNames" value="${activities.img}" />
                      <c:set var="imgArray" value="${fn:split(imgNames, ',')}" />

                      <c:forEach var="listImg" items="${imgArray}" varStatus="loop">
                        <c:set var="listImg" value="${fn:replace(fn:replace(fn:replace(listImg, '\"', ''), '[', ''), ']', '')}" />
                        <c:if test="${loop.index < 3}">
                          <div style="display: inline-block">
                            <img src="${pageContext.request.contextPath}/assets/img/activity/public/${activities.ac_id}/${listImg}" width="200px">
                          </div>
                        </c:if>
                      </c:forEach>

                      <c:if test="${fn:length(imgArray) > 3}">
                        <label>และรูปภาพอีก ${fn:length(imgArray) - 3} รูป</label>
                      </c:if>
                    </c:if>
                  </div>
                  <div id="imagePreview" style="display: none"></div>
                  <label id="img_label" style="display: none"></label>
                </td>
              </tr>
            </table>
          </div>
          <!-- start previous / next buttons -->
          <div style="width: 100%" align="center" class="flex-container">
            <input type="button" value="ย้อนกลับ"
                   onclick="window.location.href='${pageContext.request.contextPath}/course/public/list_activity'; return false;"
                   style="width: 47%" class="flex-container"/>
            <input type="submit" value="บันทึก" class="button-5" style="width: 47%"/>
          </div>
          <!-- end previous / next buttons -->
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
<script>
  var currentTab = 0; // Current tab is set to be the first tab (0)
  showTab(currentTab); // Display the current tab
  function showTab(n) {
    var x = document.getElementsByClassName("step");
    x[n].style.display = "block";
  }
  function confirmAction() {
    var result = confirm("คุณแน่ใจหรือไม่ว่าต้องการเพิ่มข่าวสารนี้?");
    if (result) {
      return true; // ถ้าผู้ใช้กด OK ให้ทำงานตามปกติ
    } else {
      return false; // ถ้าผู้ใช้กด Cancel ให้ยกเลิกการส่งฟอร์ม
    }
  }
</script>
</html>