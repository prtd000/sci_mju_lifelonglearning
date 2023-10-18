<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 10/7/2023
  Time: 12:17 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="lifelong.model.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
    <jsp:include page="/WEB-INF/view/layouts/detail-all-style.jsp"/>
    <!-- google font -->
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&display=swap" rel="stylesheet">
    <link href="https://cdn.quilljs.com/1.3.6/quill.snow.css" rel="stylesheet">
    <script src="https://cdn.quilljs.com/1.3.6/quill.js"></script>
    <link href="https://fonts.googleapis.com/css?family=Raleway" rel="stylesheet">

    <script>
        function previewImage(input) {
            var preview = document.getElementById('preview');
            var displayPreview = document.getElementById('displayPreview');
            var fileInput = document.getElementById('fileInput');

            var file = input.files[0];

            if (!file) {
                alert("กรุณาเลือกรูปภาพ");
                return;
            }

            var allowedExtensions = /(\.png|\.jpg|\.jpeg)$/i;
            var maxFileSize = 2 * 1024 * 1024; // 2MB

            if (!allowedExtensions.exec(file.name)) {
                alert("รูปภาพต้องเป็นไฟล์นามสกุล png, jpg, หรือ jpeg เท่านั้น");
                input.value = "";
                return;
            }else {
                document.getElementById("invalidImg").innerHTML = "";
            }

            if (file.size > maxFileSize) {
                alert("ขนาดไฟล์รูปภาพต้องไม่เกิน 2MB");
                input.value = "";
                return;
            }

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
    <!--Internal CSS start-->
    <style>
    #editor {
        width: 100%;
        height: 500px;
        border: 1px solid #ccc;
        padding: 10px;
        font-size: 16px;
    }
    .toolbar {
        background-color: #f2f2f2;
        padding: 5px;
    }
    .toolbar button {
        margin: 5px;
        padding: 3px 10px;
        font-size: 14px;
    }
