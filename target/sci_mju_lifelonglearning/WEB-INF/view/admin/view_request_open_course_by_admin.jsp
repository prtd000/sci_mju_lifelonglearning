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
    <title>RequestOpenCourse</title>
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
    <c:when test="${flag.equals('lecturer')}">
        <jsp:include page="/WEB-INF/view/lecturer/nav_lecturer.jsp"/>
    </c:when>
    <c:when test="${flag.equals('member')}">
        <jsp:include page="/WEB-INF/view/member/nav_member.jsp"/>
    </c:when>
    <c:when test="${flag.equals('null')}">
        <jsp:include page="/WEB-INF/view/layouts/nav.jsp"/>
    </c:when>
</c:choose>
<c:choose>
    <c:when test="${flag.equals('admin')}">
        <% assert admin != null; %>
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
                    <a href="${pageContext.request.contextPath}/" class="nav-item nav-link">หน้าหลัก</a>
                    <a href="#" class="nav-item nav-link">เกี่ยวกับคณะ</a>
                        <%--            <div class="nav-item dropdown">--%>
                        <%--                <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">หลักสูตรการอบรม</a>--%>
                    <a href="${pageContext.request.contextPath}/course/<%=admin.getUsername()%>/list_all_course" class="nav-item nav-link active">หลักสูตรทั้งหมด</a>
                    <a href="#" class="nav-item nav-link">ข่าวสารและกิจกรรม</a>
                    <a href="#" class="nav-item nav-link">Admin</a>
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
                <i>Detail</i>
                <br><br>
                <form id="approval-form" action="${pageContext.request.contextPath}/course/${admin_id}/view_request_open_course/${ROC_detail.request_id}/approve" method="POST">
                    <table>
                        <colgroup>
                            <col style="width: 160px;">
                            <col style="width: auto;">
                        </colgroup>
                        <tbody>
                        <tr>
                            <td><label></label></td>
                            <td><input type="button" value="ย้อนกลับ"
                                       onclick="window.location.href='${pageContext.request.contextPath}/course/<%=admin.getUsername()%>/list_all_course'; return false;"
                                       class="cancel-button"/>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label>รหัสการร้องขอ:</label>
                            </td>
                            <td>
                                <label>${ROC_detail.request_id}</label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label>หลักสูตร:</label>
                            </td>
                            <td>
                                <label>${ROC_detail.course.name}</label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label>สาขาวิชา:</label>
                            </td>
                            <td>
                                <label>${ROC_detail.course.major.name}</label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label>วันที่ร้องขอ:</label>
                            </td>
                                <%--                        <%date = dateFormat.parse("12/12/2002");%>--%>
                            <td>
                                <label>${ROC_detail.requestDate}</label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label>วันเปิดรับสมัคร:</label>
                            </td>
                            <td>
                                <label>${ROC_detail.startRegister}</label>
                            </td>
                        </tr>
                        <tr>
                            <td><label>วันปิดรับสมัคร:</label></td>
                            <td>
                                <label>${ROC_detail.endRegister}</label>
                            </td>
                        </tr>
                        <tr>
                            <td><label>จำนวนรับสมัคร:</label></td>
                            <td>
                                <label>${ROC_detail.quantity}</label>
                            </td>
                        </tr>
                        <tr>
                            <td><label>วันที่เริ่มเรียน:</label></td>
                            <td>
                                <label>${ROC_detail.startStudyDate}</label>
                            </td>
                        </tr>
                        <tr>
                            <td><label>วันที่สิ้นสุดการเรียน:</label></td>
                            <td>
                                <label>${ROC_detail.endStudyDate}</label>
                            </td>
                        </tr>
                        <tr>
                            <td><label>เวลาในการเรียนเรียน:</label></td>
                            <td>
                                <label>${ROC_detail.studyTime}</label>
                            </td>
                        </tr>
                        <tr>
                            <td><label>วันประกาศผลการสมัคร:</label></td>
                            <td>
                                <label>${ROC_detail.applicationResult}</label>
                            </td>
                        </tr>
                        <tr>
                            <td><label>ประเภทการเรียน:</label></td>
                            <td>
                                <label>${ROC_detail.type_learn}</label>
                            </td>
                        </tr>
                        <tr>
                            <td><label>รูปแบบการสอน:</label></td>
                            <td>
                                <label>${ROC_detail.type_teach}</label>
                            </td>
                        </tr>
                        <tr>
                            <td><label>สถานที่:</label></td>
                            <td>
                                <label>${ROC_detail.location}</label>
                            </td>
                        </tr>
                        <tr>
                            <td><label>สถานะการร้องขอ:</label></td>
                            <td>
                                <label>${ROC_detail.requestStatus}</label>
                            </td>
                        </tr>
                        <tr>
                            <td><label>ลายเซ็น:</label></td>
                            <td>
                                <label>${ROC_detail.signature}</label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label>อาจารย์ผู้สอน:</label>
                            </td>
                            <td>
                                <label>${ROC_detail.lecturer.firstName} ${ROC_detail.lecturer.lastName}</label>
                            </td>
                        </tr>
                        <tr>
                            <td><label></label></td>
                            <td>
                                <input type="button" name="statusResult" value="ยกเลิกคำร้องขอ"
                                       onclick="if(confirm('คุณแน่ใจหรือว่าต้องการยกเลิกคำร้องขอนี้?')) { window.location.href='${pageContext.request.contextPath}/course/note_cancel_request_open_course/${ROC_detail.request_id}'; }"
                                       class="cancel-button"/>
                                <input type="button" name="statusResult" value="ยืนยันคำร้องขอ" onclick="confirmSubmit();" />
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
    function confirmSubmit() {
        if (confirm('คุณแน่ใจหรือว่าต้องการดำเนินการตามคำร้องขอนี้?')) {
            document.getElementById('approval-form').submit();
        }
    }
</script>
</html>
