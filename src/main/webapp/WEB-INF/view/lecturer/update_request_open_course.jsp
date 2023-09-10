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
        <c:if test="${request_open_course != null}">
            <i>กรอกข้อมูลในฟอร์ม. เครื.องหมายดอกจัน(*) หมายถึงห้ามว่าง</i>
            <br><br>
        <form onsubmit="return confirmAction();" action="${pageContext.request.contextPath}/lecturer/${lec_id}/${request_open_course.request_id}/update" method="POST" enctype="multipart/form-data">
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
                        <input name="quantity" id="quantity" type="number" autocomplete="off" value="${request_open_course.quantity}"/>
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
                        <select name="type_learn" id="type_learn">
                            <option value="">--กรุณาเลือกประเภทการเรียน--</option>
                            <option value="ชั้นเรียน 100%" ${request_open_course.type_learn == 'ชั้นเรียน 100%'?'selected':''}>ชั้นเรียน 100%</option>
                            <option value="ออนไลน์ 100%" ${request_open_course.type_learn == 'ออนไลน์ 100%'?'selected':''}>ออนไลน์ 100%</option>
                            <option value="แบบผสมชั้นเรียนและออนไลน์" ${request_open_course.type_learn == 'แบบผสมชั้นเรียนและออนไลน์'?'selected':''}>แบบผสมชั้นเรียนและออนไลน์</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td><label>รูปแบบการสอน:</label></td>
                    <td>
                        <select name="type_teach" id="type_teach">
                            <option value="">--กรุณาเลือกรูปแบบการสอน--</option>
                            <option value="แบบที่ 1 เรียนร่วมกับนักศึกษาในหลักสูตร" ${request_open_course.type_teach == 'แบบที่ 1 เรียนร่วมกับนักศึกษาในหลักสูตร'?'selected':''}>แบบที่ 1 เรียนร่วมกับนักศึกษาในหลักสูตร</option>
                            <option value="แบบที่ 2 แยกกลุ่มเรียนโดยเฉพาะ" ${request_open_course.type_teach == 'แบบที่ 2 แยกกลุ่มเรียนโดยเฉพาะ'?'selected':''}>แบบที่ 2 แยกกลุ่มเรียนโดยเฉพาะ</option>
                            <option value="จัดการเรียนการสอนร่วมกับทั้งแบบที่ 1 และแบบที่ 2" ${request_open_course.type_teach == 'จัดการเรียนการสอนร่วมกับทั้งแบบที่ 1 และแบบที่ 2'?'selected':''}>จัดการเรียนการสอนร่วมกับทั้งแบบที่ 1 และ แบบที่ 2</option>
                        </select>
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
                        <input name="signature" id="signature" type="file" autocomplete="off"/>
                        <c:if test="${not empty request_open_course.signature}">
                            <input type="hidden" name="original_signature" value="${request_open_course.signature}" />
                            <a href="${request_open_course.signature}" target="_blank">${request_open_course.signature}</a>
                        </c:if>
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
                               onclick="window.location.href='${pageContext.request.contextPath}/lecturer/<%=lecturer.getUsername()%>/list_request_open_course'; return false;"
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
<script>
    function confirmAction() {
        var result = confirm("คุณแน่ใจหรือไม่ว่าต้องกาแก้ไขการร้องขอนี้?");
        if (result) {
            return true; // ถ้าผู้ใช้กด OK ให้ทำงานตามปกติ
        } else {
            return false; // ถ้าผู้ใช้กด Cancel ให้ยกเลิกการส่งฟอร์ม
        }
    }
</script>
</html>
