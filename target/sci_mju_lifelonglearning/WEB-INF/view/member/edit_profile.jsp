<%--
  Created by IntelliJ IDEA.
  User: asus
  Date: 2/8/2566
  Time: 15:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <jsp:include page="/WEB-INF/view/layouts/detail-all-style.jsp"/>

</head>
<body>
<jsp:include page="/WEB-INF/view/layouts/nav.jsp"/>
<h1>แก้ไขข้อมูลส่วนตัว</h1>
<hr>
<center>
    <form action="${pageContext.request.contextPath}/member/${member.username}/update" method="post">
        <table>
            <tr>
                <td><label>ชื่อ</label></td>
                <td><label>นามสกุล</label></td>
            </tr>
            <tr>
                <td><input type="text" value="${member.firstName}" name="firstName"></td>
                <td><input type="text" value="${member.lastName}" name="lastName"></td>
            </tr>
            <tr>
                <td><label>วัน/เดือน/ปี</label></td>
                <td><label>เบอร์โทร</label></td>
            </tr>
            <tr>
                <td><input type="date" value="${member.birthday}" name="birthday" style="width: 100%;"></td>
                <td><input type="text" value="${member.tel}" name="tel"></td>
            </tr>
            <tr>
                <td><label>อีเมล</label></td>
            </tr>
            <tr>
                <td colspan="2"><input type="text" value="${member.email}" style="width: 100%" name="email"></td>
            </tr>
            <tr>
                <td><label>ระดับการศึกษา</label></td>
            </tr>
            <tr>
                <td colspan="2">
                    <select id="education" name="education">
                        <option value="ระดับมัธยมศึกษา">ระดับมัธยมศึกษา</option>
                        <option value="ระดับอาชีวศึกษา">ระดับอาชีวศึกษา</option>
                        <option value="ระดับอุดมศึกษา">ระดับอุดมศึกษา</option>
                        <option value="ปริญญาตรี">ปริญญาตรี</option>
                        <option value="ปริญญาโท">ปริญญาโท</option>
                        <option value="ปริญญาเอก">ปริญญาเอก</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td>
                    <input type="submit" value="บันทึก">
                    <button><a href="${pageContext.request.contextPath}/member/${member.username}/change_password">เปลี่ยนรหัสผ่าน</a></button>
                </td>
            </tr>
        </table>
    </form>

</center>

<jsp:include page="/WEB-INF/view/layouts/footer.jsp"/>


<script>
    var index = 0;
    var edu = `${member.education}`;
    console.log("education : " + edu);
    if (edu == "ระดับมัธยมศึกษา") {
        index = 0;
    } else if (edu == "ระดับอาชีวศึกษา") {
        index = 1;
    } else if (edu == "ระดับอุดมศึกษา") {
        index = 2;
    } else if (edu == "ปริญญาตรี") {
        index = 3;
    } else if (edu == "ปริญญาโท") {
        index = 4;
    } else if (edu == "ปริญญาเอก") {
        index = 5;
    }
    window.onload = function () {
        document.getElementById("education").selectedIndex = index;
    };
</script>
</body>
</html>