</style>
    <style>
        * {
            box-sizing: border-box;
        }

        body {
            background-color: #f1f1f1;
        }

        #regForm {
            background-color: #ffffff;
            margin: 100px auto;
            font-family: Raleway;
            padding: 40px;
            width: 70%;
            min-width: 300px;
            border-radius: 15px;
        }

        h1 {
            text-align: center;
        }

        input {
            padding: 10px;
            width: 100%;
            font-size: 17px;
            font-family: Raleway;
            border: 1px solid #aaaaaa;
        }

        /* Mark input boxes that gets an error on validation: */
        input.invalid {
            background-color: #ffdddd;
        }

        /* Hide all steps by default: */
        .tab {
            display: none;
        }

        button {
            background-color: #04AA6D;
            color: #ffffff;
            border: none;
            padding: 10px 20px;
            font-size: 17px;
            font-family: Raleway;
            cursor: pointer;
        }

        button:hover {
            opacity: 0.8;
        }

        #prevBtn {
            background-color: #bbbbbb;
        }

        /* Make circles that indicate the steps of the form: */
        .step {
            height: 15px;
            width: 15px;
            margin: 0 2px;
            background-color: #bbbbbb;
            border: none;
            border-radius: 50%;
            display: inline-block;
            opacity: 0.5;
        }

        .step.active {
            opacity: 1;
        }

        /* Mark the steps that are finished and valid: */
        .step.finish {
            background-color: #04AA6D;
        }
        .flex-div-container,.objective-container{
            width: 100%;
            display: flex;
            align-items: center;
        }
    </style>
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
<c:set var="flag" value="<%= flag %>"></c:set>
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
<c:choose>
    <c:when test="${flag.equals('admin')}">
        <% assert admin != null; %>
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
                    <a href="#" class="nav-item nav-link" style="font-size: 18px">เกี่ยวกับคณะ</a>
                    <a href="${pageContext.request.contextPath}/course/<%=admin.getUsername()%>/add_course" class="nav-item nav-link active" style="font-size: 17px">เพิ่มหลักสูตร</a>
                    <a href="${pageContext.request.contextPath}/course/<%=admin.getUsername()%>/list_all_course" class="nav-item nav-link" style="font-size: 17px">หลักสูตรทั้งหมด</a>
                    <a href="${pageContext.request.contextPath}/course/<%=admin.getUsername()%>/list_request_open_course" class="nav-item nav-link" style="font-size: 17px">รายการร้องขอ</a>
                    <a href="${pageContext.request.contextPath}/course/public/add_activity" class="nav-item nav-link" style="font-size: 17px">เพิ่มข่าวสารทั่วไป</a>
                    <a href="${pageContext.request.contextPath}/course/public/list_activity" class="nav-item nav-link" style="font-size: 17px">ข่าวสารและกิจกรรม</a>
                    <a href="#" class="nav-item nav-link" style="font-size: 17px">ผู้ดูแลระบบ</a>
                    <a href="${pageContext.request.contextPath}/doLogout" class="nav-item nav-link" style="font-size: 17px">ออกจากระบบ</a>
                </div>
            </div>
        </nav>
        <!-- Navbar End -->
        <form id="regForm" action="${pageContext.request.contextPath}/course/<%=admin.getUsername()%>/save" method="POST" enctype="multipart/form-data" onsubmit="return confirmAction();" name="frm" style="width: 95%; margin-top: 15px;">
            <h1 style="text-align-last: start;">เพิ่มหลักสูตรใหม่</h1>
            <hr>
            <!-- One "tab" for each step in the form: -->
            <div class="tab">
                <table style="width: 100%">
                    <tr>
                        <td style="width: 70%;">
                            <div class="mb-3" style="width: 100%; display: flex">
                                <div style="width: 50%">
                                    <label>ประเภทหลักสูตร</label>
                                    <select class="form-select" name="course_type" id="course_type" aria-label="Default select example">
                                        <option value="">--กรุณาเลือกหลักสูตร--</option>
                                        <option value="หลักสูตรอบรมระยะสั้น">หลักสูตรอบรมระยะสั้น</option>
                                        <option value="Non-Degree">Non-Degree</option>
                                    </select>
                                    <label id="invalidCourseType" style="color: red; font-size: 12px"></label>
                                </div>
                                <div style="width: 50%">
                                    <label>สาขา:</label>
                                    <select name="major_id" id="major_id" class="form-select">
                                        <option value="" >--กรุณาเลือกสาขา--</option>
                                        <c:forEach items="${majors}" var="major">
                                            <option value="${major.major_id}">${major.name}</option>
                                        </c:forEach>
                                    </select>
                                    <label id="invalidMajor" style="color: red; font-size: 12px"></label>
                                </div>
                            </div>
                            <label>ชื่อหลักสูตร</label>
                            <div class="mb-3">
                                <input name="course_name" type="text" id="course_name" placeholder="ชื่อหลักสูตร" oninput="this.className = ''"/>
                                <a id="link" href="#">ตรวจสอบ</a> &nbsp; <label id="status"></label>
                                <label id="invalidCourseName" style="color: red; font-size: 12px"></label>
                            </div>
                            <label>ชื่อเกียรติบัตร</label>
                            <div class="mb-3">
                                <input name="certificateName" type="text" id="certificateName" placeholder="ชื่อเกียรติบัตร" oninput="this.className = ''"/>
                                <label id="invalidCertificateName" style="color: red; font-size: 12px"></label>
                            </div>
                            <label>รูปหลักสูตร</label>
                            <div class="mb-3">
                                <input name="course_img" type="file" id="fileInput" accept="image/*" onchange="previewImage(this)" class="form-control"/>
                                <label id="invalidImg" style="color: red; font-size: 12px"></label>
                            </div>
                        </td>
                        <td style="width: 30%; vertical-align: top;">
                            <div class="mb-3" align="center">
                                <img id="preview" src="" alt="Image Preview" style="display: none; height: 300px; margin-top: 10px; border-radius: 10px">
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <label>หลักการและเหตุผล</label>
                            <div class="form-floating">
                                <div class="toolbar">
                                    <button type="button" onclick="boldText()">Bold</button>
                                    <button type="button" onclick="italicText()">Italic</button>
                                    <button type="button" onclick="underlineText()">Underline</button>
                                </div>
                                <div id="editor" contenteditable="true" name="course_principle">
                                    <!-- เริ่มเพิ่มเนื้อหาของ Text Editor ที่นี่ -->
                                </div>
                            </div>
                            <label id="invalidPrinciple" style="color: red; font-size: 12px"></label>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="tab">
                <label>วัตถุประสงค์</label>
                <div>
                    <div class="mb-3">
                        <div id="objectives-container">
                            <div class="objective-container">
                                <input name="course_objectives[]" type="text" id="course_object" oninput="this.className = ''" class="objective"/>
                                <button type="button" onclick="removeObjective(this)" class="btn btn-danger">ลบ</button>
                            </div>
                        </div>
                        <button type="button" onclick="addObjective()">เพิ่มวัตถุประสงค์</button>
                    </div>
                    <label id="invalidObjective" style="color: red; font-size: 12px"></label>
                </div>

                <label>ค่าธรรมเนียม</label>
                <div class="mb-3">
                    <table>
                        <tr style="vertical-align: text-top;">
                            <td style="width: 35px;"><input type="radio" name="CFee" value="ไม่มีค่าธรรมเนียม"></td>
                            <td><label>ไม่มีค่าธรรมเนียม</label></td>
                            <td style="width: 35px;"><input type="radio" name="CFee" value="มีค่าธรรมเนียม"></td>
                            <td><label>มีค่าธรรมเนียม</label></td>
                            <td id="fee" style="display: none; margin-left: 10px;">
                                <div class="input-group mb-3" style="display: -webkit-box;">
                                    <input value="0" style="width: 325px;" name="course_fee" type="number" class="form-control" id="course_fee" placeholder="ค่าธรรมเนียม" aria-describedby="basic-addon2">
                                    <span class="input-group-text" id="basic-addon1">บาท</span>
                                </div>
                                <label id="invalidCourseFee" style="color: red; font-size: 12px"></label>
                            </td>
                        </tr>
                        <label id="invalidSelectFee" style="color: red; font-size: 12px"></label>
                    </table>
                </div>

                <div class="flex-div-container">
                    <div style="width: 50%">
                        <label>ระยะเวลาในการเรียน</label>
                            <div class="input-group mb-3" style="display: -webkit-box;">
                                <input style="width: 600px;" name="course_totalHours" type="number" class="form-control" id="course_totalHours" oninput="this.className = ''" placeholder="ระยะเวลาในการเรียน" aria-describedby="basic-addon2">
                                <span class="input-group-text" id="basic-addon2">ชั่วโมง</span>
                            </div>
                            <label id="invalidCourseTotalHours" style="color: red; font-size: 12px"></label>
                    </div>
                    <div style="width: 50%">
                        <label>ไฟล์เนื้อหาหลักสูตร</label>
                        <div class="mb-3">
                            <div class="course-totalHours-container">
                                <input name="course_file" type="file" id="course_file" accept="file/*" onchange="checkFile(this)" class="form-control"/>
                            </div>
                            <label id="invalidCourseFile" style="color: red; font-size: 12px"></label>
                        </div>
                    </div>
                </div>
                <div class="mb-3">
                    <div class="form-floating">
                        <textarea class="form-control" placeholder="" id="floatingTextarea3" name="course_targetOccupation" style="height: 100px"></textarea>
                        <label for="floatingTextarea3">เป้าหมายกลุ่มอาชีพ</label>
                    </div>
                    <label id="invalidCourseTargetOccupation" style="color: red; font-size: 12px"></label>
                </div>
            </div>
            <div class="tab">
                <div><h5 id="displayCourseType"></h5></div>
                <div><h2 id="displayCourseName"></h2></div>
                <div><h4 id="displayMajor"></h4></div>
                
                <div><h5>ชื่อเกียรติบัตร : <span id="displayCertificateName"></span></h5></div>
                <hr>
                <div style="width: 100%">

                </div>
                <div style="width: 100%; display: flex">
                    <div style="width: 70%;vertical-align: text-bottom;">
                        <b><label style="font-size: 18px">หลักการ และเหตุผล</label></b>
                        <label id="displayCoursePrinciple" style="font-size: 15px"></label>
                        <input type="text" id="coursePrinciple" name="coursePrinciple" style="display: none">
                        <hr>
                        <b><label style="font-size: 18px">วัตถุประสงค์</label></b><br>
                        <span id="displayObjectives"></span>
                        <hr>
                        <div style="display:flex; width: 100%">
                            <div><b>ค่าธรรมเนียม : </b><span id="displayFee" style="margin-right: 20px"></span></div>
                            <div><b>ระยะเวลาในการเรียน : </b><span id="displayTotalHours" style="margin-right: 20px"></span> ชั่วโมง</div>
                        </div>
                        <hr>
                        <div>
                            <b><label style="font-size: 18px">เป้าหมายกลุ่มอาชีพ</label></b><br>
                            <span id="displayTargetOccupation" style="margin-right: 20px"></span>
                        </div>
