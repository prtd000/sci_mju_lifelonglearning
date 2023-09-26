<%@ page import="lifelong.model.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPEhtml>
<html>
<head>
    <title>${title}</title>
    <jsp:include page="/WEB-INF/view/layouts/detail-all-style.jsp"/>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">

    <!-- google font -->
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&display=swap" rel="stylesheet">

    <link href="${pageContext.request.contextPath}/assets/css/admin/style_addcourse.css" rel="stylesheet">
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
    <c:when test="${flag.equals('admin')}">
        <jsp:include page="/WEB-INF/view/admin/nav_admin.jsp"/>
    </c:when>
    <c:when test="${flag.equals('member')}">
        <jsp:include page="/WEB-INF/view/member/nav_member.jsp"/>
    </c:when>
    <c:when test="${flag.equals('null')}">
        <jsp:include page="/WEB-INF/view/layouts/nav.jsp"/>
    </c:when>
</c:choose>
<c:choose>
    <c:when test="${flag.equals('lecturer')}">
        <% assert admin != null; %>
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
                    <a href="${pageContext.request.contextPath}/" class="nav-item nav-link active">หน้าหลัก</a>
                    <a href="#" class="nav-item nav-link">เกี่ยวกับคณะ</a>
                        <%--            <div class="nav-item dropdown">--%>
                        <%--                <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">หลักสูตรการอบรม</a>--%>
                    <a href="${pageContext.request.contextPath}/search_course" class="nav-item nav-link">หลักสูตรการอบรม</a>
                    <a href="${pageContext.request.contextPath}/lecturer/<%=lecturer.getUsername()%>/list_request_open_course" class="nav-item nav-link">รายการร้องขอ</a>
                        <%--                <div class="dropdown-menu m-0">--%>
                        <%--                    <a href="#" class="dropdown-item">Reskill/Upskill</a>--%>
                        <%--                    <a href="#" class="dropdown-item">อบรมระยะสั้น</a>--%>

                        <%--                </div>--%>
                        <%--            </div>--%>
                    <a href="#" class="nav-item nav-link">ข่าวสารและกิจกรรม</a>
                    <a href="#" class="nav-item nav-link">เกี่ยวกับเรา</a>
                    <a href="#" class="nav-item nav-link">Lecturer</a>
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
                <form id="signUpForm" action="${pageContext.request.contextPath}/lecturer/${lecturer.username}/save" method="POST" enctype="multipart/form-data" onsubmit="return confirmAction();">
                    <!-- start step indicators -->
                    <div class="form-header d-flex mb-4">
                        <span class="stepIndicator">ข้อมูลการสมัคร</span>
                        <span class="stepIndicator">การเรียนการสอน</span>
                        <span class="stepIndicator">ยืนยันการร้องขอ</span>
                    </div>
                    <!-- end step indicators -->

                    <!-- step one -->
                    <div class="step">
                        <p class="text-center mb-4">Your presence on the social network</p>
                        <table style="width: 100%">
                            <tr>
                                <td colspan="2">
                                    <label>หลักสูตร</label>
                                    <select name="course_id" id="course_id" class="form-select" oninput="this.className = ''">
                                        <c:set var="requestedCourseIds" value="" />
                                        <c:forEach var="item1" items="${request_select}">
                                            <c:set var="requestedCourseIds" value="${requestedCourseIds},${item1.course.course_id}" />
                                        </c:forEach>
                                        <c:forEach items="${courses}" var="course">
                                            <c:if test="${not fn:contains(requestedCourseIds, course.course_id)}">
                                                <option value="${course.course_id}">${course.name}</option>
                                            </c:if>
                                        </c:forEach>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <label>วันเปิดรับสมัคร</label>
                                    <div class="mb-3">
                                        <div class="course-totalHours-container">
                                            <input name="startRegister" type="date" id="startRegister" class="datepicker" value="yyyy-MM-dd"/>
                                        </div>
                                    </div>
                                </td>
                                <td>
                                    <label>วันปิดรับสมัคร</label>
                                    <div class="mb-3">
                                        <div class="course-fee-container">
                                            <input name="endRegister" type="date" id="endRegister" class="datepicker" value="yyyy-MM-dd"/>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <label>จำนวนรับสมัคร</label>
                                    <div class="mb-3">
                                        <div class="flex-container">
                                            <input name="quantity" id="quantity" type="number" autocomplete="off" oninput="this.className = ''" class="flex-td"/>
                                            <label class="l1"> คน</label>
                                        </div>
                                    </div>
                                </td>
                                <td>
                                    <label>วันประกาศผลการสมัคร</label>
                                    <div class="mb-3">
                                        <div class="course-totalHours-container">
                                            <input name="applicationResult" type="date" id="applicationResult" class="datepicker" value="yyyy-MM-dd"/>
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
                                <td>
                                    <label>เริ่มเรียน</label>
                                    <div class="mb-3">
                                        <div class="flex-container">
                                            <input name="startStudyDate" type="date" id="startStudyDate" class="datepicker" value="yyyy-MM-dd"/>
                                        </div>
                                    </div>
                                </td>
                                <td>
                                    <label>สิ้นสุดการเรียน</label>
                                    <div class="mb-3">
                                        <div class="flex-container">
                                            <input name="endStudyDate" type="date" id="endStudyDate" class="datepicker" value="yyyy-MM-dd"/>
                                        </div>
                                    </div>
                                </td>
                                <td>
                                    <label>เวลาในการเรียน</label>
                                    <div class="mb-3">
                                        <div class="flex-container">
                                            <input name="studyTime" id="studyTime" autocomplete="off" placeholder="08.00o. - 16.00น." oninput="this.className = ''"/>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                        </table>
                        <table style="width: 100%;">
                            <tr>
                                    <%--                                <td colspan="3">--%>
                                <td>
                                    <label>รูปแบบการสอน:</label>
                                    <select name="type_teach" id="type_teach" class="form-select" oninput="this.className = ''">
                                        <option value="">--กรุณาเลือกรูปแบบการสอน--</option>
                                        <option value="แบบที่ 1 เรียนร่วมกับนักศึกษาในหลักสูตร">แบบที่ 1 เรียนร่วมกับนักศึกษาในหลักสูตร</option>
                                        <option value="แบบที่ 2 แยกกลุ่มเรียนโดยเฉพาะ">แบบที่ 2 แยกกลุ่มเรียนโดยเฉพาะ</option>
                                        <option value="จัดการเรียนการสอนร่วมกับทั้งแบบที่ 1 และแบบที่ 2">จัดการเรียนการสอนร่วมกับทั้งแบบที่ 1 และ แบบที่ 2</option>
                                    </select>
                                </td>
                                <td>
                                    <label>ประเภทการเรียน:</label>
                                    <select name="type_learn" id="type_learn" onchange="showHideFields()" class="form-select" oninput="this.className = ''">
                                        <option value="">--กรุณาเลือกประเภทการเรียน--</option>
                                        <option value="เรียนออนไลน์">เรียนออนไลน์</option>
                                        <option value="เรียนในสถานศึกษา">เรียนในสถานศึกษา</option>
                                        <option value="เรียนทั้งออนไลน์และในสถานศึกษา">เรียนทั้งออนไลน์และในสถานศึกษา</option>
                                    </select>
                                </td>
                                    <%--                                </td>--%>
                            </tr>
                            <tr id="locationRow" style="display: none;">
                                <td colspan="2">
                                    <div class="mb-3">
                                        <div class="form-floating">
                                            <textarea class="form-control" placeholder="" id="floatingTextarea2" name="location" style="height: 100px"></textarea>
                                            <label for="floatingTextarea2">สถานที่</label>
                                        </div>
                                    </div>
                                </td>
                            </tr>

                            <tr id="moocRow" style="display: none;">
                                <td colspan="2">
                                    <div class="mb-3">
                                        <label>link mooc (สำหรับเรียนออนไลน์):</label>
                                        <input name="link_mooc" id="link_mooc" autocomplete="off" placeholder="link http://...." />
                                    </div>
                                </td>
                            </tr>

                            <tr>
                                <td>
                                    <div class="mb-3">
                                        <label>ลายเซ็น:</label>
                                        <input name="signature" type="file" id="fileInput" accept="image/*" onchange="previewImage(this)" class="form-control"/>
                                    </div>
                                </td>
                                <td><img id="preview" src="" alt="Image Preview" style="display: none; height: 80px; margin-left: 10px; border-radius: 10px"></td>
                            </tr>
                        </table>
                    </div>

                    <!-- step three -->
                    <div class="step" id="step3-data">
                        <h2 class="text-center mb-4">รายละเอียดหลักสูตร</h2>

                        <div>
                            <h3>ข้อมูลจาก Step 1</h3>
                            <p>หลักสูตร: <span id="displayCourse"></span></p>
                            <p>วันเปิดรับสมัคร: <span id="displayOpenDate"></span></p>
                            <p>วันปิดรับสมัคร: <span id="displayEndDate"></span></p>
                            <p>จำนวนรับสมัคร: <span id="displayQTY"></span> คน</p>
                            <p>วันประกาศผลการสมัคร: <span id="displayApplicationResult"></span> </p>
                            <!-- เพิ่มข้อมูลอื่น ๆ ที่คุณต้องการแสดงจาก Step 1 -->
                        </div>

                        <div>
                            <h3>ข้อมูลจาก Step 2</h3>
                            <p>ระยะเวลาการเรียน: <span id="displayStart"></span> - <span id="displayEnd"></span></p>
                            <p>เวลาในการเรียน: <span id="displayStudyTime"></span></p>
                            <p>รูปแบบการสอน: <span id="displayType_teach"></span></p>
                            <p>ประเภทการเรียน: <span id="displayType_learn"></span></p>
                            <p id="link_mooc_display" style="display: none">Link Mooc: <span id="displayLink_Mooc"></span></p>
                            <p id="location_display" style="display: none">สถานที่: <span id="displayLocation"></span></p>
                            <img id="displayPreview" src="" alt="Image Preview" style="display: none; height: 170px; margin-top: 10px; border-radius: 10px">
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
    document.addEventListener("DOMContentLoaded", function () {
        const quantityInput = document.getElementById("quantity");

        quantityInput.addEventListener("focus", function () {
            setTimeout(function () {
                const inputs = document.getElementsByTagName("input");
                for (let i = 0; i < inputs.length; i++) {
                    inputs[i].setAttribute("autocomplete", "off");
                }
            }, 100);
        });
    });
