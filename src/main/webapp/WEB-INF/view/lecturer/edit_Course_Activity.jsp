<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 5/30/2023
  Time: 1:26 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="lifelong.model.*" %>
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

  <link href="${pageContext.request.contextPath}/assets/css/admin/addPublicActivity.css" rel="stylesheet">
  <link href="https://cdn.quilljs.com/1.3.6/quill.snow.css" rel="stylesheet">
  <script src="https://cdn.quilljs.com/1.3.6/quill.js"></script>
</head>
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
  <c:when test="${flag.equals('admin')}">
    <jsp:include page="/WEB-INF/view/admin/nav_admin.jsp"/>
  </c:when>
  <c:when test="${flag.equals('member')}">
    <jsp:include page="/WEB-INF/view/member/nav_member.jsp"/>
  </c:when>
  <c:when test="${flag.equals('null')}">
    <jsp:include page="/WEB-INF/view/layouts/nav.jsp"/>
  </c:when>
</c:choose>
<c:choose>
  <c:when test="${flag.equals('lecturer')}">
    <% assert admin != null; %>
    <!-- Navbar Start -->
    <nav class="navbar navbar-expand-lg bg-white navbar-light shadow-sm py-3 py-lg-0 px-3 px-lg-0">
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
          <a href="${pageContext.request.contextPath}/" class="nav-item nav-link" style="font-size: 18px">หน้าหลัก</a>
          <a href="${pageContext.request.contextPath}/search_course" class="nav-item nav-link" style="font-size: 18px">หลักสูตรการอบรม</a>
          <a href="${pageContext.request.contextPath}/lecturer/<%=lecturer.getUsername()%>/add_roc" class="nav-item nav-link" style="font-size: 18px">ร้องขอหลักสูตร</a>
          <a href="${pageContext.request.contextPath}/lecturer/<%=lecturer.getUsername()%>/list_request_open_course" class="nav-item nav-link" style="font-size: 18px">รายการร้องขอ</a>
          <a href="${pageContext.request.contextPath}/lecturer/<%=lecturer.getUsername()%>/list_approve_request_open_course" class="nav-item nav-link active" style="font-size: 18px">หลักสูตรของฉัน</a>
          <a href="${pageContext.request.contextPath}/view_activity" class="nav-item nav-link" style="font-size: 18px">ข่าวสารและกิจกรรม</a>
          <a href="${pageContext.request.contextPath}/doLogout" class="nav-item nav-link" style="font-size: 18px">ออกจากระบบ</a>
        </div>
      </div>
    </nav>
    <!-- Navbar End -->
<div class="container">
  <div id="container">
    <c:if test="${activities != null}">
    <form id="signUpForm" onsubmit="return confirmAction();" action="${pageContext.request.contextPath}/lecturer/${lec_id}/${activities.ac_id}/update_course_add_activity" method="POST" enctype="multipart/form-data">
      <!-- step one -->
      <div class="step">
        <h3>แก้ไขข่าวสารประจำหลักสูตร</h3>
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
              <label>หลักสูตร</label>
              <div class="mb-3">
                <div class="course-totalHours-container">
                  <input name="ac_course" id="ac_course" type="text" autocomplete="off" oninput="this.className = ''" class="flex-td" value="${activities.requestOpenCourse.course.name}" disabled/>
                </div>
              </div>
            </td>
          </tr>
          <tr>
            <td>
              <div class="mb-3">
                <div class="form-floating" style="height: 500px">
                  <div id="editor" style="">${activities.detail}</div>
                  <textarea style="display: none;" id="ac_detail" name="ac_detail"></textarea>
                </div>
                <label id="invalidAcDetail" style="color: red; font-size: 12px"></label>
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
                    <%--                      <input class="txt_input" name="ac_img" type="file" id="ac_img" multiple onchange="loadExistingImages()"/>--%>
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
                        <img src="${pageContext.request.contextPath}/uploads/activity/private/${activities.ac_id}/${listImg}" style="width: 180px">
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
      <div style="width: 100%" align="center" class="flex-container">
        <input type="button" value="ย้อนกลับ"
               onclick="window.location.href='${pageContext.request.contextPath}/lecturer/${request_id}/list_course_activity_news'; return false;"
               style="width: 47%" class="flex-container"/>
        <input type="submit" value="บันทึก" class="button-5" style="width: 47%"/>
      </div>
    </form>
    </c:if>
    <c:if test="${activities == null}">
      <h3>ไม่พบข่าวสารนี้</h3>
      <input type="button" onclick="window.location.href='${pageContext.request.contextPath}/lecturer/${activities.requestOpenCourse.request_id}/list_course_activity_news'; return false;" value="ย้อนกลับ">    </c:if>
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
    updateAcDetailField(); // อัปเดตข้อมูลจาก Rich Text Editor
    if (validateAcName() && validateAcImg()) {
      var result = confirm("คุณแน่ใจหรือไม่ว่าต้องการเพิ่มข่าวสารนี้?");
      if (result) {
        return true; // ถ้าผู้ใช้กด OK ให้ทำงานตามปกติ
      } else {
        return false; // ถ้าผู้ใช้กด Cancel ให้ยกเลิกการส่งฟอร์ม
      }
    } else {
      // ถ้าข้อมูลไม่ถูกต้อง ให้ยกเลิกการส่งฟอร์ม
      return false;
    }
  }
</script>
<%--ส่งRich Test Editer--%>
<script>
  // สร้าง Rich Text Editor และกำหนดเนื้อหาเริ่มต้น
  var quill = new Quill('#editor', {
    theme: 'snow',
    placeholder: 'กรอกเนื้อหาของคุณที่นี่...', // ข้อความที่จะแสดงในตอนเริ่มต้น
    // เนื้อหาเริ่มต้น (HTML หรือ plain text)
    // ตัวอย่างเช่น: '<p>เนื้อหาเริ่มต้น</p>'
  });
  // กำหนดเนื้อหาเริ่มต้น
  // quill.clipboard.dangerouslyPasteHTML('BEST');
  function updateAcDetailField() {
    var acDetail = quill.getText();
    document.getElementById('ac_detail').value = acDetail;
  }
</script>
</html>