<%--                        ไฟล์หลักสูตร : <span id="displayCourseFile"></span>--%>
                    </div>
                    <div style="width: 30%; writing-mode: vertical-rl;">
                        <img id="displayPreview" src="" alt="Image Preview" style="display: none; width: 400px; margin-top: 10px; border-radius: 10px">
                    </div>
                </div>
            </div>
            <div style="overflow:auto;">
                <div style="float:right; margin-top: 60px;">
                    <button type="button" id="prevBtn" onclick="nextPrev(-1)">ย้อนกลับ</button>
                    <button type="button" id="nextBtn" onclick="nextPrev(1)">ต่อไป</button>
                </div>
            </div>
            <!-- Circles which indicates the steps of the form: -->
            <div style="text-align:center;margin-top:40px;">
                <span class="step"></span>
                <span class="step"></span>
                <span class="step"></span>
            </div>
        </form>
    </c:when>
    <c:when test="${flag.equals('null')}">
        <h1>กรุณา Log in ใหม่</h1>
        <a href="${pageContext.request.contextPath}/">กลับหน้าหลัก</a>
    </c:when>
    <c:otherwise>
        <h1>คุณไม่มีสิทธิในหน้านี้</h1>
    </c:otherwise>
</c:choose>
</body>
<script>
    // เรียกฟังก์ชันเมื่อมีการเลือกสาขา
    document.getElementById("major_id").addEventListener("change", function () {
        // รับค่าที่ถูกเลือก
        var selectedMajor = document.getElementById("major_id").value;

        // ค้นหาชื่อสาขาที่ถูกเลือกจาก dropdown
        var majors = document.querySelectorAll("#major_id option");
        var selectedMajorName = "";
        for (var i = 0; i < majors.length; i++) {
            if (majors[i].value === selectedMajor) {
                selectedMajorName = majors[i].textContent;
                break;
            }
        }

        // แสดงชื่อสาขาใน <h4> element
        document.getElementById("displayMajor").textContent = selectedMajorName;
    });
