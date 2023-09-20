<%@ page import="java.util.List" %>
<%@ page import="lifelong.model.Member" %><%--
  Created by IntelliJ IDEA.
  User: asus
  Date: 25/7/2566
  Time: 15:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    List<Member> members = (List<Member>) session.getAttribute("listUser");
%>
<html>
<head>
    <title>Register</title>
    <jsp:include page="/WEB-INF/view/layouts/detail-all-style.jsp"/>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">

    <!-- google font -->

    <style>
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
        #signUpForm input,#signUpForm select {
            padding: 15px 20px;
            width: 100%;
            font-size: 1em;
            border: 1px solid #e3e3e3;
            border-radius: 5px;
        }
        #signUpForm input:focus,#signUpForm select:focus {
            border: 1px solid #ff7b31;
            outline: 0;
        }
        #signUpForm input.invalid,#signUpForm select.invalid {
            border: 1px solid #ffbda5;
        }
        #signUpForm .step {
            display: none;
        }
        #signUpForm .form-footer{
            overflow:auto;
            gap: 20px;
        }
        #signUpForm .form-footer button{
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
        /* CSS สำหรับซ่อนปุ่ม "ลบ" */
        .btn-danger {
            display: none;
            margin-left: 10px;
        }
        .objective,.course_totalHours,.course_fee{
            flex: 1;
        }
        .objective-container,.course-totalHours-container,.course-fee-container{
            width: 100%;
            display: flex;
            align-items: center;
        }
        .l1{
            margin-left: 5px;
            margin-right: 10px;
        }
    </style>

    <script>
        document.addEventListener("DOMContentLoaded", function () {
            const dateInput = document.getElementById("datePicker");

            // Get today's date
            const today = new Date().toISOString().split("T")[0];

            // Set the max attribute to today's date
            dateInput.setAttribute("max", today);
        });

    </script>
</head>
<%--<style>--%>
<%--    /**********Register First Step**********/--%>
<%--    .block_form1 {--%>
<%--        padding: 30px;--%>
<%--        width: 680px;--%>
<%--        border-radius: 25px;--%>
<%--        box-shadow: 2px 2px 5px 1px #626262;--%>
<%--    }--%>

<%--    .regis_block_step1 {--%>
<%--        margin-left: 427px;--%>
<%--        margin-top: 52px;--%>
<%--    }--%>

<%--    .input_idcard {--%>
<%--        width: 100%;--%>
<%--    }--%>
<%--    --%>
<%--    div[class='regis_block_step1'] form table tr {--%>
<%--        height: 50px;--%>
<%--    }--%>

<%--    div[class='regis_block_step1'] form table tr td {--%>
<%--        font-weight: bold;--%>
<%--        font-size: 20px;--%>
<%--        color: black;--%>
<%--    }--%>

<%--    div[class='regis_block_step1'] form table tr td input {--%>
<%--        border-radius: 8px;--%>
<%--        border: 1px solid;--%>
<%--        height: 36px;--%>
<%--        padding: 10px;--%>
<%--    }--%>

<%--    /**********Register Second Step**********/--%>

<%--    .regis_block_step2 {--%>
<%--        margin-left: 427px;--%>
<%--        margin-top: 52px;--%>
<%--    }--%>

<%--    .block_form2 {--%>
<%--        padding: 30px;--%>
<%--        width: 680px;--%>
<%--        border-radius: 25px;--%>
<%--        box-shadow: 2px 2px 5px 1px #626262;--%>
<%--    }--%>

<%--    div[class='regis_block_step2'] form table tr td input {--%>
<%--        border-radius: 8px;--%>
<%--        border: 1px solid;--%>
<%--        height: 36px;--%>
<%--        padding: 10px;--%>
<%--    }--%>

<%--    div[class='regis_block_step2'] form table tr {--%>
<%--        height: 50px;--%>
<%--    }--%>

<%--    div[class='regis_block_step2'] form table tr td {--%>
<%--        font-weight: bold;--%>
<%--        font-size: 20px;--%>
<%--        color: black;--%>
<%--    }--%>

<%--    div[class='regis_block_step2'] form table tr td input[type='text'] {--%>
<%--        border-radius: 8px;--%>
<%--        border: 1px solid;--%>
<%--        height: 36px;--%>
<%--        padding: 10px;--%>
<%--        width: 100%;--%>
<%--    }--%>

