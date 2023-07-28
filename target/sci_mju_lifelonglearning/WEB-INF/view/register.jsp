<%--
  Created by IntelliJ IDEA.
  User: asus
  Date: 25/7/2566
  Time: 15:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Register</title>
</head>
<style>
    /**********Register First Step**********/
    .block_form1 {
        padding: 30px;
        width: 680px;
        border-radius: 25px;
        box-shadow: 2px 2px 5px 1px #626262;
    }

    .regis_block_step1 {
        margin-left: 427px;
        margin-top: 52px;
    }

    .inp_idcard {
        width: 100%;
    }

    .btn_nextstep1 {
        width: 114px;
        height: 41px;
        border-radius: 14px;
        border: 1px solid;
        background-color: #ff7100;
        color: white;
        float: right;
        transition: 0.5s;
    }

    .btn_nextstep1:hover {
        background-color: #c5c5c5;
        color: rgb(0, 0, 0);
        transition: 0.5s;
    }

    div[class='regis_block_step1'] form table tr {
        height: 50px;
    }

    div[class='regis_block_step1'] form table tr td {
        font-weight: bold;
        font-size: 20px;
        color: black;
    }

    div[class='regis_block_step1'] form table tr td input {
        border-radius: 8px;
        border: 1px solid;
        height: 36px;
        padding: 10px;
    }

    /**********Register Second Step**********/

    .regis_block_step2 {
        margin-left: 427px;
        margin-top: 52px;
    }

    .block_form2 {
        padding: 30px;
        width: 680px;
        border-radius: 25px;
        box-shadow: 2px 2px 5px 1px #626262;
    }

    div[class='regis_block_step2'] form table tr td input {
        border-radius: 8px;
        border: 1px solid;
        height: 36px;
        padding: 10px;
    }

    div[class='regis_block_step2'] form table tr {
        height: 50px;
    }

    div[class='regis_block_step2'] form table tr td {
        font-weight: bold;
        font-size: 20px;
        color: black;
    }

    div[class='regis_block_step2'] form table tr td input[type='text'] {
        border-radius: 8px;
        border: 1px solid;
        height: 36px;
        padding: 10px;
        width: 100%;
    }

    div[class='regis_block_step2'] form table tr td input[type='radio'] {
        width: 26px;
        margin-left: 68px;
        cursor: pointer;
    }

    .label_radio {
        position: absolute;
        margin-top: 5px;
        margin-left: 12px;
    }

    .hidden-form {
        display: none;
    }
</style>
<body>


<!-----------------------แบบที่ 1---------------------------------->
<select id="formSelector">
    <option value="form1">Form 1</option>
    <option value="form2">Form 2</option>
    <option value="form3">Form 3</option>
</select>

<form action="${pageContext.request.contextPath}/register_member/save" method="POST">
    <!-- Form 1 -->
    <div id="form1" style="display: block;" class="block_form1">
        <h2>Form 1</h2>
        <table>
            <tr>
                <td>บัตรประชาชน</td>
                <td></td>
            </tr>
            <tr>
                <td colspan="3"><input name="idcard" id="idcard" type="text" class="inp_idcard"/></td>
            </tr>
            <tr>
                <td>ชื่อ</td>
                <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
                <td>นามสกุล</td>
            </tr>
            <tr>
                <td><input name="firstName" id="firstName" type="text" name="firstname"/></td>
                <td></td>
                <td><input name="lastName" id="lastName" type="text" name="lastname"/></td>
            </tr>
        </table>
    </div>

    <!-- Form 2 -->
    <div id="form2" style="display: none;" class="block_form2">
        <h2>Form 2</h2>
        <table style="width: 100%;">
            <tr>
                <td>วันเดือนปีเกิด</td>
                <td></td>
            </tr>
            <tr>
                <td colspan="2"><input name="birthday" id="birthday" type="date" style="width: 50%;"/></td>

            </tr>
            <tr>
                <td>
                    <input type="radio" name="gender"  value="Male">
                    <label>ชาย</label>
                    <input type="radio" name="gender" value="Female">
                    <label>หญิง</label>
                </td>
            </tr>
            <tr>
                <td>เบอร์โทร</td>
            </tr>
            <tr>
                <td colspan="2"><input name="tel" id="tel" type="text" name="tel"/></td>
            </tr>
            <tr>
                <td>อีเมล</td>
            </tr>
            <tr>
                <td colspan="3"><input name="email" id="email" type="text" name="email"/></td>
            </tr>
            <tr>
                <td>การศึกษา</td>
            </tr>
            <tr>
                <td colspan="3">
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
        </table>
    </div>

    <!-- Form 3 -->
    <div id="form3" style="display: none;" class="block_form2">
        <h2>Form 3</h2>
        <table style="width: 100%;">
            <tr>
                <td>ชื่อ</td>
            </tr>
            <tr>
                <td><input name="username" id="username" type="text" placeholder="Username"/></td>
            </tr>
            <tr>
                <td>นามสกุล</td>
            </tr>
            <tr>
                <td><input name="password" id="password" type="password" placeholder="Password"/></td>
            </tr>
            <tr>
                <td>
                    <input type="submit" value="สมัครสมาชิก">
                </td>
            </tr>
        </table>
    </div>
</form>