</script>
<script>
    function boldText() {
        document.execCommand('bold', false, null);
    }

    function italicText() {
        document.execCommand('italic', false, null);
    }

    function underlineText() {
        document.execCommand('underline', false, null);
    }
</script>
<script>
    function confirmAction() {
        var result = confirm("คุณแน่ใจหรือไม่ว่าต้องการเพิ่มหลักสูตรนี้?");
        if (result) {
            return true; // ถ้าผู้ใช้กด OK ให้ทำงานตามปกติ
        } else {
            return false; // ถ้าผู้ใช้กด Cancel ให้ยกเลิกการส่งฟอร์ม
        }
    }
</script>
<script>
    var currentTab = 0; // Current tab is set to be the first tab (0)
    showTab(currentTab); // Display the current tab
    function showTab(n) {
        // This function will display the specified tab of the form...
        var x = document.getElementsByClassName("tab");
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
        var x = document.getElementsByClassName("tab");
        // Exit the function if any field in the current tab is invalid:
        // if (currentTab === 0&& !validateStep1()) {
        //     validateStep1();
        // }
        if (n == 1 && !validateForm()) return false;
        // Hide the current tab:
        x[currentTab].style.display = "none";
        // Increase or decrease the current tab by 1:
        currentTab = currentTab + n;
        // if you have reached the end of the form...
        // if (currentTab >= x.length) {
        //     // ... the form gets submitted:
        //     document.getElementById("regForm").submit();
        //     return false;
        // }
        if (currentTab >= x.length) {
            var confirmed = confirmAction();
            if (confirmed) {
                document.getElementById("regForm").submit();
                return false;
            } else {
                currentTab = currentTab - 1; // ย้อนกลับไปที่ขั้นตอนก่อนหน้า
            }
        }
        // Otherwise, display the correct tab:
        showTab(currentTab);
    }

    function validateForm() {
        // This function deals with validation of the form fields
        var x, y, i, valid = true;
        x = document.getElementsByClassName("tab");
        y = x[currentTab].getElementsByTagName("input");
        // A loop that checks every input field in the current tab:
        for (i = 0; i < y.length; i++) {
            // If a field is empty...checkScriptPage1()
            if (y[i].value == "") {
                // add an "invalid" class to the field:
                y[i].className += " invalid";
                // and set the current valid status to false
                valid = false;
            }
        }
        if (currentTab === 0) {
            // ตรวจสอบข้อมูลใน Step 1
            if (!checkScriptPage1()) {
                return false;
            }
        }
        if (currentTab === 1) {
            // ตรวจสอบข้อมูลใน Step 2
            if (!checkScriptPage2()) {
                return false;
            }
        }
        // If the valid status is true, mark the step as finished and valid:
        if (valid) {
            document.getElementsByClassName("step")[currentTab].className += " finish";
        }
        return valid; // return the valid status
    }

    // function validateForm() {
    //     if (currentTab === 0) {
    //         // ตรวจสอบข้อมูลใน Step 1
    //         if (!checkScriptPage1()) {
    //             return false;
    //         }
    //     }
    //     // เพิ่มเงื่อนไขการตรวจสอบข้อมูลในขั้นตอนอื่น ๆ ตามต้องการ
    //     return true;
    // }

    function fixStepIndicator(n) {
        // This function removes the "active" class of all steps...
        var i, x = document.getElementsByClassName("step");
        for (i = 0; i < x.length; i++) {
            x[i].className = x[i].className.replace(" active", "");
        }
        //... and adds the "active" class on the current step:
        x[n].className += " active";
    }