<%--    div[class='regis_block_step2'] form table tr td input[type='radio'] {--%>
<%--        width: 26px;--%>
<%--        margin-left: 68px;--%>
<%--        cursor: pointer;--%>
<%--    }--%>

</style>
<body>

<jsp:include page="/WEB-INF/view/layouts/nav.jsp"/>

<div class="container">
    <div id="container">
        <i>กรอกข้อมูลในฟอร์ม. เครื.องหมายดอกจัน(*) หมายถึงห้ามว่าง</i>
        <br><br>
        <form id="signUpForm" action="${pageContext.request.contextPath}/course/${admin_id}/save" method="POST" enctype="multipart/form-data" onsubmit="return confirmAction();">
            <!-- start step indicators -->
            <div class="form-header d-flex mb-4">
                <span class="stepIndicator">Account Setup</span>
                <span class="stepIndicator">Social Profiles</span>
                <span class="stepIndicator">Personal Details</span>
            </div>
            <!-- end step indicators -->

            <!-- step one -->
            <div class="step" style="display: inline-block">
                <p class="text-center mb-4">Create your account</p>
                <table style="width: 100%; border: 1px">
                    <tr>
                        <td style="width: 60%">
                            <label>ประเภทหลักสูตร</label>
                            <div class="mb-3">
                                <select name="course_type" id="course_type" class="form-select" oninput="this.className = ''">
                                    <option value="" label="--กรุณาเลือกหลักสูตร--"></option>
                                    <option value="หลักสูตรอบรมระยะสั้น" label="หลักสูตรอบรมระยะสั้น"></option>
                                    <option value="Non-Degree" label="Non-Degree"></option>
                                </select>
                            </div>
                            <label>ชื่อหลักสูตร</label>
                            <div class="mb-3">
                                <input name="course_name" type="text" id="course_name" placeholder="ชื่อหลักสูตร" oninput="this.className = ''"/>
                                <%--                        <input type="password" placeholder="Password" oninput="this.className = ''" name="password">--%>
                            </div>
                            <label>ชื่อเกียรติบัตร</label>
                            <div class="mb-3">
                                <input name="certificateName" type="text" id="certificateName" placeholder="ชื่อเกียรติบัตร" oninput="this.className = ''"/>
                                <%--                        <input type="password" placeholder="Password" oninput="this.className = ''" name="password">--%>
                            </div>
                            <label>สาขา:</label>
                            <select name="major_id" id="major_id" class="form-select" oninput="this.className = ''">
                                <option value="" label="--กรุณาเลือกหลักสูตร--"></option>
                                <c:forEach items="${majors}" var="major">
                                    <option value="${major.major_id}">${major.name}</option>
                                </c:forEach>
                            </select>
                        </td>
                        <td style="width: 40%; vertical-align: top;">
                            <label>รูปหลักสูตร</label>
                            <div class="mb-3" align="center">
                                <input name="course_img" type="file" id="fileInput" accept="image/*" onchange="previewImage(this)" class="form-control"/>
                                <img id="preview" src="" alt="Image Preview" style="display: none; height: 170px; margin-top: 10px; border-radius: 10px">
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <div class="mb-3">
                                <div class="form-floating">
                                    <textarea class="form-control" placeholder="" id="floatingTextarea2" name="course_principle" style="height: 100px"></textarea>
                                    <label for="floatingTextarea2">หลักการและเหตุผล</label>
                                </div>
                            </div>
                        </td>
                    </tr>
                </table>
            </div>

            <!-- step two -->
            <div class="step">
                <p class="text-center mb-4">Your presence on the social network</p>
                <table style="width: 100%">
                    <tr>
                        <td colspan="3">
                            <label>วัตถุประสงค์</label>
                            <div class="mb-3">
                                <div id="objectives-container">
                                    <div class="objective-container">
                                        <input name="course_objectives[]" type="text" id="course_object" oninput="this.className = ''" class="objective"/>
                                        <button type="button" onclick="removeObjective(this)" class="btn btn-danger">ลบ</button>
                                    </div>
                                </div>
                                <button type="button" onclick="addObjective()">เพิ่มวัตถุประสงค์</button>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label>ระยะเวลาในการเรียน</label>
                            <div class="mb-3">
                                <div class="course-totalHours-container">
                                    <input name="course_totalHours" type="number" id="course_totalHours" class="course_totalHours" placeholder="ระยะเวลาในการเรียน" oninput="this.className = ''">
                                    <label class="l1"> ชั่วโมง</label>
                                </div>
                            </div>
                        </td>
                        <td>
                            <label>ค่าธรรมเนียม</label>
                            <div class="mb-3">
                                <div class="course-fee-container">
                                    <input name="course_fee" type="number" id="course_fee" class="course_fee" placeholder="ค่าธรรมเนียม" oninput="this.className = ''">
                                    <label class="l1"> บาท</label>
                                </div>
                            </div>
                        </td>
                        <td>
                            <label>ไฟล์เนื้อหาหลักสูตร</label>
                            <div class="mb-3">
                                <div class="course-totalHours-container">
                                    <input name="course_file" type="file" id="course_file" accept="file/*" class="form-control"/>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3">
                            <div class="mb-3">
                                <div class="form-floating">
                                    <textarea class="form-control" placeholder="" id="floatingTextarea3" name="course_targetOccupation" style="height: 100px"></textarea>
                                    <label for="floatingTextarea3">เป้าหมายกลุ่มอาชีพ</label>
                                </div>
                            </div>
                        </td>
                    </tr>
                </table>
            </div>

            <!-- step three -->
            <div class="step">
                <h2 class="text-center mb-4">รายละเอียดหลักสูตร</h2>

                <div>
                    <h3>ข้อมูลจาก Step 1</h3>
                    <p>ประเภทหลักสูตร: <span id="displayCourseType"></span></p>
                    <p>ชื่อหลักสูตร: <span id="displayCourseName"></span></p>
                    <p>ชื่อเกียรติบัตร: <span id="displayCertificateName"></span></p>
                    <p>สาขาวิชา: <span id="displayMajor"></span></p>
                    <p>หลักการและเหตุผล: <span id="displayCoursePrinciple"></span> </p>
                    <img id="displayPreview" src="" alt="Image Preview" style="display: none; height: 170px; margin-top: 10px; border-radius: 10px">
                    <!-- เพิ่มข้อมูลอื่น ๆ ที่คุณต้องการแสดงจาก Step 1 -->
                </div>

                <div>
                    <h3>ข้อมูลจาก Step 2</h3>
                    <p>วัตถุประสงค์: <span id="displayObjectives"></span></p>
                    <p>ระยะเวลาในการเรียน: <span id="displayTotalHours"></span> ชั่วโมง</p>
                    <p>ค่าธรรมเนียม: <span id="displayFee"></span> บาท</p>
                    <p>ไฟล์เนื้อหาหลักสูตร: <span id="displayCourseFile"></span></p>
                    <p>เป้าหมายกลุ่มอาชีพ: <span id="displayTargetOccupation"></span></p>
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

