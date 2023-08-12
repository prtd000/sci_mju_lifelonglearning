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
    <title>Title</title>
    <%--    <link href="${pageContext.request.contextPath}/assets/css/list_open_course_style.css" rel="stylesheet">--%>
    <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/list_all_course.css" rel="stylesheet">
    <style>
        h1{
            font-family: 'Prompt', sans-serif;
            font-weight: 700 !important;
        }
    </style>
    <jsp:include page="/WEB-INF/view/layouts/detail-all-style.jsp"/>
</head>
<body>
<jsp:include page="/WEB-INF/view/layouts/nav.jsp"/>

<h3>ตรวจสอบการชำระเงิน</h3>
<form action="${pageContext.request.contextPath}/course/${request_id}/view_payment_detail/${payment.invoice.invoice_id}/approve" method="POST">
<c:if test="${payment != null}">
    <h4>${payment.invoice.register.requestOpenCourse.course.name}</h4>
    <p>${payment.invoice.register.requestOpenCourse.course.major.name}</p>
    <hr>
    <table>
        <tr>
            <td colspan="2">หลักฐานการชำระเงิน</td>
            <td rowspan="3">${payment.slip}</td>
        </tr>
        <tr>
            <td>${payment.invoice.register.member.idcard}</td>
            <td>${payment.invoice.register.member.firstName} ${payment.invoice.register.member.lastName}</td>
        </tr>
        <tr>
            <td>ยอดชำระเงินทั้งหมด</td>
            <td>${payment.invoice.register.requestOpenCourse.course.fee}0 บาท</td>
        </tr>
    </table>
    <hr>
    <table>
        <tr>
            <td>วันที่โอนตามหลักฐานการชำระเงิน</td>
            <td>${payment.pay_date}</td>
        </tr>
        <tr>
            <td>เวลาที่โอนตามหลักฐานการชำระเงิน</td>
            <td>${payment.pay_time}</td>
        </tr>
        <tr>
            <td>โอนจากธนาคาร</td>
            <td>${payment.banking}</td>
        </tr>
        <tr>
            <td>จำนวนเงินที่ถูกโอน (ฺ฿)</td>
            <td>${payment.total}</td>
        </tr>
        <tr>
            <td>เงินโอนจากบัญชีธนาคารเลขที่ (4 หลักสุดท้าย)</td>
            <td>${payment.last_four_digits}</td>
        </tr>

    </table>
</c:if>
<c:if test="${payment == null}">
    <h1>ยังไม่มีการชำระเงิน</h1>
</c:if>
<td align="center"><input type="button" value="ย้อนกลับ"
                          onclick="window.location.href='${pageContext.request.contextPath}/course/${request_id}/list_member_to_course'; return false;"/></td>
<td align="center"><input type="button" value="ยกเลิก"/></td>
<td align="center"><input type="submit" value="ยืนยันการสมัคร"/></td>
</form>
</body>
</html>
