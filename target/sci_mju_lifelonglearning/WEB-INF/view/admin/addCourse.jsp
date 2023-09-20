<%@ page import="lifelong.model.*" %><%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 5/30/2023
  Time: 1:26 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPEhtml>
<html>
<head>
    <title>${title}</title>
    <jsp:include page="/WEB-INF/view/layouts/detail-all-style.jsp"/>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">

    <!-- google font -->
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&display=swap" rel="stylesheet">

    <style>
        body{
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
                    <a href="${pageContext.request.contextPath}/" class="nav-item nav-link">หน้าหลัก</a>
                    <a href="#" class="nav-item nav-link">เกี่ยวกับคณะ</a>
                        <%--            <div class="nav-item dropdown">--%>
                        <%--                <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">หลักสูตรการอบรม</a>--%>
                    <a href="${pageContext.request.contextPath}/course/<%=admin.getUsername()%>/list_all_course" class="nav-item nav-link active">หลักสูตรทั้งหมด</a>
                    <a href="${pageContext.request.contextPath}/course/public/list_activity" class="nav-item nav-link">ข่าวสารและกิจกรรม</a>
                    <a href="#" class="nav-item nav-link">Admin</a>
                    <a href="${pageContext.request.contextPath}/doLogout" class="nav-item nav-link">ออกจากระบบ</a>

                        <%--            <a href="${pageContext.request.contextPath}/login" class="nav-item nav-link">เข้าสู่ระบบ</a>--%>
                </div>
            </div>
        </nav>
        <!-- Navbar End -->
        <div id="header">
            <h1>${title}</h1>
        </div>
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
    function displayDataInStep3() {
        // ข้อมูลจาก Step 1
        const courseType = document.getElementById("course_type").value;
        const courseName = document.getElementById("course_name").value;
        const certificateName = document.getElementById("certificateName").value;
        const major = document.getElementById("major_id").value;
        const course_principle = document.getElementById("floatingTextarea2").value;

        // ข้อมูลจาก Step 2
        const objectives = document.querySelectorAll("input[name='course_objectives[]']");
        const totalHours = document.getElementById("course_totalHours").value;
        const fee = document.getElementById("course_fee").value;
        const courseFile = document.getElementById("course_file").value;
        const targetOccupation = document.getElementById("floatingTextarea3").value;

        // แสดงข้อมูลใน Step 3
        document.getElementById("displayCourseType").textContent = courseType;
        document.getElementById("displayCourseName").textContent = courseName;
        document.getElementById("displayCertificateName").textContent = certificateName;
        document.getElementById("displayMajor").textContent = major;
        document.getElementById("displayCoursePrinciple").textContent = course_principle;
        document.getElementById("displayObjectives").textContent = Array.from(objectives).map(obj => obj.value).join(", ");
        document.getElementById("displayTotalHours").textContent = totalHours;
        document.getElementById("displayFee").textContent = fee;
        document.getElementById("displayCourseFile").textContent = courseFile;
        document.getElementById("displayTargetOccupation").textContent = targetOccupation;
    }

    // เรียกใช้ฟังก์ชันเมื่อคลิก Next ใน Step 2
    document.getElementById("nextBtn").addEventListener("click", displayDataInStep3);
</script>
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
<script>
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
</html>
