<%--
  Created by IntelliJ IDEA.
  User: asus
  Date: 9/20/2023
  Time: 2:48 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.util.List" %>
<%@ page import="lifelong.model.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    List<Member> members = (List<Member>) session.getAttribute("listUser");
%>
<!DOCTYPEhtml>
<html>
<head>
    <title>${title}</title>
    <jsp:include page="/WEB-INF/view/layouts/detail-all-style.jsp"/>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">

    <!-- google font -->
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Open Sans', sans-serif;
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
    </script>
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
<c:set var="flag" value="<%= flag %>"/>
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
    <!-- Navbar End -->
    <div class="container">
        <div id="container">
            <br>
            <form id="signUpForm" action="${pageContext.request.contextPath}/register_member/save" name="frm" method="POST" onsubmit="return confirmSubmit();">
                <!-- start step indicators -->
                <div class="form-header d-flex mb-4">
                    <span class="stepIndicator">ขั้นตอนที่ 1</span>
                    <span class="stepIndicator">ขั้นตอนที่ 2</span>
                    <span class="stepIndicator">ตรวจสอบข้อมูล</span>
                </div>
                <!-- end step indicators -->

                <!-- step one -->
                <div class="step" style="display: inline-block">
                    <p class="text-center mb-4">สมัครสมาชิก</p>
                    <table style="width: 100%; border: 1px">
                        <tr>
                            <td style="width: 60%">
                                <label>บัตรประชาชน</label>
                                <div class="mb-3">
                                    <input name="idcard" id="idcard" type="text" class="input_idcard" oninput="this.className = ''"/>
                                </div>
                                <label>ชื่อจริง</label>
                                <div class="mb-3">
                                    <input name="firstName" id="firstName" type="text" oninput="this.className = ''"/>
                                </div>
                                <label>นามสกุล</label>
                                <div class="mb-3">
                                    <input name="lastName" id="lastName" type="text" oninput="this.className = ''"/>
                                </div>
                                <label>เพศ</label>
                                <div class="mb-3">
                                    <table>
                                        <tr>
                                            <td><label>ชาย</label></td>
                                            <td><input type="radio" name="gender" value="ชาย"></td>
                                            <td><label>หญิง</label></td>
                                            <td><input type="radio" name="gender" value="หญิง"></td>
                                        </tr>
                                    </table>
                                </div>
                                <label>อีเมล</label>
                                <div class="mb-3">
                                    <input name="email" id="email" type="text" oninput="this.className = ''"/>
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>

                <!-- step two -->
                <div class="step">
                    <p class="text-center mb-4">ขั้นตอนที่ 2</p>
                    <table style="width: 100%">
                        <tr>
                            <td>
                                <label>วันเดือนปีเกิด</label>
                                <div class="mb-3">
                                    <input name="birthday" id="datePicker" type="date" oninput="this.className = ''"/>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label>เบอร์โทร</label>
                                <div class="mb-3">
                                    <input name="tel" id="tel" type="text" oninput="this.className = ''"/>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label>การศึกษา</label>
                                <div class="mb-3">
                                    <select id="education" name="education" class="form-select" oninput="this.className = ''">
                                        <option value="ระดับมัธยมศึกษา">ระดับมัธยมศึกษา</option>
                                        <option value="ระดับอาชีวศึกษา">ระดับอาชีวศึกษา</option>
                                        <option value="ระดับอุดมศึกษา">ระดับอุดมศึกษา</option>
                                        <option value="ปริญญาตรี">ปริญญาตรี</option>
                                        <option value="ปริญญาโท">ปริญญาโท</option>
                                        <option value="ปริญญาเอก">ปริญญาเอก</option>
                                    </select>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label>บัญชีผู้ใช้งาน</label>
                                <div class="mb-3">
                                    <input type="text" name="username" id="username" placeholder="Username" oninput="this.className = ''"/>
                                    <a id="link" href="#">ตรวจสอบ</a> &nbsp; <label id="status"></label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label>รหัสผ่าน</label>
                                <div class="mb-3">
                                    <input name="password" id="password" type="password" placeholder="Password" oninput="this.className = ''"/>
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
                    <h2 class="text-center mb-4">ตรวจสอบข้อมูล</h2>
                    <div>
                        <h3>ข้อมูลจาก Step 1</h3>
                        <p>บัตรประชาชน: <span id="displayIdCard"></span></p>
                        <p>ชื่อจริง: <span id="displayFirstName"></span></p>
                        <p>นามสกุล: <span id="displayLastName"></span></p>
                        <p>เพศ: <span id="displayGender"></span></p>
                        <p>อีเมล: <span id="displayEmail"></span></p>
                    </div>

                    <div>
                        <h3>ข้อมูลจาก Step 2</h3>
                        <p>วันเดือนปีเกิด: <span id="displayDatePicker"></span></p>
                        <p>เบอร์: <span id="displayTel"></span></p>
                        <p>การศึกษา: <span id="displayEducation"></span></p>
                        <p>ชื่อบัญชี: <span id="displayUsername"></span></p>
                        <p>รหัสผ่าน: <span id="displayPassword"></span></p>
                        <!-- เพิ่มข้อมูลอื่น ๆ ที่คุณต้องการแสดงจาก Step 2 -->
                    </div>
                </div>

                <!-- start previous / next buttons -->
                <div class="form-footer d-flex">
                    <button type="button" id="prevBtn" onclick="nextPrev(-1)">Previous</button>
                    <button type="button" id="nextBtn" onclick="nextPrev(1)">Next</button>
                </div>
                <!-- end previous / next buttons -->
            </form>
        </div>
    </div>

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

    document.addEventListener("DOMContentLoaded", function() {
        const dateInput = document.getElementById("datePicker");

        // Get today's date
        const today = new Date().toISOString().split("T")[0];

        // Set the max attribute to today's date
        dateInput.setAttribute("max", today);
    });


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
        const datePicker = document.getElementById("datePicker").value;
        const tel = document.getElementById("tel").value;
        const education = document.getElementById("education").value;
        const username = document.getElementById("username").value;
        const password = document.getElementById("password").value;


        // แสดงข้อมูลใน Step 3
        document.getElementById("displayIdCard").textContent = idCard;
        document.getElementById("displayFirstName").textContent = firstName;
        document.getElementById("displayLastName").textContent = lastName;
        document.getElementById("displayEmail").textContent = email;
        document.getElementById("displayDatePicker").textContent = datePicker;
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
            document.getElementById("nextBtn").innerHTML = "Submit";
        } else {
            document.getElementById("nextBtn").innerHTML = "Next";
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
