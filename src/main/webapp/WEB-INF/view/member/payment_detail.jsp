<%@ page import="lifelong.model.Admin" %>
<%@ page import="lifelong.model.Member" %>
<%@ page import="lifelong.model.Lecturer" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%--
  Created by IntelliJ IDEA.
  User: asus
  Date: 9/8/2566
  Time: 10:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Payment Detail</title>
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
    <br><br><br>
    <h1>การชำระเงิน</h1>
    <hr>
    <h4>${payment.register.requestOpenCourse.course.name}</h4>
    <p>${payment.register.requestOpenCourse.course.major.name}</p>
    <hr>

    <h4>โอนไปยัง</h4>
    <table>
        <tr>
            <td style="width: 200px;">ธนาคารปลายทาง</td>
            <td style="width: 150px;">กรุงไทย</td>
        </tr>
        <tr>
            <td>เลขที่บัญชี</td>
            <td>679-5-60403-1</td>
        </tr>
    </table>
    <hr>
    <table>
        <tr>
            <td style="width: 200px;">รวมที่ต้องชำระเงิน</td>
            <td style="width: 100px;">${payment.register.requestOpenCourse.course.fee}</td>
            <td style="width: 50px;">บาท</td>
        </tr>
        <tr>
            <td>ค่าธรรมเนียม</td>
            <td>0</td>
            <td>บาท</td>
        </tr>
        <tr>
            <td>ยอดรวมชำระเงินทั้งหมด</td>
            <td>${payment.register.requestOpenCourse.course.fee}</td>
            <td>บาท</td>
        </tr>
        <tr>
            <td></td>
            <td colspan="2"><a href="${pageContext.request.contextPath}/member/${payment.register.member.username}/payment_fill_detail/${payment.invoice_id}"><button style="width: 100%;">ต่อไป</button></a></td>
        </tr>
    </table>
</center>
<jsp:include page="/WEB-INF/view/layouts/footer.jsp"/>
</body>
</html>
