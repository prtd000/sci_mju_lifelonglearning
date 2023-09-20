<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page import="lifelong.model.*" %>
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
        <a href="${pageContext.request.contextPath}/" class="nav-item nav-link active">หน้าหลัก</a>
        <a href="#" class="nav-item nav-link">เกี่ยวกับคณะ</a>
        <%--            <div class="nav-item dropdown">--%>
        <%--                <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">หลักสูตรการอบรม</a>--%>
        <a href="${pageContext.request.contextPath}/search_course" class="nav-item nav-link">หลักสูตรการอบรม</a>
        <a href="${pageContext.request.contextPath}/lecturer/<%=lecturer.getUsername()%>/list_request_open_course" class="nav-item nav-link">รายการร้องขอ</a>
        <%--                <div class="dropdown-menu m-0">--%>
        <%--                    <a href="#" class="dropdown-item">Reskill/Upskill</a>--%>
        <%--                    <a href="#" class="dropdown-item">อบรมระยะสั้น</a>--%>

        <%--                </div>--%>
        <%--            </div>--%>
        <a href="#" class="nav-item nav-link">ข่าวสารและกิจกรรม</a>
        <a href="#" class="nav-item nav-link">เกี่ยวกับเรา</a>
        <a href="#" class="nav-item nav-link">Lecturer</a>
        <a href="${pageContext.request.contextPath}/doLogout" class="nav-item nav-link">ออกจากระบบ</a>

        <%--            <a href="${pageContext.request.contextPath}/login" class="nav-item nav-link">เข้าสู่ระบบ</a>--%>
        </div>
        </div>
        </nav>
        <!-- Navbar End -->
    <div id="header">
        <h1>${title}</h1>
    </div>
    <div class="container">
        <div id="container">
            <i>กรอกข้อมูลในฟอร์ม. เครื.องหมายดอกจัน(*) หมายถึงห้ามว่าง</i>
            <br><br>
            <form action="${pageContext.request.contextPath}/lecturer/${lecturer.username}/save" method="POST" enctype="multipart/form-data" onsubmit="return confirmAction();">
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
                    <tr>
                        <td>
                            <label>หลักสูตร:</label>
                        </td>
                        <td>
                            <select name="course_id" id="course_id">
                                <c:forEach items="${courses}" var="course">
                                    <option value="${course.course_id}">${course.name}</option>
                                </c:forEach>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label>วันเปิดรับสมัคร:</label>
                        </td>
                        <td><input name="startRegister" type="date" id="startRegister" class="datepicker" value="yyyy-MM-dd"/></td>
                    </tr>
                    <tr>
                        <td><label>วันปิดรับสมัคร:</label></td>
                        <td>
                            <input name="endRegister" type="date" id="endRegister" class="datepicker" value="yyyy-MM-dd"/>
                        </td>
                    </tr>
                    <tr>
                        <td><label>จำนวนรับสมัคร:</label></td>
                        <td>
                            <input name="quantity" id="quantity" type="number" autocomplete="off"/>
                        </td>
                    </tr>
                    <tr>
                        <td><label>วันที่เริ่มเรียน:</label></td>
                        <td>
                            <input name="startStudyDate" type="date" id="startStudyDate" class="datepicker" value="yyyy-MM-dd"/>
                        </td>
                    </tr>
                    <tr>
                        <td><label>วันที่สิ้นสุดการเรียน:</label></td>
                        <td>
                            <input name="endStudyDate" type="date" id="endStudyDate" class="datepicker" value="yyyy-MM-dd"/>
                        </td>
                    </tr>
                    <tr>
                        <td><label>เวลาในการเรียนเรียน:</label></td>
                        <td>
                            <input name="studyTime" id="studyTime" autocomplete="off"/>
                        </td>
                    </tr>
                    <tr>
                        <td><label>วันประกาศผลการสมัคร:</label></td>
                        <td>
                            <input name="applicationResult" type="date" id="applicationResult" class="datepicker" value="yyyy-MM-dd"/>
                        </td>
                    </tr>
                    <tr>
                        <td><label>รูปแบบการสอน:</label></td>
                        <td>
                            <select name="type_teach" id="type_teach">
                                <option value="">--กรุณาเลือกรูปแบบการสอน--</option>
                                <option value="แบบที่ 1 เรียนร่วมกับนักศึกษาในหลักสูตร">แบบที่ 1 เรียนร่วมกับนักศึกษาในหลักสูตร</option>
                                <option value="แบบที่ 2 แยกกลุ่มเรียนโดยเฉพาะ">แบบที่ 2 แยกกลุ่มเรียนโดยเฉพาะ</option>
                                <option value="จัดการเรียนการสอนร่วมกับทั้งแบบที่ 1 และแบบที่ 2">จัดการเรียนการสอนร่วมกับทั้งแบบที่ 1 และ แบบที่ 2</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td><label>ประเภทการเรียน:</label></td>
                        <td>
                            <select name="type_learn" id="type_learn" onchange="showHideFields()">
                                <option value="">--กรุณาเลือกประเภทการเรียน--</option>
                                <option value="เรียนออนไลน์">เรียนออนไลน์</option>
                                <option value="เรียนในสถานศึกษา">เรียนในสถานศึกษา</option>
                                <option value="เรียนทั้งออนไลน์และในสถานศึกษา">เรียนทั้งออนไลน์และในสถานศึกษา</option>
                            </select>
                        </td>
                    </tr>
                    <tr id="locationRow" style="display: none;">
                        <td><label>สถานที่:</label></td>
                        <td>
                            <input name="location" id="location" autocomplete="off"/>
                        </td>
                    </tr>

                    <tr id="moocRow" style="display: none;">
                        <td><label>link mooc (สำหรับเรียนออนไลน์):</label></td>
                        <td>
                            <input name="link_mooc" id="link_mooc" autocomplete="off"/>
                        </td>
                    </tr>
                    <tr>
                        <td><label>ลายเซ็น:</label></td>
                        <td>
                            <input type="file" name="signature" id="signature" autocomplete="off"/>
                        </td>
                    </tr>
                    <tr>
                        <td><label></label></td>
                        <td>
                            <input type="submit" name="confirmButton" value="บันทึก" class="save"/>
                                <%--                        <input type="button" value="ยกเลิก"onclick="window.location.href='list'; return false;"class="cancel-button"/>--%>
                            <input type="button" value="ย้อนกลับ"
                                   onclick="window.location.href='${pageContext.request.contextPath}/lecturer/${lecturer.username}/list_request_open_course'; return false;"
                                   class="cancel-button"/>
                        </td>
                    </tr>
                    </tbody>
                </table>
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
    function showHideFields() {
        var typeLearnSelect = document.getElementById("type_learn");
        var locationRow = document.getElementById("locationRow");
        var moocRow = document.getElementById("moocRow");

        var selectedOption = typeLearnSelect.value;

        if (selectedOption === "เรียนในสถานศึกษา") {
            locationRow.style.display = "table-row";
            moocRow.style.display = "none";
        } else if (selectedOption === "เรียนออนไลน์") {
            locationRow.style.display = "none";
            moocRow.style.display = "table-row";
        } else if (selectedOption === "เรียนทั้งออนไลน์และในสถานศึกษา") {
            locationRow.style.display = "table-row";
            moocRow.style.display = "table-row";
        } else {
            locationRow.style.display = "none";
            moocRow.style.display = "none";
        }
    }
