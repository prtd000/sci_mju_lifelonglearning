<%@ page import="lifelong.model.Lecturer" %>
<%@ page import="lifelong.model.Admin" %>
<%@ page import="lifelong.model.Member" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 8/9/2023
  Time: 4:24 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>ข้อมูลการชำระเงิน</title>
    <%--    <link href="${pageContext.request.contextPath}/assets/css/list_open_course_style.css" rel="stylesheet">--%>
    <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/list_all_course.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/admin/list_approve_member.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/admin/style_addcourse.css" rel="stylesheet">
    <style>
        body{
            font-family: 'Prompt', sans-serif;
        }
        h1{
            font-family: 'Prompt', sans-serif;
            font-weight: 700 !important;
        }
        /*.pay_detail{*/
        /*    display: inline-block;*/
        /*}*/
        .main_container{
            width: 60%;
        }
    </style>
    <jsp:include page="/WEB-INF/view/layouts/detail-all-style.jsp"/>
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
                            <a href="${pageContext.request.contextPath}/" class="nav-item nav-link" style="font-size: 17px">หน้าหลัก</a>
                            <a href="#" class="nav-item nav-link" style="font-size: 18px">เกี่ยวกับคณะ</a>
                            <a href="${pageContext.request.contextPath}/course/<%=admin.getUsername()%>/add_course" class="nav-item nav-link" style="font-size: 17px">เพิ่มหลักสูตร</a>
                            <a href="${pageContext.request.contextPath}/course/<%=admin.getUsername()%>/list_all_course" class="nav-item nav-link active" style="font-size: 17px">หลักสูตรทั้งหมด</a>
                            <a href="${pageContext.request.contextPath}/course/<%=admin.getUsername()%>/list_request_open_course" class="nav-item nav-link" style="font-size: 17px">รายการร้องขอ</a>
                            <a href="${pageContext.request.contextPath}/course/public/add_activity" class="nav-item nav-link" style="font-size: 17px">เพิ่มข่าวสารทั่วไป</a>
                            <a href="${pageContext.request.contextPath}/course/public/list_activity" class="nav-item nav-link" style="font-size: 17px">ข่าวสารและกิจกรรม</a>
                            <a href="#" class="nav-item nav-link" style="font-size: 17px">ผู้ดูแลระบบ</a>
                            <a href="${pageContext.request.contextPath}/doLogout" class="nav-item nav-link" style="font-size: 17px">ออกจากระบบ</a>
                        </div>
                    </div>
        </nav>
        <!-- Navbar End -->
        <div align="center">
            <div class="main_container" style="margin-top: 10px;">
                <div class="course_div" style="width: 100%">
                    <br>
                    <c:if test="${payment != null}">
                        <form id="approval-form" style="width: 90%" action="${pageContext.request.contextPath}/course/${request_id}/<%=admin.getUsername()%>/view_payment_detail/${payment.invoice.invoice_id}/approve" method="POST" onsubmit="return confirmAction();">
                            <div align="left">
                                <h5><b>ตรวจสอบการชำระเงิน</b></h5>
                                <h4>${payment.invoice.register.requestOpenCourse.course.name}</h4>
                                <p>${payment.invoice.register.requestOpenCourse.course.major.name}</p>
                                <hr>
                            </div>
                            <div align="center">
                                <div class="pay_detail" style="margin-top: 0">
                                    <table>
                                        <tr>
                                            <td><h5>หลักฐานการชำระเงิน</h5></td>
                                            <td></td>
                                            <td rowspan="10"><img src="${pageContext.request.contextPath}/uploads/make_payment/slip/${payment.slip}" height="350px" style="margin-left: 20px"></td>
                                        </tr>
                                        <tr>
                                            <td colspan="2"><hr></td>
                                        </tr>
                                        <tr>
                                            <td>${payment.invoice.register.member.idcard}</td>
                                            <td>${payment.invoice.register.member.firstName} ${payment.invoice.register.member.lastName}</td>
                                        </tr>
                                        <tr>
                                            <td>ยอดชำระเงินทั้งหมด </td>
                                            <td>${payment.invoice.register.requestOpenCourse.course.fee}0 บาท</td>
                                        </tr>
                                        <tr>
                                            <td colspan="2"><hr></td>
                                        </tr>
                                        <tr>
                                            <td>วันที่โอนตามหลักฐานการชำระเงิน</td>
                                            <td><b>${payment.pay_date}</b></td>
                                        </tr>
                                        <tr>
                                            <td>เวลาที่โอนตามหลักฐานการชำระเงิน</td>
                                            <td><b>${payment.pay_time}</b></td>
                                        </tr>
                                        <tr>
                                            <td>โอนจากธนาคาร</td>
                                            <td><b>${payment.banking}</b></td>
                                        </tr>
                                        <tr>
                                            <td>จำนวนเงินที่ถูกโอน (ฺ฿)</td>
                                            <td><b>${payment.invoice.register.requestOpenCourse.course.fee}0 บาท</b></td>
                                        </tr>
                                        <tr>
                                            <td>เงินโอนจากบัญชีธนาคารเลขที่ (4 หลักสุดท้าย)</td>
                                            <td><b>${payment.last_four_digits}</b></td>
                                        </tr>
                                    </table>
                                    <hr>
                                </div>
                            </div>
                            <input type="submit" name="approveResult" value="ยกเลิกการสมัคร" class="cancel-button" style="width: 47%"/>
                            <input type="submit" name="approveResult" value="ยืนยันการสมัคร" class="button-5" style="width: 47%"/>

                        </form>
                    </c:if>
                </div>
                <c:if test="${payment == null}">
                    <h1>ยังไม่มีการชำระเงิน</h1>
                </c:if>
            </div>
        </div>
<%--        <td align="center"><input type="button" value="ย้อนกลับ"--%>
<%--                                  onclick="window.location.href='${pageContext.request.contextPath}/course/${request_id}/list_member_to_course'; return false;"/></td>--%>
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
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    // function confirmSubmit(approveResult) {
    //     if (confirm('คุณแน่ใจหรือว่าต้องการ ' + approveResult + ' ?')) {
    //         document.getElementById('approval-form').submit();
    //     }
    // }
    //
    // function cancelSubmit(approveResult) {
    //     if (confirm('คุณแน่ใจหรือว่าต้องการ ' + approveResult + ' ?')) {
    //         document.getElementById('approval-form').submit();
    //     }
    // }
    function confirmAction() {
        var result = confirm("คุณแน่ใจหรือไม่ว่าต้องการดำเนินการนี้?");
        if (result) {
            return true; // ถ้าผู้ใช้กด OK ให้ทำงานตามปกติ
        } else {
            return false; // ถ้าผู้ใช้กด Cancel ให้ยกเลิกการส่งฟอร์ม
        }
    }
</script>
</html>