</script>
<script>
    <%--function checkSelectedCourse() {--%>
    <%--    let selectedCourseId = document.getElementById("course_id").value;--%>

    <%--    // ใช้ forEach ในอาร์เรย์ courses เพื่อตรวจสอบเงื่อนไขหรือประมวลผลข้อมูลต่อไป--%>
    <%--    // courses.forEach(function(course)--%>
    <%--    <c:forEach var="item" items="${courses}">{--%>
    <%--        <c:set var="cId" value="${item.course_id}"></c:set>--%>
    <%--        if (selectedCourseId === ${cId}) {--%>
    <%--            document.getElementById("displayCourse").textContent = ${item.name};--%>
    <%--        }--%>
    <%--    }</c:forEach>--%>
    <%--}--%>
    function displayDataInStep3() {
        // ข้อมูลจาก Step 1
        const course_id = document.getElementById("course_id").value;
        const startRegister = document.getElementById("startRegister").value;
        const endRegister = document.getElementById("endRegister").value;
        const quantity = document.getElementById("quantity").value;
        const applicationResult = document.getElementById("applicationResult").value;

        // ข้อมูลจาก Step 2
        const startStudyDate = document.getElementById("startStudyDate").value;
        const endStudyDate = document.getElementById("endStudyDate").value;
        const studyTime = document.getElementById("studyTime").value;
        const type_teach = document.getElementById("type_teach").value;
        const type_learn = document.getElementById("type_learn").value;

        // แสดงข้อมูลใน Step 3
        document.getElementById("displayCourse").textContent = course_id;
        // checkSelectedCourse()
        document.getElementById("displayOpenDate").textContent = startRegister;
        document.getElementById("displayEndDate").textContent = endRegister;
        document.getElementById("displayQTY").textContent = quantity;
        document.getElementById("displayApplicationResult").textContent = applicationResult;

        document.getElementById("displayStart").textContent = startStudyDate;
        document.getElementById("displayEnd").textContent = endStudyDate;
        document.getElementById("displayStudyTime").textContent = studyTime;
        document.getElementById("displayType_teach").textContent = type_teach;
        document.getElementById("displayType_learn").textContent = type_learn;
    }
    function displayTotalDataInStep3() {
        const type_learn = document.getElementById("type_learn").value;

        const location = document.getElementById("floatingTextarea2").value;
        const linkMooc = document.getElementById("link_mooc").value;

        const display_linkMooc = document.getElementById("link_mooc_display");
        const display_location = document.getElementById("location_display");

        if (type_learn === "เรียนออนไลน์"){
            document.getElementById("displayLink_Mooc").textContent = linkMooc;
            display_linkMooc.style.display = "block";
            display_location.style.display = "none";
        }else if (type_learn === "เรียนในสถานศึกษา") {
            document.getElementById("displayLocation").textContent = location;
            display_linkMooc.style.display = "none";
            display_location.style.display = "block";
        }else if (type_learn === "เรียนทั้งออนไลน์และในสถานศึกษา") {
            document.getElementById("displayLink_Mooc").textContent = linkMooc;
            document.getElementById("displayLocation").textContent = location;
            display_linkMooc.style.display = "block";
            display_location.style.display = "block";
        }
        displayDataInStep3()
    }

    // เรียกใช้ฟังก์ชันเมื่อคลิก Next ใน Step 2
    document.getElementById("nextBtn").addEventListener("click", displayTotalDataInStep3);
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
            // Check if the field is visible (not hidden)
            if (y[i].offsetParent !== null) {
                // If a field is empty...
                if (y[i].value == "") {
                    // add an "invalid" class to the field:
                    y[i].className += " invalid";
                    // and set the current valid status to false
                    valid = false;
                }
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
<script>
    function showHideFields() {
        var typeLearnSelect = document.getElementById("type_learn");
        var locationRow = document.getElementById("locationRow");
        var moocRow = document.getElementById("moocRow");

        var selectedOption = typeLearnSelect.value;

        if (selectedOption === "เรียนในสถานศึกษา") {
            locationRow.style.display = "table-row";
            moocRow.style.display = "none";
        } else if (selectedOption === "เรียนออนไลน์") {
            locationRow.style.display = "none";
            moocRow.style.display = "table-row";
        } else if (selectedOption === "เรียนทั้งออนไลน์และในสถานศึกษา") {
            locationRow.style.display = "table-row";
            moocRow.style.display = "table-row";
        } else {
            locationRow.style.display = "none";
            moocRow.style.display = "none";
        }
    }


</script>
<script>
    // รับค่า element ของวันเปิดรับสมัครและวันปิดรับสมัคร
    var startRegisterInput = document.getElementById("startRegister");
    var endRegisterInput = document.getElementById("endRegister");
    var startStudyDateInput = document.getElementById("startStudyDate");
    var endStudyDateInput = document.getElementById("endStudyDate");
    var applicationResultInput = document.getElementById("applicationResult");

    // รับวันที่ปัจจุบัน
    var currentDate = new Date();
    var currentDateString = currentDate.toISOString().slice(0, 10); // แปลงเป็นรูปแบบ yyyy-MM-dd

    // กำหนดค่าวันที่ปัจจุบันในฟิลด์ของวันเปิดรับสมัครและวันปิดรับสมัคร
    startRegisterInput.value = currentDateString;
    endRegisterInput.value = currentDateString;
    startStudyDateInput.value = currentDateString;
    endStudyDateInput.value = currentDateString;
    applicationResultInput.value = currentDateString;

    // กำหนดค่าสูงสุดให้เป็นวันปัจจุบัน
    startRegisterInput.min = currentDateString;
    endRegisterInput.min = currentDateString;
    startStudyDateInput.min = currentDateString;
    endStudyDateInput.min = currentDateString;
    applicationResultInput.min = currentDateString;
</script>
</html>
