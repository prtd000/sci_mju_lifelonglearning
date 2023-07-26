<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 5/30/2023
  Time: 1:26 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
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
        <form:form action="${pageContext.request.contextPath}/course/save" modelAttribute="add_course" method="POST">
            <table>
                <colgroup>
                    <col style="width: 160px;">
                    <col style="width: auto;">
                </colgroup>
                <tbody>
                <tr>
                    <td>
                        <label>รหัสหลักสูตร:</label>
                    </td>
                    <td><form:input path="course_id"/>
<%--                        <form:errors path="course_id" cssClass="error"/>--%>
                    </td>
                </tr>
                <tr>
                    <td>
                        <label>ชื่อหลักสูตร:</label>
                    </td>
                    <td><form:input path="name"/>
                        <form:errors path="name" cssClass="error"/></td>
                </tr>
                <tr>
                    <td>
                        <label>ชื่อเกีตรติบัตร:</label>
                    </td>
                    <td><form:input path="certificateName"/>
                        <form:errors path="certificateName" cssClass="error"/></td>
                </tr>
                <tr>
                    <td><label>รูปหลักสูตร:</label></td>
                    <td>
                        <form:input path="img"/>
                        <form:errors path="img" cssClass="error"/>
<%--                        <form:textarea path="img">--%>
<%--                        </form:textarea>--%>
<%--                        <form:errors path="description" cssClass="error"/>--%>
                    </td>
                </tr>
                <tr>
                    <td><label>หลักการและเหตุผล:</label></td>
                    <td>
                        <form:textarea path="principle" cols="50" rows="5"></form:textarea>
                        <form:errors path="principle" cssClass="error"/>
                    </td>
                </tr>
                <tr>
                    <td><label>วัตถุประสงค์:</label></td>
                    <td>
                        <form:textarea path="object" cols="50" rows="5"></form:textarea>
                        <form:errors path="object" cssClass="error"/>
                    </td>
                </tr>
                <tr>
                    <td><label>ระยะเวลาในการเรียน:</label></td>
                    <td>
                        <form:input path="totalHours" cssClass="number"/>
                        <form:errors path="totalHours" cssClass="error"/>
                    </td>
                </tr>
                <tr>
                    <td><label>เป้าหมายกลุ่มอาชีพ:</label></td>
                    <td>
                        <form:input path="targetOccupation"/>
                        <form:errors path="targetOccupation" cssClass="error"/>
                    </td>
                </tr>
                <tr>
                    <td><label>ค่าธรรมเนียม:</label></td>
                    <td>
                        <form:input path="fee" cssClass="number"/>
                        <form:errors path="fee" cssClass="error"/>
                    </td>
                </tr>
                <tr>
                    <td><label>ไฟล์หลักสูตร:</label></td>
                    <td>
                        <form:input path="file"/>
                        <form:errors path="file" cssClass="error"/>
                    </td>
                </tr>
                <tr>
                    <td><label>สถานะหลักสูตร:</label></td>
                    <td>
                        <form:input path="status"/>
                        <form:errors path="status" cssClass="error"/>
                    </td>
                </tr>
                <tr>
                    <td><label>ลิ้งค์หลักสูตร:</label></td>
                    <td>
                        <form:input path="linkMooc"/>
                        <form:errors path="linkMooc" cssClass="error"/>
                    </td>
                </tr>
                <tr>
                    <td><label>ประเภท:</label></td>
                    <td>
                        <form:input path="course_type"/>
                        <form:errors path="course_type" cssClass="error"/>
                    </td>
                </tr>
                <tr>
                    <td><label>สาขา:</label></td>
                    <td>
                        <form:select path="major.major_id">
                            <form:option value="" label="--กรุณาเลือกรายการ--"/>
                            <form:options items="${majors}" itemLabel="name" itemValue="major_id"/>
                        </form:select>
                        <form:errors path="major.major_id" cssClass="error"/>
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
        </form:form>
    </div>
</div>
<jsp:include page="/WEB-INF/view/layouts/footer.jsp"/>
</body>
</html>
