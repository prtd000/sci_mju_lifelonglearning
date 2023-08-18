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
  <title>เพิ่ม${title}</title>
  <jsp:include page="/WEB-INF/view/layouts/detail-all-style.jsp"/>
</head>
<body>
<jsp:include page="/WEB-INF/view/layouts/nav.jsp"/>
<div id="header">
  <h1>${title}</h1>
</div>
<div class="container">
  <div id="container">
    <i>กรอกข้อมูลในฟอร์ม. เครื.องหมายดอกจัน(*) หมายถึงห้ามว่าง</i>
    <br><br>
      <table>
        <colgroup>
          <col style="width: 160px;">
          <col style="width: auto;">
        </colgroup>
        <tbody>
        <tr>
          <td><label>ชื่อข่าว:</label></td>
          <td>${activities.name}</td>
        </tr>
        <tr>
          <td><label>รายละเอียด:</label></td>
          <td>${activities.detail}</td>
        </tr>
        <tr>
          <td><label>รูปภาพ:</label></td>
          <td>${activities.img}</td>
        </tr>
        <tr>
          <td><a href="${pageContext.request.contextPath}/course/list_all_course"><button>ย้อนกลับ</button></a></td>
          <td><a href="${pageContext.request.contextPath}/course/public/${activities.ac_id}/edit_page"><button>แก้ไข</button></a></td>
        </tr>
        </tbody>
      </table>
  </div>
</div>
<jsp:include page="/WEB-INF/view/layouts/footer.jsp"/>
</body>
</html>
