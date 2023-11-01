<%--
  Created by IntelliJ IDEA.
  User: asus
  Date: 9/20/2023
  Time: 2:48 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.util.List" %>
<%@ page import="lifelong.model.*" %>
<%@ page import="java.util.Date" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    List<Member> members = (List<Member>) session.getAttribute("listUser");
%>
<!DOCTYPEhtml>
<html>
<head>
    <title>Register Member</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">

    <jsp:include page="/WEB-INF/view/layouts/detail-all-style.jsp"/>

    <!-- google font -->
    <link href="https://fonts.googleapis.com/css2?family=Mitr:wght@200&family=Prompt:wght@200&display=swap" rel="stylesheet">
<%--    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&display=swap" rel="stylesheet">--%>

    <style>
        body {
            font-family: 'Mitr', sans-serif;

            /*font-family: 'Open Sans', sans-serif;*/
        }

        #signUpForm {
            max-width: 60%;
            background-color: #ffffff;
            margin: 40px auto;
            padding: 40px;
            box-shadow: 0px 6px 18px rgb(0 0 0 / 9%);
            border-radius: 12px;
        }

        #signUpForm .form-header {
            gap: 5px;
            text-align: center;
            font-size: .9em;
        }

        #signUpForm .form-header .stepIndicator {
            position: relative;
            flex: 1;
            padding-bottom: 30px;
        }

        #signUpForm .form-header .stepIndicator.active {
            font-weight: 600;
        }

        #signUpForm .form-header .stepIndicator.finish {
            font-weight: 600;
            color: #ff7b31;
        }

        #signUpForm .form-header .stepIndicator::before {
            content: "";
            position: absolute;
            left: 50%;
            bottom: 0;
            transform: translateX(-50%);
            z-index: 9;
            width: 20px;
            height: 20px;
            background-color: #efdbd5;
            border-radius: 50%;
            border: 3px solid #f5eeec;
        }

        #signUpForm .form-header .stepIndicator.active::before {
            background-color: #edbca7;
            border: 3px solid #f9e2d5;
        }

        #signUpForm .form-header .stepIndicator.finish::before {
            background-color: #ff7b31;
            border: 3px solid #e1bfb7;
        }

        #signUpForm .form-header .stepIndicator::after {
            content: "";
            position: absolute;
            left: 50%;
            bottom: 8px;
            width: 100%;
            height: 3px;
            background-color: #f3f3f3;
        }

        #signUpForm .form-header .stepIndicator.active::after {
            background-color: #edb4a7;
        }

        #signUpForm .form-header .stepIndicator.finish::after {
            background-color: #ff7b31;
        }

        #signUpForm .form-header .stepIndicator:last-child:after {
            display: none;
        }

        #signUpForm input, #signUpForm select {
            padding: 15px 20px;
            width: 100%;
            font-size: 1em;
            border: 1px solid #e3e3e3;
            border-radius: 5px;
        }

        #signUpForm input:focus, #signUpForm select:focus {
            border: 1px solid #ff7b31;
            outline: 0;
        }

        #signUpForm input.invalid, #signUpForm select.invalid {
            border: 1px solid #ffbda5;
        }

        #signUpForm .step {
            display: none;
        }

        #signUpForm .form-footer {
            overflow: auto;
            gap: 20px;
        }

        #signUpForm .form-footer button {
            background-color: #ff7b31;
            border: 1px solid #ff7b31 !important;
            color: #ffffff;
            border: none;
            padding: 13px 30px;
            font-size: 1em;
            cursor: pointer;
            border-radius: 5px;
            flex: 1;
            margin-top: 5px;
        }

        #signUpForm .form-footer button:hover {
            opacity: 0.8;
        }

        #signUpForm .form-footer #prevBtn {
            background-color: #fff;
            color: #ff7b31;
        }

        label{
            font-weight: bold;
            color: black;
        }

        .table-step3{
            color: black;
            font-size: 18px;
            font-weight: bold;
        }

        table[class='table-step3'] tr {
            height: 50px;
        }
    </style>
    <script>
        function previewImage(input) {
            var preview = document.getElementById('preview');
            var displayPreview = document.getElementById('displayPreview');
            var fileInput = document.getElementById('fileInput');

            if (input.files && input.files[0]) {
                var reader = new FileReader();

                reader.onload = function (e) {
                    preview.src = e.target.result;
                    preview.style.display = 'block';

                    displayPreview.src = e.target.result;
                    displayPreview.style.display = 'block';
                };

                reader.readAsDataURL(input.files[0]);
            } else {
                preview.src = '';
                preview.style.display = 'none';

                displayPreview.src = '';
                displayPreview.style.display = 'none';
            }
        }

        /****************** Script *****************************/
        function checkScript(frm) {
            //-------------Id Card-------------
            var idCard = /^[0-9]{13}|[\d]{1}[-|\s][\d]{4}[-|\s][\d]{5}[-|\s][\d]{2}[-|\s][\d]{1}$/;

            if(frm.idcard.value === ""){
                document.getElementById("invalidIdCard").innerHTML = "กรอกเลขบัตรประชาชน";
                return false;
            }else if (!frm.idcard.value.match(idCard)) {
                document.getElementById("invalidIdCard").innerHTML = "กรอกเลขบัตรประชาชนให้ถูกต้อง";
                frm.idcard.value = "";
                return false;
            }else {
                document.getElementById("invalidIdCard").innerHTML = "";
            }

            //---------FirstName----------
            var name = /^[ก-์A-Za-z]+$/
            if (frm.firstName.value === ""){
                document.getElementById("invalidFirstname").innerHTML = "กรุณากรอกชื่อจริง";
                return false;
            } else if (!frm.firstName.value.match(name)) {
                document.getElementById("invalidFirstname").innerHTML = "ชื่อจริงต้องเป็นภาษาไทยหรืออังกฤษเท่านั้น (ห้ามกรอกเป็นตัวเลข หรือ อักขระต่างๆ !!)";
                frm.firstName.value = "";
                return false;
            }else{
                document.getElementById("invalidFirstname").innerHTML = "";
            }

            //-----------Last Name-------------
            if (frm.lastName.value === ""){
                document.getElementById("invalidLastName").innerHTML = "กรุณากรอกนามสกุล";
                return false;
            }else if (!frm.lastName.value.match(name)) {
                document.getElementById("invalidLastName").innerHTML = "นามสกุลเป็นภาษาไทยหรืออังกฤษเท่านั้น (ห้ามกรอกเป็นตัวเลข หรือ อักขระต่างๆ !!)";
                frm.lastName.value = "";
                return false;
            }else{
                document.getElementById("invalidLastName").innerHTML = "";
            }

            //------------Gender-------------
            var gendercheck = document.getElementsByName('gender');
            var gendernull = false;
            for (var i = 0; i < gendercheck.length; i++) {
                if (gendercheck[i].checked) {
                    gendernull = true;
                    break;
                }
            }
            if (!gendernull) {
                document.getElementById("invalidGender").innerHTML = "กรุณาเลือกเพศ";
                return false;
            }else {
                document.getElementById("invalidGender").innerHTML = "";
            }

            //------------Email---------------
            var Email = /^.+@.+\..{2,3}$/;
            if (frm.email.value === ""){
                document.getElementById("invalidEmail").innerHTML = "กรุณากรอกอีเมล";
                return false;
            } else if (!frm.email.value.match(Email)) {
                document.getElementById("invalidEmail").innerHTML = "กรอกอีเมล์ให้ถูกต้อง";
                frm.email.value = "";
                return false;
            }else {
                document.getElementById("invalidEmail").innerHTML = "";
            }

            // ------------------BirthDay----------------
            var birthday = new Date(document.getElementById('datePicker').value.split("/")[2] - 543 + "-"
                + document.getElementById('datePicker').value.split("/")[1] + "-"
                + document.getElementById('datePicker').value.split("/")[0]);

            var birthday2 = new Date();
            birthday2.setFullYear(new Date().getFullYear() - 16);

            if (birthday.getTime() > birthday2.getTime()) {
                alert("อายุของผู้สมัครสมาชิกจะต้องมีอายุ 16 ปีขึ้นไป !!");
                frm.birthday.value = "";
                return false;
            }
        }

        /************* Step 2 ***************************/
        function checkTel(tel) {
            var exTel = /^[0-9]{3}[-][0-9]{3}[-][0-9]{4}|[\d]{7,10}$/
            if (!tel.match(exTel)){
                document.getElementById("invalidTel").innerHTML = "กรอกเบอร์โทรศัพท์มือถือให้ถูกต้อง (ตัวอย่าง 06x-xxx-xxxx)";
                return false;
            } else {
                document.getElementById("invalidTel").innerHTML = "";
            }
        }

        function checkEducation(edu) {
            if (edu === "กรุณาเลือกระดับการศึกษา"){
                document.getElementById("invalidEducation").innerHTML = "กรุณาเลือกระดับการศึกษา";
                return false;
            } else {
                document.getElementById("invalidEducation").innerHTML = "";
            }
        }

        function checkUsername(user) {
            var username = /^[A-Za-z0-9(_)]{4,10}$/;
            if (!user.value.match(username)){
                document.getElementById("invalidUsername").innerHTML = "กรุณากรอกบัญชีผู้ใช้เป็นภาษาอังกฤษและตัวเลข (อย่างน้อย 4 - 10 ตัว)";
                return false;
            } else {
                document.getElementById("invalidUsername").innerHTML = "";
            }
        }

        function checkPassword(pass) {
            var password = /^[A-Za-z0-9(_)]{4,10}$/;
            if (!pass.value.match(password)){
                document.getElementById("invalidPassword").innerHTML = "รหัสผ่านต้องเป็นตัวเลข (อย่างน้อย 4 - 8 ตัว)";
                return false;
            } else {
                document.getElementById("invalidPassword").innerHTML = "";
            }
        }


    </script>
