<%--
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
<jsp:include page="/WEB-INF/view/layouts/nav.jsp"/>
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
