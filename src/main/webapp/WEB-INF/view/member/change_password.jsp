<%@ page import="lifelong.model.Admin" %>
<%@ page import="lifelong.model.Member" %>
<%@ page import="lifelong.model.Lecturer" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%--
  Created by IntelliJ IDEA.
  User: asus
  Date: 8/8/2566
  Time: 15:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Change Password</title>
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
<h1>เปลี่ยนรหัสผ่าน</h1>
<hr>
<center>
    <form action="${pageContext.request.contextPath}/member/${member.username}/update_password" method="post">
        <table>
            <tr>
                <td>รหัสผ่านใหม่</td>
                <td style="width: 30px;"></td>
                <td><input type="password" id="newPassword" name="newPassword" placeholder="รหัสผ่านใหม่"></td>
            </tr>
            <tr>
                <td>ยืนยันรหัสผ่านใหม่</td>
                <td></td>
                <td><input type="password" id="confirmPassword" name="confirmPassword" placeholder="ยืนยันรหัสผ่านใหม่"
                           onkeyup="checkPasswordMatch()"></td>
            </tr>
            <tr>
                <td></td>
                <td></td>
                <td><p id="passwordMatchMessage">กรุณากรอกรหัสผ่านให้ตรงกัน</p></td>
            </tr>
            <tr>
                <td></td>
                <td></td>
                <td><input type="submit" value="บันทึก"></td>
            </tr>

        </table>
    </form>
</center>

<jsp:include page="/WEB-INF/view/layouts/footer.jsp"/>

<script>

    const newPasswordInput = document.getElementById("newPassword");
    const confirmPasswordInput = document.getElementById("confirmPassword");
    const passwordMatchMessage = document.getElementById("passwordMatchMessage");

    function checkPasswordMatch() {
        const newPassword = newPasswordInput.value;
        const confirmPassword = confirmPasswordInput.value;

        if (newPassword === confirmPassword) {
            passwordMatchMessage.textContent = "Passwords match.";
            passwordMatchMessage.style.color = "green";
        } else {
            passwordMatchMessage.textContent = "Passwords do not match.";
            passwordMatchMessage.style.color = "red";

        }
    }
</script>
</body>
</html>