</head>
<body>
<!-- Navbar Start -->
<nav class="navbar navbar-expand-lg bg-white navbar-light shadow-sm py-3 py-lg-0 px-3 px-lg-0">
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
            <a href="${pageContext.request.contextPath}/" class="nav-item nav-link " style="font-size: 17px">หน้าหลัก</a>
<%--            <a href="#" class="nav-item nav-link" style="font-size: 17px">เกี่ยวกับคณะ</a>--%>
            <a href="${pageContext.request.contextPath}/search_course" class="nav-item nav-link" style="font-size: 17px">หลักสูตรการอบรม</a>
            <a href="${pageContext.request.contextPath}/view_activity" class="nav-item nav-link" style="font-size: 17px">ข่าวสารและกิจกรรม</a>
<%--            <a href="#" class="nav-item nav-link" style="font-size: 17px">เกี่ยวกับเรา</a>--%>
            <div class="nav-item dropdown">
                <a href="#" class="nav-link dropdown-toggle nav-item active" data-bs-toggle="dropdown" style="font-size: 17px">เข้าสู่ระบบ</a>
                <div class="dropdown-menu m-0">
                    <a href="${pageContext.request.contextPath}/loginMember" class="dropdown-item" style="font-size: 17px">สำหรับสมาชิก</a>
                    <a href="${pageContext.request.contextPath}/loginLecturer" class="dropdown-item" style="font-size: 17px">สำหรับบุคลากร</a>
                    <a href="${pageContext.request.contextPath}/loginAdmin" class="dropdown-item" style="font-size: 17px">สำหรับผู้ดูแลระบบ</a>
                </div>
            </div>
        </div>
    </div>
