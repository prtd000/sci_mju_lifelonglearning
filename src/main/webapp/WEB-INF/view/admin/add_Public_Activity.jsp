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
  <h1>เพิ่ม${title}</h1>
</div>
<div class="container">
  <div id="container">
    <i>กรอกข้อมูลในฟอร์ม. เครื.องหมายดอกจัน(*) หมายถึงห้ามว่าง</i>
    <br><br>
    <form action="${pageContext.request.contextPath}/activity/admin/save_public_add_activity" method="POST">
      <table>
        <colgroup>
          <col style="width: 160px;">
          <col style="width: auto;">
        </colgroup>
        <tbody>
        <tr>
          <td><label>ชื่อข่าว:</label></td>
          <td><input name="ac_name" type="text" id="ac_name"/></td>
        </tr>
<%--        <tr>--%>
<%--          <td><label>สาขา:</label></td>--%>
<%--          <td>--%>
<%--            <select name="major_id" id="major_id">--%>
<%--              <option value="" label="--กรุณาเลือกหลักสูตร--"></option>--%>
<%--              <c:forEach items="${majors}" var="major">--%>
<%--                <option value="${major.major_id}">${major.name}</option>--%>
<%--              </c:forEach>--%>
<%--            </select>--%>
<%--          </td>--%>
<%--        </tr>--%>
        <tr>
          <td><label>รายละเอียด:</label></td>
          <td><textarea name="ac_detail" id="ac_detail"></textarea></td>
        </tr>
        <tr>
          <td><label>รูปภาพ:</label></td>
          <td><input name="ac_img" type="text" id="ac_img"/></td>
        </tr>
        <tr>
          <td><label></label></td>
          <td><input type="submit" value="บันทึก" class="save"/>
            <%--                        <input type="button" value="ยกเลิก"onclick="window.location.href='list'; return false;"class="cancel-button"/>--%>
          </td>
        </tr>
        </tbody>
      </table>
    </form>
  </div>
</div>
<jsp:include page="/WEB-INF/view/layouts/footer.jsp"/>
</body>
</html>
