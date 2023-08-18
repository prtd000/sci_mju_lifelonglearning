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
    <c:if test="${activities != null}">
    <i>กรอกข้อมูลในฟอร์ม. เครื.องหมายดอกจัน(*) หมายถึงห้ามว่าง555555555555555555555555555555</i>
    <br><br>
    <form action="${pageContext.request.contextPath}/lecturer/${lec_id}/${activities.ac_id}/update_course_add_activity" method="POST">
      <table>
        <colgroup>
          <col style="width: 160px;">
          <col style="width: auto;">
        </colgroup>
        <tbody>
        <tr>
          <td><label>ชื่อข่าว:</label></td>
          <td><input name="ac_name" type="text" id="ac_name" value="${activities.name}"/></td>
        </tr>
        <tr>
          <td><label>หลักสูตร:</label></td>
          <td><input class="txt_input" name="ac_course" type="text" id="ac_course" value="${activities.requestOpenCourse.course.name}" disabled/></td>
        </tr>
        <tr>
          <td><label>รายละเอียด:</label></td>
          <td><textarea name="ac_detail" id="ac_detail">${activities.detail}</textarea></td>
        </tr>
        <tr>
          <td><label>รูปภาพ:</label></td>
          <td><input name="ac_img" type="text" id="ac_img" value="${activities.img}"/></td>
        </tr>
        <tr>
          <td><input type="button" onclick="window.location.href='${pageContext.request.contextPath}/lecturer/${lec_id}/${activities.ac_id}/view_course_activity_page/${request_id}'; return false;" value="ย้อนกลับ"></td>
          <td><input type="submit" value="บันทึก" class="save"/>
            <%--                        <input type="button" value="ยกเลิก"onclick="window.location.href='list'; return false;"class="cancel-button"/>--%>
          </td>
        </tr>
        </tbody>
      </table>
    </form>
    </c:if>
    <c:if test="${activities == null}">
      <h3>ไม่พบข่าวสารนี้</h3>
      <input type="button" onclick="window.location.href='${pageContext.request.contextPath}/lecturer/${lec_id}/view_approve_request_open_course/${request_id}'; return false;" value="ย้อนกลับ">    </c:if>
  </div>
</div>
<jsp:include page="/WEB-INF/view/layouts/footer.jsp"/>
</body>
</html>