</script>
<script>
    /************ Check Course ******************/

    document.getElementById('link').addEventListener('click', function (event) {
        event.preventDefault(); // ป้องกันการนำทางเมื่อคลิกลิงก์

        const stt = document.getElementById("status");
        const courseElement = document.getElementById("course_name").value;
        let courseFound = false;

        <c:forEach var="c" items="${course}">
        if ("${c.name}".trim() === courseElement.trim()) {
            stt.innerHTML = "มีหลักสูตรนี้ในระบบแล้ว";
            stt.style.color = "red"
            document.getElementById("invalidCourseName").innerHTML = "";
            courseFound = true;
        }
        </c:forEach>

        if (!courseFound) {
            if(courseElement === ""){
                document.getElementById("invalidCourseName").innerHTML = "กรุณากรอกชื่อหลักสูตรก่อน";
                stt.innerHTML = "";
            }else {
                stt.innerHTML = "สามารถใช้งานได้";
                stt.style.color = "green";
                document.getElementById("invalidCourseName").innerHTML = "";
            }
        }
    });
</script>
<script>
    function checkFile(input) {
        var file = input.files[0];

        if (!file) {
            alert("กรุณาเลือกไฟล์หลักสูตร");
            return;
        }

        var allowedExtensions = /(\.pdf)$/i;
        var maxFileSize = 10 * 1024 * 1024; // 2MB

        if (!allowedExtensions.exec(file.name)) {
            alert("ต้องเป็นไฟล์ PDF เท่านั้น");
            input.value = "";
            return;
        }else {
            document.getElementById("invalidCourseFile").innerHTML = "";
        }

        if (file.size > maxFileSize) {
            alert("ขนาดไฟล์รูปภาพต้องไม่เกิน 10MB");
            input.value = "";
        }
    }