<%--<div align="center">--%>
<%--    <h1>${title}</h1>--%>
<%--    <div class="list_course_detail" align="center">--%>
<%--        <div class="hr_line"></div>--%>
<%--        <button id="FClick" class="tablinks" onclick="openList(event, 'form1')">Step 1</button>--%>
<%--        <button class="tablinks" onclick="openList(event, 'form2')">Step 2</button>--%>
<%--        <button class="tablinks" onclick="openList(event, 'form3')">Step 3</button>--%>
<%--    </div>--%>

<%--    <form action="${pageContext.request.contextPath}/register_member/save" name="frm" method="POST" onsubmit="return confirmSubmit();">--%>
<%--        <!-- Form 1 -->--%>
<%--        <div id="form1" class="block_form1 tabcontent">--%>
<%--            <table>--%>
<%--                <tr>--%>
<%--                    <td>บัตรประชาชน</td>--%>
<%--                    <td></td>--%>
<%--                </tr>--%>
<%--                <tr>--%>
<%--                    <td colspan="3"><input name="idcard" id="idcard" type="text" class="input_idcard"/></td>--%>
<%--                </tr>--%>
<%--                <tr>--%>
<%--                    <td>ชื่อ</td>--%>
<%--                    <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>--%>
<%--                    <td>นามสกุล</td>--%>
<%--                </tr>--%>
<%--                <tr>--%>
<%--                    <td><input name="firstName" id="firstName" type="text" name="firstname"/></td>--%>
<%--                    <td></td>--%>
<%--                    <td><input name="lastName" id="lastName" type="text" name="lastname"/></td>--%>
<%--                </tr>--%>
<%--            </table>--%>
<%--        </div>--%>