<script>
    const formSelector = document.getElementById("formSelector");

    formSelector.addEventListener("change", function () {
        const selectedFormId = formSelector.value;

        // Hide all forms
        const allForms = document.querySelectorAll("div");
        allForms.forEach(form => form.style.display = "none");

        // Show the selected form
        const selectedForm = document.getElementById(selectedFormId);
        selectedForm.style.display = "block";
    });
</script>

<!-----------------------แบบที่ 2---------------------------------->
<%--<h1>Form Switch Example</h1>--%>

<%--<select id="formSelector">--%>
<%--    <option value="form1">Form 1</option>--%>
<%--    <option value="form2">Form 2</option>--%>
<%--    <option value="form3">Form 3</option>--%>
<%--</select>--%>

<%--<form:form action="${pageContext.request.contextPath}/member/register_member/save" modelAttribute="member" method="post">--%>
<%--    <!-- Form 1 -->--%>
<%--    <div id="form1" style="display: block;" class="block_form1">--%>
<%--        <h2>Form 1</h2>--%>
<%--        <table>--%>
<%--            <tr>--%>
<%--                <td>บัตรประชาชน</td>--%>
<%--                <td></td>--%>
<%--            </tr>--%>
<%--            <tr>--%>
<%--                <td colspan="3"><form:input path="idcard" type="text" class="inp_idcard"/></td>--%>
<%--            </tr>--%>
<%--            <tr>--%>
<%--                <td>ชื่อ</td>--%>
<%--                <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>--%>
<%--                <td>นามสกุล</td>--%>
<%--            </tr>--%>
<%--            <tr>--%>
<%--                <td><form:input path="firstName" type="text" name="firstname"/></td>--%>
<%--                <td></td>--%>
<%--                <td><form:input path="lastName" type="text" name="lastname"/></td>--%>
<%--            </tr>--%>
<%--        </table>--%>
<%--    </div>--%>

<%--    <!-- Form 2 -->--%>
<%--    <div id="form2" style="display: none;" class="block_form2">--%>
<%--        <h2>Form 2</h2>--%>
<%--        <table style="width: 100%;">--%>
<%--            <tr>--%>
<%--                <td>วันเดือนปีเกิด</td>--%>
<%--                <td></td>--%>
<%--            </tr>--%>
<%--            <tr>--%>
<%--                <td colspan="2"><form:input path="birthday" type="date" style="width: 100%;"/></td>--%>
<%--            </tr>--%>
<%--            <tr>--%>
<%--                <td>--%>
<%--                    <form:radiobutton path="gender" value="Male"/>--%>
<%--                    <label>ชาย</label>--%>
<%--                    <form:radiobutton path="gender" value="Female"/>--%>
<%--                    <label>หญิง</label>--%>
<%--                </td>--%>

<%--            </tr>--%>
<%--            <tr>--%>
<%--                <td>เบอร์โทร</td>--%>
<%--            </tr>--%>
<%--            <tr>--%>
<%--                <td colspan="2"><form:input path="tel" type="text" name="tel"/></td>--%>
<%--            </tr>--%>
<%--            <tr>--%>
<%--                <td>อีเมล</td>--%>
<%--            </tr>--%>
<%--            <tr>--%>
<%--                <td colspan="3"><form:input path="email" type="text" name="email"/></td>--%>
<%--            </tr>--%>
<%--            <tr>--%>
<%--                <td>การศึกษา</td>--%>
<%--            </tr>--%>
<%--            <tr>--%>
<%--                <td colspan="3"><form:input path="education" type="text" name="education"/></td>--%>
<%--            </tr>--%>
<%--        </table>--%>
<%--    </div>--%>

<%--    <!-- Form 3 -->--%>
<%--    <div id="form3" style="display: none;" class="block_form2">--%>
<%--        <h2>Form 3</h2>--%>
<%--        <table style="width: 100%;">--%>
<%--            <tr>--%>
<%--                <td>ชื่อ</td>--%>
<%--            </tr>--%>
<%--            <tr>--%>
<%--                <td><form:input path="username" type="text" placeholder="Username"/></td>--%>
<%--            </tr>--%>
<%--            <tr>--%>
<%--                <td>นามสกุล</td>--%>
<%--            </tr>--%>
<%--            <tr>--%>
<%--                <td><form:input path="password" type="password" placeholder="Password"/></td>--%>
<%--            </tr>--%>
<%--            <tr>--%>
<%--                <td>--%>
<%--                    <input type="submit" value="สมัครสมาชิก">--%>
<%--                </td>--%>
<%--            </tr>--%>
<%--        </table>--%>
<%--    </div>--%>
<%--</form:form>--%>


<%--<script>--%>
<%--    const formSelector = document.getElementById("formSelector");--%>

<%--    formSelector.addEventListener("change", function () {--%>
<%--        const selectedFormId = formSelector.value;--%>

<%--        // Hide all forms--%>
<%--        const allForms = document.querySelectorAll("div");--%>
<%--        allForms.forEach(form => form.style.display = "none");--%>

<%--        // Show the selected form--%>
<%--        const selectedForm = document.getElementById(selectedFormId);--%>
<%--        selectedForm.style.display = "block";--%>
<%--    });--%>
<%--</script>--%>

</body>
</html>