</script>
<script>
    function checkScriptPage1(){
        //------------course_type--------------
        if (document.getElementById("course_type").value === "") {
            // alert("กรุณาเลือกประเภทหลักสูตร");
            document.getElementById("invalidCourseType").innerHTML = "กรุณาเลือกประเภทหลักสูตร";
            document.getElementById("course_type").focus();
            return false;
        }else {
            document.getElementById("invalidCourseType").innerHTML = "";
        }
        //------------major--------------
        if (document.getElementById("major_id").value === "") {
            // alert("กรุณาเลือกสาขา");
            document.getElementById("invalidMajor").innerHTML = "กรุณาเลือกสาขา";
            document.getElementById("major_id").focus();
            return false;
        }else {
            document.getElementById("invalidMajor").innerHTML = "";
        }
        //-------------course_name-------------
        var regCName = /^[A-Za-z0-9ก-๙() ]{2,225}$/;
        var stt = document.getElementById("status");
        var courseElement = document.getElementById("status").innerHTML;

        document.getElementById("link").click();
        if(document.getElementById("course_name").value === ""){
            // alert("กรุณากรอกชื่อหลักสูตร");
            stt.innerHTML = "";
            document.getElementById("invalidCourseName").innerHTML = "กรุณากรอกชื่อหลักสูตร";
            document.getElementById("course_name").focus();
            return false;
        }else if (!document.getElementById("course_name").value.match(regCName)) {
            // alert("ตัองเป็นภาษาไทย อังกฤษหรือตัวเลขเท่านั้น");
            stt.innerHTML = "";
            document.getElementById("invalidCourseName").innerHTML = "ตัองเป็นภาษาไทย อังกฤษหรือตัวเลขเท่านั้น และต้องมีจำนวน 2-225 ตัวอักษร";
            document.getElementById("course_name").focus();
            document.getElementById("course_name").value = "";
            return false;
        }
        else if (courseElement === "" || courseElement === "มีหลักสูตรนี้ในระบบแล้ว"){
            document.getElementById("course_name").focus();
            alert("กรุณาตรวจสอบชื่อหลักสูตรก่อน");
            return false;
        }else {
            document.getElementById("invalidCourseName").innerHTML = "";
        }

        //---------certificateName----------
        var regCerName = /^[A-Za-z0-9ก-๙() ]{2,225}$/;
        if (document.getElementById("certificateName").value === ""){
            // alert("กรุณากรอกชื่อเกียรติบัตร");
            document.getElementById("invalidCertificateName").innerHTML = "กรุณากรอกชื่อเกียรติบัตร";
            document.getElementById("certificateName").focus();
            return false;
        } else if (!document.getElementById("certificateName").value.match(regCerName)) {
            // alert("ตัองเป็นภาษาไทย อังกฤษหรือตัวเลขเท่านั้น");
            document.getElementById("invalidCertificateName").innerHTML = "ตัองเป็นภาษาไทย อังกฤษหรือตัวเลขเท่านั้น และต้องมีจำนวน 2-225 ตัวอักษร";
            document.getElementById("certificateName").focus();
            document.getElementById("certificateName").value = "";
            return false;
        }else {
            document.getElementById("invalidCertificateName").innerHTML = "";
        }
        //--------------course_principle--------------------
        var editorContent = document.getElementById("editor").textContent;
        if (editorContent.trim() === "") {
            document.getElementById("invalidPrinciple").innerHTML = "กรุณากรอกหลักการและเหตุผล";
            document.getElementById("editor").focus();
            return false;
        }else {
            document.getElementById("invalidPrinciple").innerHTML = "";
        }

        checkScriptPage1IMG();

        return true;

    }
    function checkScriptPage1IMG(){
        if (document.getElementById("fileInput").files.length === 0) {
            // alert("กรุณาเลือกรูปภาพหลักสูตร");
            document.getElementById("invalidImg").innerHTML = "กรุณาเลือกรูปภาพหลักสูตร";
            document.getElementById("fileInput").focus();
            return false;
        }
    }

    function checkScriptPage2(){
        //---------------objectives--------------------
        var regExName = /^[ก-์A-Za-z0-9 ]{2,225}$/;
        var objectives = document.querySelectorAll("input[name='course_objectives[]']");
        for (var i = 0; i < objectives.length; i++) {
            if (objectives[i].value === "") {
                document.getElementById("invalidObjective").innerHTML = "กรุณากรอกวัตถุประสงค์ทั้งหมด";
                objectives[i].focus();
                return false;
            }else if (!regExName.test(objectives[i].value)){
                document.getElementById("invalidObjective").innerHTML = "วัตถุประสงค์ต้องประกอบด้วยอักขระภาษาไทย อังกฤษ ตัวเลข และมีจำนวน 2-225 ตัวอักษร";
                objectives[i].focus();
                return false;
            }
            else {
                document.getElementById("invalidObjective").innerHTML = "";
            }
        }

        //------------FeeType-------------
        var FeeTypecheck = document.getElementsByName('CFee');
        var FeeTypenull = false;
        for (var i = 0; i < FeeTypecheck.length; i++) {
            if (FeeTypecheck[i].checked) {
                FeeTypenull = true;
                break;
            }
        }
        if (!FeeTypenull) {
            alert("กรุณาเลือกประเภทค่าธรรมเนียม");
            return false;
        }

        var feeRadio = document.querySelector('input[name="CFee"][value="มีค่าธรรมเนียม"]');
            if (feeRadio.checked) {
                var fee = document.getElementById("course_fee").value; // อ่านค่า fee ภายในฟังก์ชันที่ถูกเรียกในระหว่างการเปลี่ยนแปลง
                if (parseInt(fee) < 1 || parseInt(fee) > 999999) {
                    document.getElementById("invalidCourseFee").innerHTML = "ต้องมีค่าระหว่าง 1 - 999,999 บาท";
                    document.getElementById("course_fee").focus();
                    return false;
                } else {
                    document.getElementById("invalidCourseFee").innerHTML = "";
                }
        }


        //---------CourseTotalHours----------
        if (document.getElementById("course_totalHours").value === ""){
            // alert("กรุณากรอกชื่อเกียรติบัตร");
            document.getElementById("invalidCourseTotalHours").innerHTML = "กรุณากรอกระยะเวลาในการเรียน";
            document.getElementById("course_totalHours").focus();
            return false;
        } else if(parseInt(document.getElementById("course_totalHours").value) < 1 || parseInt(document.getElementById("course_totalHours").value) > 999999){
            // alert("ตัองเป็นภาษาไทย อังกฤษหรือตัวเลขเท่านั้น");
            document.getElementById("invalidCourseTotalHours").innerHTML = "ต้องมีค่าระหว่าง 1 - 999,999 บาท";
            document.getElementById("course_totalHours").focus();
            document.getElementById("course_totalHours").value = "";
            return false;
        }else {
            document.getElementById("invalidCourseTotalHours").innerHTML = "";
        }

        // //---------Target Occupation----------
        // var targetOccupation = document.getElementById("floatingTextarea3").value;
        // var regExTargetOccupation = /^[ก-์A-Za-z0-9 ,]{2,225}$/;
        // if (targetOccupation === "") {
        //     document.getElementById("invalidCourseTargetOccupation").innerHTML = "กรุณากรอกกลุ่มเป้าหมายอาชีพ";
        //     document.getElementById("floatingTextarea3").focus();
        //     return false;
        // }else if (!regExTargetOccupation.test(targetOccupation)){
        //     document.getElementById("invalidCourseTargetOccupation").innerHTML = "ต้องประกอบด้วยอักขระภาษาไทย อังกฤษ ตัวเลข และมีจำนวน 2-225 ตัวอักษร";
        //     document.getElementById("floatingTextarea3").focus();
        //     return false;
        // } else {
        //     document.getElementById("invalidCourseTargetOccupation").innerHTML = "";
        // }

        checkScriptPage2FILE();

        return true;
    }
    function checkScriptPage2FILE(){
        //----------------Course File----------------------
        // ตรวจสอบว่าผู้ใช้เลือกไฟล์เนื้อหาหลักสูตรหรือไม่
        var courseFile = document.getElementById("course_file").value;
        if (courseFile === "") {
            document.getElementById("invalidCourseFile").innerHTML = "กรุณาเลือกไฟล์เนื้อหาหลักสูตร";
            document.getElementById("course_file").focus();
            return false;
        }else if (!courseFile === ""){

        } else {
            document.getElementById("invalidCourseFile").innerHTML = "";
        }
    }

    function display(){
        const courseType = document.getElementById("course_type").value;
        const courseName = document.getElementById("course_name").value;
        const certificateName = document.getElementById("certificateName").value;
        const major = document.getElementById("major_id").value;
        const editorContent = document.getElementById("editor").textContent;

        const objectives = document.querySelectorAll("input[name='course_objectives[]']");
        const totalHours = document.getElementById("course_totalHours").value;
        const fee = document.getElementById("course_fee").value;
        const courseFile = document.getElementById("course_file").value;
        const targetOccupation = document.getElementById("floatingTextarea3").value;

        document.getElementById("displayCourseName").innerHTML = courseName;
        document.getElementById("displayCourseType").innerHTML = courseType;
        document.getElementById("displayCertificateName").innerHTML = certificateName;

        // document.getElementById("displayMajor").innerHTML = major;
        document.getElementById("displayCoursePrinciple").innerHTML = editorContent;
        document.getElementById('coursePrinciple').value = editorContent;
        // document.getElementById("displayObjectives").innerHTML = Array.from(objectives).map(obj => obj.value).join(", ");


        var list_objectives =  Array.from(objectives).map(obj => obj.value).join(", ");

        var objectivesArray = list_objectives.split(', '); // แบ่งข้อความออกเป็นอาร์เรย์โดยใช้เครื่องหมายคอมมา
        var numberedObjectives = objectivesArray.map(function (objective, index) {
            return (index + 1) + '.' + objective.trim(); // เพิ่มเลขลำดับและลบช่องว่างที่เป็นที่ไม่จำเป็น
        });
        var result = numberedObjectives.join('<br>'); // รวมอาร์เรย์ของข้อความเป็นข้อความหนึ่งๆ โดยใช้เครื่องหมายขึ้นบรรทัดใหม่
        document.getElementById("displayObjectives").innerHTML = result;


        document.getElementById("displayTotalHours").innerHTML = totalHours;
        if (parseInt(fee) === 0){
            document.getElementById("displayFee").innerHTML = "ไม่มีค่าธรรมเนียม";
        }else {
            document.getElementById("displayFee").innerHTML = fee+" บาท";
        }
        // document.getElementById("displayCourseFile").innerHTML = courseFile;
        if (targetOccupation === ""){
            document.getElementById("displayTargetOccupation").innerHTML = "ไม่มีกลุ่มเป้าหมาย";
        }else {
            document.getElementById("displayTargetOccupation").innerHTML = targetOccupation;
        }
    }
    document.getElementById("nextBtn").addEventListener("click", display);

    // function checkScript() {
    //     if (currentTab === 0) {
    //         // ตรวจสอบข้อมูลใน Step 1
    //         if (!checkScriptPage1()) {
    //             return false;
    //         }
    //     }
    //     if (currentTab === 1) {
    //         // ตรวจสอบข้อมูลใน Step 2
    //         if (!checkScriptPage2()) {
    //             return false;
    //         }
    //     }
    //     // เพิ่มเงื่อนไขการตรวจสอบข้อมูลในขั้นตอนอื่น ๆ ตามต้องการ
    //     display();
    //     return true;
    // }