</nav>
<!-- Navbar End -->

    <!-- Navbar End -->
    <div class="container">
        <div id="container">
            <br>
            <form id="signUpForm" action="${pageContext.request.contextPath}/register_member/save" name="frm" method="POST" onsubmit="return confirmSubmit();">
                <!-- start step indicators -->
                <div class="form-header d-flex mb-4">
                    <span class="stepIndicator" style="font-size: 20px;">ขั้นตอนที่ 1</span>
                    <span class="stepIndicator" style="font-size: 20px;">ขั้นตอนที่ 2</span>
                    <span class="stepIndicator" style="font-size: 20px;">ตรวจสอบข้อมูล</span>
                </div>
                <!-- end step indicators -->

                <!-- step one -->
                <div class="step" style="display: inline-block">
                    <p class="text-center mb-4" style="font-size: 20px; font-weight: bold;">สมัครสมาชิก</p>
                    <table style="width: 100%; border: 1px">
                        <tr>
                            <td style="width: 60%">
                                <label>บัตรประชาชน</label>
                                <div class="mb-3">
                                    <input name="idcard" id="idcard" type="text" class="input_idcard" placeholder="*ตัวอย่าง* 0123456789101" maxlength="13" oninput="this.className = ''"/>
                                    <label id="invalidIdCard" style="color: red; font-size: 12px"></label>
                                </div>
                                <label>ชื่อ</label>
                                <div class="mb-3">
                                    <input name="firstName" id="firstName" type="text" placeholder="*ตัวอย่าง* นายสมชาย" oninput="this.className = ''"/>
                                    <label id="invalidFirstname" style="color: red; font-size: 12px"></label>
                                </div>
                                <label>นามสกุล</label>
                                <div class="mb-3">
                                    <input name="lastName" id="lastName" type="text" placeholder="*ตัวอย่าง* ใจดี" oninput="this.className = ''"/>
                                    <label id="invalidLastName" style="color: red; font-size: 12px"></label>
                                </div>
                                <label>เพศ</label>
                                <div class="mb-3">
                                    <table>
                                        <tr>
                                            <td style="width: 35px;"><input type="radio" name="gender" value="ชาย"></td>
                                            <td><label>ชาย</label></td>
                                            <td style="width: 35px;"><input type="radio" name="gender" value="หญิง"></td>
                                            <td><label>หญิง</label></td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">
                                                <label id="invalidGender" style="color: red; font-size: 12px"></label>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <label>อีเมล</label>
                                <div class="mb-3">
                                    <input name="email" id="email" type="text" placeholder="*ตัวอย่าง* userxxx@gmail.com" oninput="this.className = ''"/>
                                    <label id="invalidEmail" style="color: red; font-size: 12px"></label>
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>

                <!-- step two -->
                <div class="step">
                    <p class="text-center mb-4" style="font-size: 20px; font-weight: bold;">สมัครสมาชิก</p>
                    <table style="width: 100%">
                        <tr>
                            <td>
                                <label>วันเดือนปีเกิด (ผู้สมัครจะต้องมีอายุ 16 ปีขึ้นไป)</label>
                                <div class="mb-3">
                                    <input name="birthday" id="datePicker" type="date" oninput="this.className = ''"/>
                                    <label id="invalidBirthday" style="color: red; font-size: 12px"></label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label>เบอร์โทร</label>
                                <div class="mb-3">
                                    <input name="tel" id="tel" type="text" maxlength="15"  placeholder="*ตัวอย่าง* 086-xxx-xxxx" oninput="checkTel(this.value)"/>
                                    <label id="invalidTel" style="color: red; font-size: 12px"></label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label>การศึกษา</label>
                                <div class="mb-3">
                                    <select id="education" name="education" class="form-select" oninput="checkEducation(this.value)">
                                        <option value="กรุณาเลือกระดับการศึกษา" selected>กรุณาเลือกระดับการศึกษา</option>
                                        <option value="ระดับมัธยมศึกษา">ระดับมัธยมศึกษา</option>
                                        <option value="ระดับอาชีวศึกษา">ระดับอาชีวศึกษา</option>
                                        <option value="ระดับอุดมศึกษา">ระดับอุดมศึกษา</option>
                                        <option value="ปริญญาตรี">ปริญญาตรี</option>
                                        <option value="ปริญญาโท">ปริญญาโท</option>
                                        <option value="ปริญญาเอก">ปริญญาเอก</option>
                                    </select>
                                </div>
                                <label id="invalidEducation" style="color: red; font-size: 12px"></label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label>บัญชีผู้ใช้งาน</label>
                                <div class="mb-3">
                                    <input type="text" name="username" id="username" placeholder="บัญชีผู้ใช้เป็นภาษาอังกฤษและตัวเลข (อย่างน้อย 4 - 10 ตัว)" maxlength="10" oninput="checkUsername(this.value)"/>
                                    <a id="link" href="#">ตรวจสอบ</a> &nbsp; <label id="status"></label>
                                    <label id="invalidUsername" style="color: red; font-size: 12px"></label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label>รหัสผ่าน</label>
                                <div class="mb-3">
                                    <input name="password" id="password" type="password" placeholder="รหัสผ่านต้องเป็นตัวเลข (อย่างน้อย 4 - 8 ตัว)" maxlength="8" oninput="checkPassword(this.value)"/>
                                    <label id="invalidPassword" style="color: red; font-size: 12px"></label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label>ยืนยันรหัสผ่าน</label>
                                <div class="mb-3">
                                    <input type="password" id="confirmPassword" name="confirmPassword" placeholder="ยืนยันรหัสผ่านใหม่" oninput="this.className = ''" onkeyup="checkPasswordMatch()">
                                    <p id="passwordMatchMessage">กรุณากรอกรหัสผ่านให้ตรงกัน</p>
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>

                <!-- step three -->
                <div class="step">
                    <h2 class="text-center mb-4" style="font-size: 20px; font-weight: bold;">ตรวจสอบข้อมูล</h2>
                    <center>
                        <div>
                            <table class="table-step3">
                                <tr>
                                    <td style="width: 200px">บัตรประชาชน</td>
                                    <td><span id="displayIdCard"></span></td>
                                </tr>
                                <tr>
                                    <td>ชื่อจริง</td>
                                    <td><span id="displayFirstName"></span></td>
                                </tr>
                                <tr>
                                    <td>นามสกุล</td>
                                    <td><span id="displayLastName"></span></td>
                                </tr>
                                <tr>
                                    <td>เพศ</td>
                                    <td><span id="displayGender"></span></td>
                                </tr>
                                <tr>
                                    <td>อีเมล</td>
                                    <td><span id="displayEmail"></span></td>
                                </tr>
                                <tr>
                                    <td>วันเดือนปีเกิด</td>
                                    <td><span id="displayDatePicker"></span></td>
                                </tr>
                                <tr>
                                    <td>เบอร์</td>
                                    <td><span id="displayTel"></span></td>
                                </tr>
                                <tr>
                                    <td>การศึกษา</td>
                                    <td><span id="displayEducation"></span></td>
                                </tr>
                                <tr>
                                    <td>ชื่อบัญชี</td>
                                    <td><span id="displayUsername"></span></td>
                                </tr>
                                <tr>
                                    <td>รหัสผ่าน</td>
                                    <td><span id="displayPassword"></span></td>
                                </tr>
                            </table>
                            <!-- เพิ่มข้อมูลอื่น ๆ ที่คุณต้องการแสดงจาก Step 2 -->
                        </div>
                    </center>
                    <br>
                </div>

                <!-- start previous / next buttons -->
                <div class="form-footer d-flex">
                    <button type="button" id="prevBtn" onclick="nextPrev(-1)">ย้อนกลับ</button>
                    <button type="button" id="nextBtn" onclick="nextPrev(1); return checkScript(frm)">ต่อไป</button>
                </div>
                <!-- end previous / next buttons -->
            </form>
        </div>
    </div>
