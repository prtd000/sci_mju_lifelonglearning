<%@ page import="lifelong.model.Admin" %>
<%@ page import="lifelong.model.Member" %>
<%@ page import="lifelong.model.Lecturer" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <title>Edit Profile</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>

    <jsp:include page="/WEB-INF/view/layouts/detail-all-style.jsp"/>
    <style>
        tr td label{
            font-size: 18px;
            font-weight: bold;
            color: black;
        }
    </style>

    <script>
        document.addEventListener("DOMContentLoaded", function() {
            const dateInput = document.getElementById("datePicker");

            // Get today's date
            const today = new Date().toISOString().split("T")[0];

            // Set the max attribute to today's date
            dateInput.setAttribute("max", today);
        });

        /***** can't do not select date future ********/

        document.addEventListener("DOMContentLoaded", function() {
            const dateInput = document.getElementById("datePicker");

            // Get today's date
            const today = new Date().toISOString().split("T")[0];

            // Set the max attribute to today's date
            dateInput.setAttribute("max", today);
        });

        /****************** Script *****************************/
        //----------First Name------------
        function checkScript(frm) {

            //---------FirstName----------
            var name = /^[ก-์A-Za-z]+$/
            if (!frm.firstName.value.match(name)) {
                alert("ชื่อจริงต้องเป็นภาษาไทยหรืออังกฤษเท่านั้น (ห้ามกรอกเป็นตัวเลข หรือ อักขระต่างๆ !!)");
                frm.firstName.value = "";
                return false;
            }

            //-----------Last Name-------------
            if (!frm.lastName.value.match(name)) {
                alert("นามสกุลเป็นภาษาไทยหรืออังกฤษเท่านั้น (ห้ามกรอกเป็นตัวเลข หรือ อักขระต่างๆ !!)");
                frm.lastName.value = "";
                return false;
            }

            //------------------Birth Day----------------
            var birthday = new Date(document.getElementById('datePicker').value.split("/")[2] - 543 + "-"
                + document.getElementById('datePicker').value.split("/")[1] + "-"
                + document.getElementById('datePicker').value.split("/")[0]);

            var birthday2 = new Date();
            birthday2.setFullYear(new Date().getFullYear() - 16);

            if (birthday.getTime() > birthday2.getTime()) {
                alert("อายุของผู้สมัครสมาชิกจะต้องมีอายุ 16 ปีขึ้นไป !!");
                return false;
            } else if (frm.birthday.value === "") {
                alert("กรุณากรอกวันเกิดปีเกิด");
                frm.birthday.value = "";
                return false;
            }

            //------------Tel---------------
            var tel = /^[0-9]{3}[-][0-9]{3}[-][0-9]{4}|[\d]{7,10}$/
            if (!frm.tel.value.match(tel)) {
                alert("กรอกเบอร์โทรศัพท์มือถือให้ถูกต้อง (ตัวอย่าง 06x-xxx-xxxx)");
                frm.tel.value = "";
                return false;
            }

            //------------Email---------------
            var Email = /^.+@.+\..{2,3}$/;
            if (!frm.email.value.match(Email)) {
                alert("กรอกอีเมล์ให้ถูกต้อง");
                frm.email.value = "";
                return false;
            }
        }

    </script>

</head>
<body>
<!-- Navbar Start -->
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

<c:set var="flag" value="<%= flag %>"/>
<c:choose>
    <c:when test="${flag.equals('member')}">
        <!-- Navbar Start -->
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
<%--                    <a href="#" class="nav-item nav-link" style="font-size: 17px">เกี่ยวกับคณะ</a>--%>
                        <%--            <div class="nav-item dropdown">--%>
                        <%--                <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">หลักสูตรการอบรม</a>--%>
                    <a href="${pageContext.request.contextPath}/search_course" class="nav-item nav-link " style="font-size: 17px">หลักสูตรการอบรม</a>
                        <%--                <div class="dropdown-menu m-0">--%>
                        <%--                    <a href="#" class="dropdown-item">Reskill/Upskill</a>--%>
                        <%--                    <a href="#" class="dropdown-item">อบรมระยะสั้น</a>--%>
                        <%--                </div>--%>
                        <%--            </div>--%>
                    <a href="${pageContext.request.contextPath}/member/<%=member.getUsername()%>/listcourse" class="nav-item nav-link" style="font-size: 17px">หลักสูตรของฉัน</a>
                    <a href="${pageContext.request.contextPath}/view_activity" class="nav-item nav-link" style="font-size: 17px">ข่าวสารและกิจกรรม</a>
<%--                    <a href="#" class="nav-item nav-link" style="font-size: 17px">เกี่ยวกับเรา</a>--%>
                    <a href="${pageContext.request.contextPath}/member/<%=member.getUsername()%>/edit_profile" class="nav-item nav-link active" style="font-size: 17px">ข้อมูลส่วนตัว</a>
                    <a href="${pageContext.request.contextPath}/doLogout" class="nav-item nav-link" style="font-size: 17px">ออกจากระบบ</a>
                </div>
            </div>
        </nav>
        <!-- Navbar End -->
    </c:when>
</c:choose>

<center>
    <br>
    <h1>ข้อมูลส่วนตัว</h1>
    <br>
    <br>
    <form action="${pageContext.request.contextPath}/member/${member.username}/update" name="frm" method="post">
        <table>
            <tr>
                <td><label class="form-label">ชื่อ</label></td>
                <td><label class="form-label">นามสกุล</label></td>
            </tr>
            <tr>
                <td><input type="text" value="${member.firstName}" name="firstName" id="firstName" class="form-control" onkeyup="CheckFirstName()"></td>
                <td><input type="text" value="${member.lastName}" name="lastName" class="form-control"></td>
            </tr>
            <tr>
                <td><label class="form-label">วัน/เดือน/ปี</label></td>
                <td><label class="form-label">เบอร์โทร</label></td>
            </tr>
            <tr>
                <td><input type="date" value="${member.birthday}" id="datePicker" name="birthday" class="form-control" style="width: 100%;"/></td>
                <td><input type="text" value="${member.tel}" id="tel"  name="tel" class="form-control"></td>
            </tr>
            <tr>
                <td><label class="form-label">อีเมล</label></td>
            </tr>
            <tr>
                <td colspan="2"><input type="text" value="${member.email}" class="form-control" style="width: 100%" name="email" id="email"></td>
            </tr>
            <tr>
                <td><label class="form-label">ระดับการศึกษา</label></td>
            </tr>
            <tr>
                <td colspan="2">
                    <select id="education" name="education" class="form-select" aria-label="Default select example">
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
                <td><br></td>
                <td></td>
            </tr>
            <tr>
                <td>
                    <input type="submit" value="บันทึก" class="btn btn-success" onclick="return checkScript(frm)">
                    <button class="btn btn-dark"><a href="${pageContext.request.contextPath}/member/${member.username}/change_password" style="color: white">เปลี่ยนรหัสผ่าน</a></button>
                </td>
            </tr>
        </table>
    </form>
    <br><br>
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