</script>

<%---------------------Objective--------------------------%>
<script>
    updateRemoveButtons();
    function addObjective() {
        var container = document.getElementById('objectives-container');
        var objectiveContainer = document.createElement('div');
        objectiveContainer.className = 'objective-container';

        var objectiveInput = document.createElement('input');
        objectiveInput.type = 'text';
        objectiveInput.name = 'course_objectives[]';
        objectiveInput.className = 'objective';

        var removeButton = document.createElement('button');
        removeButton.type = 'button';
        removeButton.textContent = 'ลบ';
        removeButton.className = 'btn btn-danger';
        removeButton.onclick = function() {
            container.removeChild(objectiveContainer);
            updateRemoveButtons();
        };

        objectiveContainer.appendChild(objectiveInput);
        objectiveContainer.appendChild(removeButton);
        container.appendChild(objectiveContainer);
        updateRemoveButtons();
    }

    function updateRemoveButtons() {
        var containers = document.getElementsByClassName('objective-container');
        var removeButtons = document.querySelectorAll('.objective-container button.btn-danger');

        if (containers.length === 1) {
            for (var i = 0; i < removeButtons.length; i++) {
                removeButtons[i].style.display = 'none';
            }
        } else {
            for (var i = 0; i < removeButtons.length; i++) {
                removeButtons[i].style.display = 'block';
            }
        }
    }

    function removeObjective(button) {
        var container = document.getElementById('objectives-container');
        var objectiveContainer = button.parentNode;

        if (container.getElementsByClassName('objective-container').length > 1) {
            container.removeChild(objectiveContainer);
        } else {
            alert('คุณไม่สามารถลบวัตถุประสงค์ได้อีก');
        }

        updateRemoveButtons();
    }
</script>
<%--เช็คค่าธรรมเนียม--%>
<script>
    // ตรวจสอบเมื่อเลือก "ไม่มีค่าธรรมเนียม"
    var noFeeRadio = document.querySelector('input[name="CFee"][value="ไม่มีค่าธรรมเนียม"]');
    noFeeRadio.addEventListener("change", function() {
        if (noFeeRadio.checked) {
            // ซ่อนส่วนที่มี id เป็น "fee"
            document.getElementById("fee").style.display = "none";
            document.getElementById("course_fee").value = "0";
        }
    });

    // ตรวจสอบเมื่อเลือก "มีค่าธรรมเนียม"
    var feeRadio = document.querySelector('input[name="CFee"][value="มีค่าธรรมเนียม"]');
    feeRadio.addEventListener("change", function() {
        if (feeRadio.checked) {
            // แสดงส่วนที่มี id เป็น "fee"
            document.getElementById("fee").style.display = "block";
        }
    });
</script>
</html>
