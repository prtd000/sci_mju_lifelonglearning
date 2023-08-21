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
    <title>${title}</title>
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
        <form action="${pageContext.request.contextPath}/course/admin/save" method="POST" enctype="multipart/form-data">
            <table>
                <colgroup>
                    <col style="width: 160px;">
                    <col style="width: auto;">
                </colgroup>
                <tbody>
                <tr>
                    <td><label>ประเภท:</label></td>
                    <td>
                        <select name="course_type" id="course_type">
                            <option value="" label="--กรุณาเลือกหลักสูตร--"></option>
                            <option value="หลักสูตรอบรมระยะสั้น" label="หลักสูตรอบรมระยะสั้น"></option>
                            <option value="Non-Degree" label="Non-Degree"></option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td><label>ชื่อหลักสูตร:</label></td>
                    <td><input name="course_name" type="text" id="course_name"/></td>
                </tr>
                <tr>
                    <td><label>ชื่อเกียรติบัตร:</label></td>
                    <td><input name="certificateName" type="text" id="certificateName"/></td>
                </tr>
                <tr>
                    <td><label>รูปหลักสูตร:</label></td>
                    <td><input name="course_img" type="file" id="course_img"/></td>
                </tr>
                <tr>
                    <td><label>หลักการและเหตุผล:</label></td>
                    <td><textarea name="course_principle" id="course_principle"></textarea></td>
                </tr>
                <tr>
                    <td><label>วัตถุประสงค์:</label></td>
                    <td><textarea name="course_object" id="course_object"></textarea></td>
                </tr>
                <tr>
                    <td><label>ระยะเวลาในการเรียน:</label></td>
                    <td><input name="course_totalHours" type="number" id="course_totalHours"/></td>
                </tr>
                <tr>
                    <td><label>เป้าหมายกลุ่มอาชีพ:</label></td>
                    <td><input name="course_targetOccupation" type="text" id="course_targetOccupation"/></td>
                </tr>
                <tr>
                    <td><label>ค่าธรรมเนียม:</label></td>
                    <td><input name="course_fee" type="text" id="course_fee"/></td>
                </tr>
                <tr>
                    <td><label>ไฟล์หลักสูตร:</label></td>
                    <td><input name="course_file" type="file" id="course_file"/></td>
                </tr>
                <tr>
                    <td><label>ลิ้งค์หลักสูตร:</label></td>
                    <td><input name="course_linkMooc" type="text" id="course_linkMooc"/></td>
                </tr>
                <tr>
                    <td><label>สาขา:</label></td>
                    <td>
                        <select name="major_id" id="major_id">
                            <option value="" label="--กรุณาเลือกหลักสูตร--"></option>
                            <c:forEach items="${majors}" var="major">
                                <option value="${major.major_id}">${major.name}</option>
                            </c:forEach>
                        </select>
                    </td>
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