<%--        <!-- Form 2 -->--%>
<%--        <div id="form2" class="block_form2 tabcontent">--%>
<%--            <table style="width: 100%;">--%>
<%--                <tr>--%>
<%--                    <td>วันเดือนปีเกิด</td>--%>
<%--                    <td></td>--%>
<%--                </tr>--%>
<%--                <tr>--%>
<%--                    <td colspan="2"><input name="birthday" id="datePicker" type="date" style="width: 50%;"/></td>--%>
<%--                </tr>--%>
<%--                <tr>--%>
<%--                    <td>--%>
<%--                        <input type="radio" name="gender" value="Male">--%>
<%--                        <label>ชาย</label>--%>
<%--                        <input type="radio" name="gender" value="Female">--%>
<%--                        <label>หญิง</label>--%>
<%--                    </td>--%>
<%--                </tr>--%>
<%--                <tr>--%>
<%--                    <td>เบอร์โทร</td>--%>
<%--                </tr>--%>
<%--                <tr>--%>
<%--                    <td colspan="2"><input name="tel" id="tel" type="text" name="tel"/></td>--%>
<%--                </tr>--%>
<%--                <tr>--%>
<%--                    <td>อีเมล</td>--%>
<%--                </tr>--%>
<%--                <tr>--%>
<%--                    <td colspan="3"><input name="email" id="email" type="text" name="email"/></td>--%>
<%--                </tr>--%>
<%--                <tr>--%>
<%--                    <td>การศึกษา</td>--%>
<%--                </tr>--%>
<%--                <tr>--%>
<%--                    <td colspan="3">--%>
<%--                        <select id="education" name="education">--%>
<%--                            <option value="ระดับมัธยมศึกษา">ระดับมัธยมศึกษา</option>--%>
<%--                            <option value="ระดับอาชีวศึกษา">ระดับอาชีวศึกษา</option>--%>
<%--                            <option value="ระดับอุดมศึกษา">ระดับอุดมศึกษา</option>--%>
<%--                            <option value="ปริญญาตรี">ปริญญาตรี</option>--%>
<%--                            <option value="ปริญญาโท">ปริญญาโท</option>--%>
<%--                            <option value="ปริญญาเอก">ปริญญาเอก</option>--%>
<%--                        </select>--%>
<%--                    </td>--%>
<%--                </tr>--%>
<%--            </table>--%>
<%--        </div>--%>

<%--        <!-- Form 3 -->--%>
<%--        <div id="form3" class="block_form2 tabcontent">--%>
<%--            <table style="width: 100%;">--%>
<%--                <tr>--%>
<%--                    <td>ชื่อ</td>--%>
<%--                </tr>--%>
<%--                <tr>--%>
<%--                    <td><input type="text" name="username" id="username" placeholder="Username"></td>--%>
<%--                </tr>--%>
<%--                <tr>--%>
<%--                    <td><a id="link" href="#">ตรวจสอบ</a> &nbsp; <label id="status"></label></td>--%>
<%--                </tr>--%>
<%--                <tr>--%>
<%--                    <td>นามสกุล</td>--%>
<%--                </tr>--%>
<%--                <tr>--%>
<%--                    <td><input name="password" id="password" type="password" placeholder="Password"/></td>--%>
<%--                </tr>--%>
<%--                <tr>--%>
<%--                    <td>--%>
<%--                        <input type="submit" value="สมัครสมาชิก" />--%>
<%--                    </td>--%>
<%--                </tr>--%>
<%--            </table>--%>
<%--        </div>--%>
<%--    </form>--%>
<%--</div>--%>





<jsp:include page="/WEB-INF/view/layouts/footer.jsp"/>


</body>
<script>
    window.addEventListener('DOMContentLoaded', (event) => {
        var button = document.getElementById('FClick');
        button.click()
    });

    function openList(evt, list_name) {
        var i, tabcontent, tablinks;
        tabcontent = document.getElementsByClassName("tabcontent");
        for (i = 0; i < tabcontent.length; i++) {
            tabcontent[i].style.display = "none";
        }
        tablinks = document.getElementsByClassName("tablinks");
        for (i = 0; i < tablinks.length; i++) {
            tablinks[i].className = tablinks[i].className.replace(" active", "");
        }
        document.getElementById(list_name).style.display = "block";
        evt.currentTarget.className += " active";
    }


    /******************************************/

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

    /**********************************************/

    function confirmSubmit() {
        return confirm("ยืนยันการสมัครสมาชิก");
    }

    <%------------- bootstrap Start ----------------%>

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

    <%------------- bootstrap End ----------------%>

</script>
</html>