<jsp:include page="/WEB-INF/view/layouts/footer.jsp"/>
</body>
<script>

    /************ Check Username ******************/

    document.getElementById('link').addEventListener('click', function (event) {
        event.preventDefault(); // ป้องกันการนำทางเมื่อคลิกลิงก์

        const stt = document.getElementById("status");
        const userElement = document.getElementById("username").value;
        let userFound = false;

        <% for (Member m : members) { %>
        if ("<%= m.getUsername() %>".trim() === userElement.trim()) {
            stt.innerHTML = "มีบัญชีนี้แล้ว";
            stt.style.color = "red"
            userFound = true;
        }
        <% } %>

        if (!userFound) {
            stt.innerHTML = "บัญชีนี้ใช้งานได้";
            stt.style.color = "green";
        }
    });

    /********* Confirm Password ******************/
    const passwordInput = document.getElementById("password");
    const confirmPasswordInput = document.getElementById("confirmPassword");
    const passwordMatchMessage = document.getElementById("passwordMatchMessage");

    function checkPasswordMatch() {
        const newPassword = passwordInput.value;
        const confirmPassword = confirmPasswordInput.value;

        if (newPassword === confirmPassword) {
            passwordMatchMessage.textContent = "Passwords match.";
            passwordMatchMessage.style.color = "green";
        } else {
            passwordMatchMessage.textContent = "Passwords do not match.";
            passwordMatchMessage.style.color = "red";

        }
    }

    /***** can't do not select date future ********/

    // document.addEventListener("DOMContentLoaded", function() {
    //     const dateInput = document.getElementById("datePicker");
    //
    //     // Get today's date
    //     const today = new Date().toISOString().split("T")[0];
    //
    //     // Set the max attribute to today's date
    //     dateInput.setAttribute("max", today);
    // });

    document.addEventListener("DOMContentLoaded", function() {
        const dateInput = document.getElementById("datePicker");

        // Get today's date
        const today = new Date();

        // Calculate the date 16 years ago from today
        const sixteenYearsAgo = new Date(today.getFullYear() - 16, today.getMonth(), today.getDate());

        // Format the date as "YYYY-MM-DD"
        const formattedDate = sixteenYearsAgo.toISOString().split("T")[0];

        // Set the min attribute to 16 years ago from today
        dateInput.setAttribute("max", formattedDate);
    });

    /******** Format Date to dd/mm/yyyy **************/

    function formatDateElement(elementId) {
        var text = document.getElementById(elementId).value;
        var date = new Date(text);

        var day = date.getDate();
        var month = date.getMonth() + 1; // เพิ่ม 1 เนื่องจากเดือนเริ่มต้นจาก 0
        var year = date.getFullYear();

        return day + '/' + month + '/' + year;
    }

    /****************** Alert Ask sure ? ****************************/

    function confirmSubmit() {
        return confirm("ยืนยันการสมัครสมาชิก");
    }


    function displayDataInStep3() {
        // ข้อมูลจาก Step 1
        const idCard = document.getElementById("idcard").value;
        const firstName = document.getElementById("firstName").value;
        const lastName = document.getElementById("lastName").value;
        const gender = document.getElementsByName("gender");
        const email = document.getElementById("email").value;

        // ข้อมูลจาก Step 2
        const tel = document.getElementById("tel").value;
        const education = document.getElementById("education").value;
        const username = document.getElementById("username").value;
        const password = document.getElementById("password").value;


        // แสดงข้อมูลใน Step 3
        document.getElementById("displayIdCard").textContent = idCard;
        document.getElementById("displayFirstName").textContent = firstName;
        document.getElementById("displayLastName").textContent = lastName;
        document.getElementById("displayEmail").textContent = email;
        document.getElementById("displayDatePicker").textContent = formatDateElement("datePicker");
        document.getElementById("displayTel").textContent = tel;
        document.getElementById("displayEducation").textContent = education;
        document.getElementById("displayUsername").textContent = username;
        document.getElementById("displayPassword").textContent = password;

    }

    // เรียกใช้ฟังก์ชันเมื่อคลิก Next ใน Step 2
    document.getElementById("nextBtn").addEventListener("click", displayDataInStep3);


    /******* Get Data Radio Show Form 3 ***********/
    document.getElementById("nextBtn").addEventListener("click", function() {
        // ดึงค่าของเพศที่ถูกเลือก
        const genderRadios = document.getElementsByName("gender");
        let selectedGender = "";

        for (const radio of genderRadios) {
            if (radio.checked) {
                selectedGender = radio.value;
                break; // หยุดการวนลูปหาเพศที่ถูกเลือก
            }
        }

        // แสดงค่าของเพศใน Step 3
        document.getElementById("displayGender").textContent = selectedGender;
    });

