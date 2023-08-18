<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
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
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <link
            rel="stylesheet"
            href="https://cdn.jsdelivr.net/npm/flatpickr@4.6.6/dist/flatpickr.min.css"
    />
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
        <c:if test="${request_open_course != null}">
            <i>กรอกข้อมูลในฟอร์ม. เครื.องหมายดอกจัน(*) หมายถึงห้ามว่าง</i>
            <br><br>
        <form action="${pageContext.request.contextPath}/lecturer/${lec_id}/${request_open_course.request_id}/update" method="POST">
            <%
                Date currentDate = new Date();
                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd");
                String date = dateFormat.format(currentDate);

                int std_result = 0;
                int registerID = 0;
            %>
            <table>
                <colgroup>
                    <col style="width: 160px;">
                    <col style="width: auto;">
                </colgroup>
                <tbody>
                <%--                    <tr>--%>
                <%--                        <td>--%>
                <%--                            <label>รหัสการร้องขอ:</label>--%>
                <%--                        </td>--%>
                <%--                        <td><form:input path="request_id"/>--%>
                <%--                            <form:errors path="request_id" cssClass="error"/>--%>
                <%--                        </td>--%>
                <%--                    </tr>--%>
                <tr>
                    <td>
                        <label>หลักสูตร:</label>
                    </td>
                    <td>
                        <select name="course_id" id="course_id">
                            <c:forEach items="${courses}" var="course">
                                <c:choose>
                                    <c:when test="${course.course_id eq request_open_course.course.course_id}">
                                        <option value="${course.course_id}" selected>${course.name}</option>
                                    </c:when>
                                    <c:otherwise>
                                        <option value="${course.course_id}">${course.name}</option>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>
                        </select>
                    </td>
                </tr>
                <%--                    <tr>--%>
                <%--                        <td>--%>
                <%--                            <label>วันที่ร้องขอ:</label>--%>
                <%--                        </td>--%>
                <%--&lt;%&ndash;                        <%date = dateFormat.parse("12/12/2002");%>&ndash;%&gt;--%>
                <%--                        <td><form:input path="requestDate" type="text"/>--%>
                <%--                                <form:errors path="requestDate" cssClass="error"/>--%>
                <%--                    </tr>--%>
                <tr>
                    <td>
                        <label>วันเปิดรับสมัคร:</label>
                    </td>
                    <td><input name="startRegister" type="date" id="startRegister" class="datepicker" value="${request_open_course.startRegister}"/></td>
                </tr>
                <tr>
                    <td><label>วันปิดรับสมัคร:</label></td>
                    <td>
                        <input name="endRegister" type="date" id="endRegister" class="datepicker" value="${request_open_course.endRegister}"/>
                    </td>
                </tr>
                <tr>
                    <td><label>จำนวนรับสมัคร:</label></td>
                    <td>
                        <input name="quantity" id="quantity" cssClass="number" autocomplete="off" value="${request_open_course.quantity}"/>
                    </td>
                </tr>
                <tr>
                    <td><label>วันที่เริ่มเรียน:</label></td>
                    <td>
                        <input name="startStudyDate" type="date" id="startStudyDate" class="datepicker" value="${request_open_course.startStudyDate}"/>
                    </td>
                </tr>
                <tr>
                    <td><label>วันที่สิ้นสุดการเรียน:</label></td>
                    <td>
                        <input name="endStudyDate" type="date" id="endStudyDate" class="datepicker" value="${request_open_course.endStudyDate}"/>
                    </td>
                </tr>
                <tr>
                    <td><label>เวลาในการเรียนเรียน:</label></td>
                    <td>
                        <input name="studyTime" id="studyTime" autocomplete="off" value="${request_open_course.studyTime}"/>
                    </td>
                </tr>
                <tr>
                    <td><label>วันประกาศผลการสมัคร:</label></td>
                    <td>
                        <input name="applicationResult" type="date" id="applicationResult" class="datepicker" value="${request_open_course.applicationResult}"/>
                    </td>
                </tr>
                <tr>
                    <td><label>ประเภทการเรียน:</label></td>
                    <td>
                        <input name="type_learn" id="type_learn" autocomplete="off" value="${request_open_course.type_learn}"/>
                    </td>
                </tr>
                <tr>
                    <td><label>รูปแบบการสอน:</label></td>
                    <td>
                        <input name="type_teach" id="type_teach" autocomplete="off" value="${request_open_course.type_teach}"/>
                    </td>
                </tr>
                <tr>
                    <td><label>สถานที่:</label></td>
                    <td>
                        <input name="location" id="location" autocomplete="off" value="${request_open_course.location}"/>
                    </td>
                </tr>
                <tr>
                    <td><label>ลายเซ็น:</label></td>
                    <td>
                        <input name="signature" id="signature" autocomplete="off" value="${request_open_course.signature}"/>
                    </td>
                </tr>
                <%--                    <tr>--%>
                <%--                        <td>--%>
                <%--                            <label>อาจารย์ประจำหลักสูตร:</label>--%>
                <%--                        </td>--%>
                <%--                        <td>--%>
                <%--                            <select name="lecturer_username" id="lecturer_username">--%>
                <%--                                <c:forEach items="${lecturers}" var="lecturer">--%>
                <%--                                    <option value="${lecturer.username}">${lecturer.firstName}</option>--%>
                <%--                                </c:forEach>--%>
                <%--                            </select>--%>
                <%--                        </td>--%>
                <%--                    </tr>--%>
                <tr>
                    <td><label></label></td>
                    <td>
                        <input type="submit" name="confirmButton" value="บันทึก" class="save" />
                        <input type="button" value="ย้อนกลับ"
                               onclick="window.location.href='${pageContext.request.contextPath}/lecturer/${lec_id}/view_request_open_course/${request_open_course.request_id}'; return false;"
                               class="cancel-button"/>
                    </td>
                </tr>
                </tbody>
            </table>
        </form>
        </c:if>
        <c:if test="${request_open_course == null}">
            <h3>ไม่พบการร้องขอนี้</h3>
            <input type="button" value="ย้อนกลับ"
                   onclick="window.location.href='${pageContext.request.contextPath}/lecturer/${lec_id}/list_request_open_course'; return false;"
                   class="cancel-button"/>
        </c:if>
    </div>
</div>

<jsp:include page="/WEB-INF/view/layouts/footer.jsp"/>
</body>
<script>
    document.addEventListener("DOMContentLoaded", function () {
        const quantityInput = document.getElementById("quantity");

        quantityInput.addEventListener("focus", function () {
            setTimeout(function () {
                const inputs = document.getElementsByTagName("input");
                for (let i = 0; i < inputs.length; i++) {
                    inputs[i].setAttribute("autocomplete", "off");
                }
            }, 100);
        });
    });
</script>
<script>
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
