<%--
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
  <title>ยกเลิกหลักสูตร</title>
  <jsp:include page="/WEB-INF/view/layouts/detail-all-style.jsp"/>
</head>
<body>
<jsp:include page="/WEB-INF/view/layouts/nav.jsp"/>
<div id="header">
  <h3>หมายเหตุ * ทำไมถึงยกเลิกหลักสูตรนี้</h3>
  <h1>${ROC_detail.course.name}</h1>
  <h4>${ROC_detail.course.major.name}</h4>
  <label>อาจารย์ที่ร้องขอ : ${ROC_detail.lecturer.firstName} ${ROC_detail.lecturer.lastName}</label>
</div>
<div class="container">
  <div id="container">
    <form action="${pageContext.request.contextPath}/course/note_cancel_request_open_course/${ROC_detail.request_id}/cancel" method="POST">
      <div id="customPopup" class="custom-popup">
        <div class="popup-content">
          <h2>กรุณากรอกเหตุผลในการยกเลิกคำร้องขอ</h2>
          <textarea id="cancelReason" name="cancelReason" rows="4" cols="50"></textarea>
          <br>
          <input type="button" value="ยกเลิก"
                 onclick="window.location.href='${pageContext.request.contextPath}/course/view_request_open_course/${ROC_detail.request_id}'; return false;"
                 class="cancel-button"/>
          <input type="submit" value="ยืนยัน">
        </div>
      </div>
    </form>
  </div>
</div>
<jsp:include page="/WEB-INF/view/layouts/footer.jsp"/>
</body>
</html>