</script>
<%------------- bootstrap ----------------%>
<script>
    var currentTab = 0; // Current tab is set to be the first tab (0)
    showTab(currentTab); // Display the current tab

    function showTab(n) {
        // This function will display the specified tab of the form...
        var x = document.getElementsByClassName("step");
        x[n].style.display = "block";
        //... and fix the Previous/Next buttons:
        if (n == 0) {
            document.getElementById("prevBtn").style.display = "none";
        } else {
            document.getElementById("prevBtn").style.display = "inline";
        }
        if (n == (x.length - 1)) {
            document.getElementById("nextBtn").innerHTML = "ยืนยัน";
        } else {
            document.getElementById("nextBtn").innerHTML = "ต่อไป";
        }
        //... and run a function that will display the correct step indicator:
        fixStepIndicator(n)
    }

    function nextPrev(n) {
        // This function will figure out which tab to display
        var x = document.getElementsByClassName("step");
        // Exit the function if any field in the current tab is invalid:
        if (n == 1 && !validateForm()) return false;
        // Hide the current tab:
        x[currentTab].style.display = "none";
        // Increase or decrease the current tab by 1:
        currentTab = currentTab + n;
        // if you have reached the end of the form...
        if (currentTab >= x.length) {
            // ... the form gets submitted:
            document.getElementById("signUpForm").submit();
            return false;
        }
        // Otherwise, display the correct tab:
        showTab(currentTab);
    }

    function validateForm() {
        // This function deals with validation of the form fields
        var x, y, i, valid = true;
        x = document.getElementsByClassName("step");
        y = x[currentTab].getElementsByTagName("input");
        // A loop that checks every input field in the current tab:
        for (i = 0; i < y.length; i++) {
            // If a field is empty...
            if (y[i].value == "") {
                // add an "invalid" class to the field:
                y[i].className += " invalid";
                // and set the current valid status to false
                valid = false;
            }
        }
        // If the valid status is true, mark the step as finished and valid:
        if (valid) {
            document.getElementsByClassName("stepIndicator")[currentTab].className += " finish";
        }
        return valid; // return the valid status
    }

    function fixStepIndicator(n) {
        // This function removes the "active" class of all steps...
        var i, x = document.getElementsByClassName("stepIndicator");
        for (i = 0; i < x.length; i++) {
            x[i].className = x[i].className.replace(" active", "");
        }
        //... and adds the "active" class on the current step:
        x[n].className += " active";
    }
</script>
<%------------- bootstrap ----------------%>
</html>
