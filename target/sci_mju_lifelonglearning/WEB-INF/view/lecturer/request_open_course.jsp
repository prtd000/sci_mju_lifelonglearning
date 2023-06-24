<%@ page import="java.text.SimpleDateFormat" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%--
  Created by IntelliJ IDEA.
  User: asus
  Date: 30/5/2566
  Time: 13:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>RequestOpenCourse</title>
    <jsp:include page="/WEB-INF/view/layouts/detail-all-style.jsp"/>

    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

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
            <form:form action="${pageContext.request.contextPath}/request_open_course/save" modelAttribute="request_open_course" method="POST">
                <table>
                    <colgroup>
                        <col style="width: 160px;">
                        <col style="width: auto;">
                    </colgroup>
                    <tbody>
                    <tr>
                        <td>
                            <label>รหัสการร้องขอ:</label>
                        </td>
                        <td><form:input path="request_id"/>
                            <form:errors path="request_id" cssClass="error"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label>หลักสูตร:</label>
                        </td>
                        <td><form:select path="course.course_id">
                            <form:option value="" label="--กรุณาเลือกรายการ--"/>
                            <form:options items="${courses}" itemLabel="name" itemValue="course_id"/>
                            </form:select>
                            <form:errors path="course.course_id" cssClass="error"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label>วันที่ร้องขอ:</label>
                        </td>
<%--                        <%date = dateFormat.parse("12/12/2002");%>--%>
                        <td><form:input path="requestDate" type="text"/>
                                <form:errors path="requestDate" cssClass="error"/>
                    </tr>
                    <tr>
                        <td>
                            <label>วันเปิดรับสมัคร:</label>
                        </td>
                        <td><form:input path="startRegister" type="text" id="datepicker1" class="datepicker"/>
                            <form:errors path="startRegister" cssClass="error"/></td>
                    </tr>
                    <tr>
                        <td><label>วันปิดรับสมัคร:</label></td>
                        <td>
                            <form:input path="endRegister" type="text" id="datepicker2" class="datepicker"/>
                            <form:errors path="endRegister" cssClass="error"/>
                        </td>
                    </tr>
                    <tr>
                        <td><label>จำนวนรับสมัคร:</label></td>
                        <td>
                            <form:input path="quantity" cssClass="number"/>
                            <form:errors path="quantity" cssClass="number"/>
                        </td>
                    </tr>
                    <tr>
                        <td><label>วันที่เริ่มเรียน:</label></td>
                        <td>
                            <form:input path="startStudyDate" type="text" id="datepicker3" class="datepicker"/>
                            <form:errors path="startStudyDate" cssClass="error"/>
                        </td>
                    </tr>
                    <tr>
                        <td><label>วันที่สิ้นสุดการเรียน:</label></td>
                        <td>
                            <form:input path="endStudyDate" type="text" id="datepicker4" class="datepicker"/>
                            <form:errors path="endStudyDate" cssClass="error"/>
                        </td>
                    </tr>
                    <tr>
                        <td><label>เวลาในการเรียนเรียน:</label></td>
                        <td>
                            <form:input path="studyTime"/>
                            <form:errors path="studyTime" cssClass="error"/>
                        </td>
                    </tr>
                    <tr>
                        <td><label>วันประกาศผลการสมัคร:</label></td>
                        <td>
                            <form:input path="applicationResult" type="text" id="datepicker5" class="datepicker"/>
                            <form:errors path="applicationResult" cssClass="error"/>
                        </td>
                    </tr>
                    <tr>
                        <td><label>ประเภทการเรียน:</label></td>
                        <td>
                            <form:input path="type_learn"/>
                            <form:errors path="type_learn" cssClass="error"/>
                        </td>
                    </tr>
                    <tr>
                        <td><label>รูปแบบการสอน:</label></td>
                        <td>
                            <form:input path="type_teach"/>
                            <form:errors path="type_teach" cssClass="error"/>
                        </td>
                    </tr>
                    <tr>
                        <td><label>สถานที่:</label></td>
                        <td>
                            <form:input path="location"/>
                            <form:errors path="location" cssClass="error"/>
                        </td>
                    </tr>
                    <tr>
                        <td><label>สถานะการร้องขอ:</label></td>
                        <td>
                            <form:input path="requestStatus" value="false"/>
                            <form:errors path="requestStatus" cssClass="error"/>
                        </td>
                    </tr>
                    <tr>
                        <td><label>ลายเซ็น:</label></td>
                        <td>
                            <form:input path="signature"/>
                            <form:errors path="signature" cssClass="error"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label>หลักสูตร:</label>
                        </td>
                        <td><form:select path="lecturer.username">
                            <form:option value="" label="--กรุณาเลือกรายการ--"/>
                            <form:options items="${lecturers}" itemLabel="firstName" itemValue="username"/>
                        </form:select>
                            <form:errors path="lecturer.username" cssClass="error"/>
                        </td>
                    </tr>
                    <tr>
                        <td><label></label></td>
                        <td>
                            <input type="submit" value="บันทึก" class="save"/>
                                <%--                        <input type="button" value="ยกเลิก"onclick="window.location.href='list'; return false;"class="cancel-button"/>--%>
                            <input type="button" value="ย้อนกลับ"
                                   onclick="window.location.href='${pageContext.request.contextPath}/request_open_course/list_request_open_course'; return false;"
                                   class="cancel-button"/>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </form:form>
        </div>
    </div>

    <jsp:include page="/WEB-INF/view/layouts/footer.jsp"/>
</body>

<script>
    $(function() {
        $("#datepicker1, #datepicker2, #datepicker3, #datepicker4, #datepicker5").datepicker({
            dateFormat: "mm/dd/yy" // รูปแบบวันที่ที่ต้องการ
        });
    });
    function openCity(evt, cityName) {
        var i, tabcontent, tablinks;
        tabcontent = document.getElementsByClassName("tabcontent");
        for (i = 0; i < tabcontent.length; i++) {
            tabcontent[i].style.display = "none";
        }
        tablinks = document.getElementsByClassName("tablinks");
        for (i = 0; i < tablinks.length; i++) {
            tablinks[i].className = tablinks[i].className.replace(" active", "");
        }
        document.getElementById(cityName).style.display = "block";
        evt.currentTarget.className += " active";
    }
</script>
</html>
