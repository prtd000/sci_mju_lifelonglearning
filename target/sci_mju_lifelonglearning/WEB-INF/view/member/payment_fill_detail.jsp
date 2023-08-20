<%@ page import="lifelong.model.Admin" %>
<%@ page import="lifelong.model.Member" %>
<%@ page import="lifelong.model.Lecturer" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%--
  Created by IntelliJ IDEA.
  User: asus
  Date: 9/8/2566
  Time: 11:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <jsp:include page="/WEB-INF/view/layouts/detail-all-style.jsp"/>
</head>
<body>
<!-- Navbar -->
<%
    Admin admin = (Admin) session.getAttribute("admin");
    Member member = (Member) session.getAttribute("member");
    Lecturer lecturer = (Lecturer) session.getAttribute("lecturer");

    String flag = "";
    if (admin != null) {
        flag = "admin";
    }else if (lecturer != null) {
        flag = "lecturer";
    } else if (member != null) {
        flag = "member";
    }else {
        flag = "null";
    }
%>

<c:set var="flag" value="<%= flag %>"></c:set>
<c:choose>
    <c:when test="${flag.equals('admin')}">
        <jsp:include page="/WEB-INF/view/admin/nav_admin.jsp"/>
    </c:when>
    <c:when test="${flag.equals('lecturer')}">
        <jsp:include page="/WEB-INF/view/lecturer/nav_lecturer.jsp"/>
    </c:when>
    <c:when test="${flag.equals('member')}">
        <jsp:include page="/WEB-INF/view/member/nav_member.jsp"/>
    </c:when>
    <c:otherwise>
        <jsp:include page="/WEB-INF/view/layouts/nav.jsp"/>
    </c:otherwise>
</c:choose>
<center>
    <br><br>
    <h1>ยืนยันการชำระเงิน</h1>
    <hr>
    <table>
        <tr>
            <td style="width: 200px">ยอดการชำระเงินทั้งหมด</td>
            <td>${payment.register.requestOpenCourse.course.fee}</td>
            <td>บาท</td>
        </tr>
    </table>
    <hr>
    <h5>อัพโหลดหลักฐานการชำระเงิน</h5>
    <form action="${pageContext.request.contextPath}/member/${payment.register.member.username}/payment_fill_detail/${payment.invoice_id}/save" method="post">

        <table border="1">
            <tr>
                <td style="width: 315px"><p style="color: red;">*ภาพตัวอย่าง*</p></td>
                <td><input type="file" name="slip"></td>
            </tr>
        </table>
        <hr>
        <table>
            <tr>
                <td style="width: 450px;">วันที่โอนตามหลักฐานการชำระเงิน</td>
                <td><input type="date" name="receipt_paydate"></td>
            </tr>
            <tr>
                <td>เวลาที่โอนตามหลักฐานการชำระเงิน</td>
                <td><input type="time" name="receipt_paytime"></td>
            </tr>
            <tr>
                <td>โอนจากธนาคาร</td>
                <td>
                    <select id="receipt_banking" name="receipt_banking">
                        <option value="กรุงไทย">กรุงไทย</option>
                        <option value="ไทยพาณิชย์">ไทยพาณิชย์ (SCB)</option>
                        <option value="กสิกรไทย">กสิกรไทย (KBank)</option>
                        <option value="ออมสิน">ออมสิน</option>
                        <option value="กรุงศรี">กรุงศรี</option>
                        <option value="กรุงเทพ">กรุงเทพ</option>
                        <option value="ทีทีบี">ทีทีบี</option>
                        <option value="ธ.ก.ส">ธ.ก.ส</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td>จำนวนเงินที่ถูกโอน (฿)</td>
                <td><input type="number" name="receipt_total"></td>
            </tr>
            <tr>
                <td>เงินโอนจากบัญชีธนาคารเลขที่ (4 หลักสุดท้าย)</td>
                <td><input type="number" name="last_four_digits"></td>
            </tr>
            <tr>
                <td colspan="2">
                    <input type="submit" style="width: 100%;" value="ยืนยันข้อมูลการชำระเงิน">
                </td>
            </tr>
        </table>
    </form>
</center>

<jsp:include page="/WEB-INF/view/layouts/footer.jsp"/>
</body>
</html>