</script>
<script>
    function confirmAction() {
        var result = confirm("คุณแน่ใจหรือไม่ว่าต้องการร้องขอหลักสูตรนี้?");
        if (result) {
            return true; // ถ้าผู้ใช้กด OK ให้ทำงานตามปกติ
        } else {
            return false; // ถ้าผู้ใช้กด Cancel ให้ยกเลิกการส่งฟอร์ม
        }
    }
</script>
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
    // รับค่า element ของวันเปิดรับสมัครและวันปิดรับสมัคร
    var startRegisterInput = document.getElementById("startRegister");
    var endRegisterInput = document.getElementById("endRegister");
    var startStudyDateInput = document.getElementById("startStudyDate");
    var endStudyDateInput = document.getElementById("endStudyDate");
    var applicationResultInput = document.getElementById("applicationResult");

    // รับวันที่ปัจจุบัน
    var currentDate = new Date();
    var currentDateString = currentDate.toISOString().slice(0, 10); // แปลงเป็นรูปแบบ yyyy-MM-dd

    // กำหนดค่าวันที่ปัจจุบันในฟิลด์ของวันเปิดรับสมัครและวันปิดรับสมัคร
    startRegisterInput.value = currentDateString;
    endRegisterInput.value = currentDateString;
    startStudyDateInput.value = currentDateString;
    endStudyDateInput.value = currentDateString;
    applicationResultInput.value = currentDateString;

    // กำหนดค่าสูงสุดให้เป็นวันปัจจุบัน
    startRegisterInput.min = currentDateString;
    endRegisterInput.min = currentDateString;
    startStudyDateInput.min = currentDateString;
    endStudyDateInput.min = currentDateString;
    applicationResultInput.min = currentDateString;
</script>

<script>
    // $(function() {
    //     $("#datepicker1, #datepicker2, #datepicker3, #datepicker4, #datepicker5").datepicker({
    //         dateFormat: "mm/dd/yy" // รูปแบบวันที่ที่ต้องการ
    //     });
    // });
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
