<%@ page import="java.text.SimpleDateFormat" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <title>ApproveRequestOpenCourse</title>
    <jsp:include page="/WEB-INF/view/layouts/detail-all-style.jsp"/>

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
                    <a href="${pageContext.request.contextPath}/" class="nav-item nav-link" style="font-size: 18px">หน้าหลัก</a>
                    <a href="#" class="nav-item nav-link" style="font-size: 18px">เกี่ยวกับคณะ</a>
                    <a href="${pageContext.request.contextPath}/search_course" class="nav-item nav-link" style="font-size: 18px">หลักสูตรการอบรม</a>
                    <a href="${pageContext.request.contextPath}/lecturer/<%=lecturer.getUsername()%>/list_request_open_course" class="nav-item nav-link active" style="font-size: 18px">รายการร้องขอ</a>
                    <a href="${pageContext.request.contextPath}/view_activity" class="nav-item nav-link" style="font-size: 18px">ข่าวสารและกิจกรรม</a>
                    <a href="#" class="nav-item nav-link" style="font-size: 18px">เกี่ยวกับเรา</a>
                    <a href="#" class="nav-item nav-link" style="font-size: 18px">อาจารย์ผู้รับผิดชอบหลักสูตร</a>
                    <a href="${pageContext.request.contextPath}/doLogout" class="nav-item nav-link" style="font-size: 18px">ออกจากระบบ</a>
                </div>
            </div>
        </nav>
        <!-- Navbar End -->
    <div id="header">
        <h1>${title}</h1>
    </div>

    <div class="block_position">
        <h1>
            ${RAOC_detail.course.name}
        </h1>
        <!--Detail-->
        <div>
            <br>
            <hr>
            <!---Sub_Detail-->
            <table>
                <tr>
                    <td class="t1">หลักสูตร</td>
                    <td class="t2">${RAOC_detail.course.name}</td>
                </tr>
                <tr>
                    <td class="t1">หมวดสาขาวิชา</td>
                    <td class="t2">${RAOC_detail.course.major.name}</td>
                </tr>
                <tr>
                    <td class="t1">เริ่มรับสมัคร</td>
                    <td class="t2">${RAOC_detail.startRegister}</td>
                </tr>
                <td class="t1">สิ้นสุดรับสมัคร</td>
                <td class="t2">${RAOC_detail.endRegister} ชั่วโมง</td>
                </tr>
                <tr>
                    <td class="t1">จำนวนรับสมัคร</td>
                    <td class="t2">${RAOC_detail.quantity}</td>
                </tr>
                <tr>
                    <td class="t1">วันประกาศผลการสมัคร</td>
                    <td class="t2">${RAOC_detail.applicationResult}</td>
                </tr>
                <tr>
                    <td class="t1">ค่าสมัครสมัคร</td>
                    <td class="t2">${RAOC_detail.course.fee}0 บาท</td>
                </tr>
                <tr>
                    <td class="t1">เริ่มเรียน</td>
                    <td class="t2">${RAOC_detail.startStudyDate}</td>
                </tr>
                <tr>
                    <td class="t1">ถึง</td>
                    <td class="t2">${RAOC_detail.endStudyDate}</td>
                </tr>
                <tr>
                    <td class="t1">รูปแบบการเรียน</td>
                    <td class="t2">${RAOC_detail.type_learn}</td>
                </tr>
                <tr>
                    <td class="t1">รูปแบบการสอน</td>
                    <td class="t2">${RAOC_detail.type_teach}</td>
                </tr>
                <tr>
                    <td class="t1">สถานที่เรียน</td>
                    <td class="t2">${RAOC_detail.location}</td>
                </tr>
            </table>
        </div>

    </div>
    <div class="block_position">
        <table>
            <tr>
                <td class="t1">จำนวนผู้สมัคร</td>
                <td class="t2">10 / ${RAOC_detail.quantity}</td>
            </tr>
            <tr>
                <td><label></label></td>
                <td><input type="button" value="ลบ"
                           onclick="if((confirm('คุณแน่ใจหรือว่าต้องการลบการร้องขอนี้?'))) { window.location.href='${pageContext.request.contextPath}/lecturer/${lec_id}/${RAOC_detail.request_id}/delete'; return false; }"
                           class="cancel-button"/>
                    <input type="button" value="ย้อนกลับ"
                           onclick="window.location.href='${pageContext.request.contextPath}/lecturer/${lec_id}/list_request_open_course'; return false;"
                           class="cancel-button"/>
                    <input type="button" value="เพิ่มข่าวสารหลักสูตร"
                           onclick="window.location.href='${pageContext.request.contextPath}/lecturer/${RAOC_detail.request_id}/add_course_activity'; return false;"
                           class="cancel-button"/>
                </td>
            </tr>
        </table>
        <h3>ข่าวสารและกิจกรรม</h3>
        <table class="table table-striped table-hover">
            <tr style="color: black">
                <td class="td_request">รายการข่าว</td>
                <td class="td_edit" align="center">วันที่ออกข่าว</td>
                <td class="td_cancel" align="center"></td>
                <td class="td_cancel" align="center"></td>
            </tr>
            <c:forEach var="list" items="${course_activities}">
                <tr>
                    <td>${list.name}</td>
                    <td>${list.date}</td>
                    <td>
                        <a href="${pageContext.request.contextPath}/lecturer/${lec_id}/${list.ac_id}/view_course_activity_page/${roc_id}"><button>ดูรายละเอียด</button></a>
                    </td>
                    <td>
                        <input type="button" value="ยกเลิก"
                               onclick="if((confirm('คุณแน่ใจหรือว่าต้องการลบข่าวสารนี้?'))) { window.location.href='${pageContext.request.contextPath}/lecturer/${lec_id}/${list.ac_id}/delete'; return false; }"
                               class="cancel-button"/>
                    </td>
                </tr>
            </c:forEach>
        </table>
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
    $(function() {
        $("#datepicker1, #datepicker2, #datepicker3, #datepicker4, #datepicker5").datepicker({
            dateFormat: "mm/dd/yy" // รูปแบบวันที่ที่ต้องการ
        });
    });
</script>
</html>
