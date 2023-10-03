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
    <!-- google font -->
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&display=swap" rel="stylesheet">

    <link href="${pageContext.request.contextPath}/assets/css/admin/style_addcourse.css" rel="stylesheet">
    <script>
        function previewImage(input) {
            var preview = document.getElementById('preview');
            var displayPreview = document.getElementById('displayPreview');
            var fileInput = document.getElementById('fileInput');

            var file = input.files[0];

            if (file) {
                var allowedExtensions = /(\.png|\.jpg|\.jpeg)$/i;
                var maxFileSize = 2 * 1024 * 1024; // 2MB

                if (!allowedExtensions.exec(file.name)) {
                    alert("รูปภาพต้องเป็นไฟล์นามสกุล png, jpg, หรือ jpeg เท่านั้น");
                    input.value = "";
                    return;
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
                }
            } else {
                // ไม่มีไฟล์รูปภาพที่เลือก
                alert("กรุณาเลือกรูปภาพ");
                input.value = "";

                // เพิ่มการซ่อนรูปภาพที่แสดงอยู่แล้ว (ถ้ามี)
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
                            <a href="${pageContext.request.contextPath}/" class="nav-item nav-link" style="font-size: 17px">หน้าหลัก</a>
                            <a href="#" class="nav-item nav-link" style="font-size: 18px">เกี่ยวกับคณะ</a>
                            <a href="${pageContext.request.contextPath}/course/<%=admin.getUsername()%>/add_course" class="nav-item nav-link" style="font-size: 17px">เพิ่มหลักสูตร</a>
                            <a href="${pageContext.request.contextPath}/course/<%=admin.getUsername()%>/list_all_course" class="nav-item nav-link active" style="font-size: 17px">หลักสูตรทั้งหมด</a>
                            <a href="${pageContext.request.contextPath}/course/<%=admin.getUsername()%>/list_request_open_course" class="nav-item nav-link" style="font-size: 17px">รายการร้องขอ</a>
                            <a href="${pageContext.request.contextPath}/course/public/add_activity" class="nav-item nav-link" style="font-size: 17px">เพิ่มข่าวสารทั่วไป</a>
                            <a href="${pageContext.request.contextPath}/course/public/list_activity" class="nav-item nav-link" style="font-size: 17px">ข่าวสารและกิจกรรม</a>
                            <a href="#" class="nav-item nav-link" style="font-size: 17px">ผู้ดูแลระบบ</a>
                            <a href="${pageContext.request.contextPath}/doLogout" class="nav-item nav-link" style="font-size: 17px">ออกจากระบบ</a>
                        </div>
                    </div>
        </nav>
        <!-- Navbar End -->
        <div class="container">
            <div id="container">
                <form id="signUpForm" action="${pageContext.request.contextPath}/course/<%=admin.getUsername()%>/${course.course_id}/update_edit_course" method="POST" enctype="multipart/form-data"onsubmit="return confirmAction();">
                    <h3>แก้ไขหลักสูตร</h3>
                    <hr>
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
                                            <option value="หลักสูตรอบรมระยะสั้น" label="หลักสูตรอบรมระยะสั้น" ${course.course_type == 'หลักสูตรอบรมระยะสั้น' ? 'selected' : ''}></option>
                                            <option value="Non-Degree" label="Non-Degree" ${course.course_type == 'Non-Degree' ? 'selected' : ''}></option>
                                        </select>
                                    </div>
                                    <label>ชื่อหลักสูตร</label>
                                    <div class="mb-3">
                                        <input name="course_name" type="text" id="course_name" placeholder="ชื่อหลักสูตร" value="${course.name}" oninput="this.className = ''"/>
                                        <label id="invalidCourseName" style="color: red; font-size: 12px"></label>
                                    </div>
                                    <label>ชื่อเกียรติบัตร</label>
                                    <div class="mb-3">
                                        <input name="certificateName" type="text" id="certificateName" placeholder="ชื่อเกียรติบัตร" value="${course.certificateName}" oninput="this.className = ''"/>
                                        <label id="invalidCertificateName" style="color: red; font-size: 12px"></label>
                                    </div>
                                    <label>สาขา:</label>
                                    <select name="major_id" id="major_id" class="form-select" oninput="this.className = ''">
                                        <option value="" label="--กรุณาเลือกสาขา--"></option>
                                        <c:forEach items="${majors}" var="major">
                                            <c:choose>
                                                <c:when test="${major.major_id eq course.major.major_id}">
                                                    <option value="${major.major_id}" selected>${major.name}</option>
                                                </c:when>
                                                <c:otherwise>
                                                    <option value="${major.major_id}">${major.name}</option>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:forEach>
                                    </select>
                                </td>
                                <td style="width: 40%; vertical-align: top;">
                                    <label>รูปหลักสูตร</label>
                                    <div class="mb-3" align="center">
                                        <input name="course_img" type="file" id="fileInput" accept="image/*" onchange="previewImage(this)" class="form-control"/>
                                        <c:if test="${not empty course.file}">
                                            <input type="hidden" name="original_img" value="${course.img}" />
                                            <img src="${pageContext.request.contextPath}/assets/img/course_img/${course.img}" id="preview" alt="Image Preview" style="height: 170px; margin-top: 10px; border-radius: 10px">
                                        </c:if>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <div class="mb-3">
                                        <div class="form-floating">
                                            <textarea class="form-control" placeholder="" id="floatingTextarea2" name="course_principle" style="height: 100px">${course.principle}</textarea>
                                            <label for="floatingTextarea2">หลักการและเหตุผล</label>
                                        </div>
                                        <label id="invalidCoursePrinciple" style="color: red; font-size: 12px"></label>
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
                                    <c:set var="object" value="${course.object}"></c:set>
                                    <c:set var="parts" value="${fn:split(object, '$%')}"/>
                                    <label>วัตถุประสงค์</label>
                                    <div class="mb-3">
                                        <div id="objectives-container">
                                            <c:forEach items="${parts}" var="part">
                                                <div class="objective-container">
                                                    <input type="text" name="course_objectives[]" class="objective" id="course_object" value="${part}" oninput="this.className = ''"/>
                                                    <button type="button" onclick="removeObjective(this)" class="btn btn-danger">ลบ</button>
                                                </div>
                                            </c:forEach>
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
                                            <input name="course_totalHours" type="number" id="course_totalHours" class="course_totalHours" placeholder="ระยะเวลาในการเรียน" value="${course.totalHours}" oninput="this.className = ''">
                                            <label class="l1"> ชั่วโมง</label>
                                        </div>
                                        <label id="invalidCourseTotalHours" style="color: red; font-size: 12px"></label>
                                    </div>
                                </td>
                                <td>
                                    <label>ค่าธรรมเนียม</label>
                                    <div class="mb-3">
                                        <div class="course-fee-container">
                                            <input name="course_fee" type="number" id="course_fee" class="course_fee" placeholder="ค่าธรรมเนียม" value="${course.fee}" oninput="this.className = ''">
                                            <label class="l1"> บาท</label>
                                        </div>
                                        <label id="invalidCourseFee" style="color: red; font-size: 12px"></label>
                                    </div>
                                </td>
                                <td>
                                    <label>ไฟล์เนื้อหาหลักสูตร</label>
                                    <div class="mb-3">
                                        <div class="course-totalHours-container">
                                            <input name="course_file" type="file" id="course_file" accept="file/*" class="form-control"/>
                                            <c:if test="${not empty course.file}">
                                                <input type="hidden" name="original_file" value="${course.file}" />
                                                <a href="${course.file}" target="_blank">${course.file}</a>
                                            </c:if>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="3">
                                    <div class="mb-3">
                                        <div class="form-floating">
                                            <textarea class="form-control" placeholder="" id="floatingTextarea3" name="course_targetOccupation" style="height: 100px">${course.targetOccupation}</textarea>
                                            <label for="floatingTextarea3">เป้าหมายกลุ่มอาชีพ</label>
                                        </div>
                                        <label id="invalidCourseTargetOccupation" style="color: red; font-size: 12px"></label>
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
                            <img id="displayPreview" src="" alt="Image Preview" style="height: 170px; margin-top: 10px; border-radius: 10px">
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
                        <button type="button" id="nextBtn" onclick="validateStep1()">Next</button>
                        <button style="display: none" type="button" id="nextBtn2" onclick="validateStep2()">Next</button>
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
    // function displayDataInStep3() {
    //     // ข้อมูลจาก Step 1
    //     const courseType = document.getElementById("course_type").value;
    //     const courseName = document.getElementById("course_name").value;
    //     const certificateName = document.getElementById("certificateName").value;
    //     const major = document.getElementById("major_id").value;
    //     const course_principle = document.getElementById("floatingTextarea2").value;
    //
    //     // ข้อมูลจาก Step 2
    //     const objectives = document.querySelectorAll("input[name='course_objectives[]']");
    //     const totalHours = document.getElementById("course_totalHours").value;
    //     const fee = document.getElementById("course_fee").value;
    //     const courseFile = document.getElementById("course_file").value;
    //     const targetOccupation = document.getElementById("floatingTextarea3").value;
    //
    //     // แสดงข้อมูลใน Step 3
    //     document.getElementById("displayCourseType").textContent = courseType;
    //     document.getElementById("displayCourseName").textContent = courseName;
    //     document.getElementById("displayCertificateName").textContent = certificateName;
    //     document.getElementById("displayMajor").textContent = major;
    //     document.getElementById("displayCoursePrinciple").textContent = course_principle;
    //     document.getElementById("displayObjectives").textContent = Array.from(objectives).map(obj => obj.value).join(", ");
    //     document.getElementById("displayTotalHours").textContent = totalHours;
    //     document.getElementById("displayFee").textContent = fee;
    //     document.getElementById("displayCourseFile").textContent = courseFile;
    //     document.getElementById("displayTargetOccupation").textContent = targetOccupation;
    // }
    //
    // // เรียกใช้ฟังก์ชันเมื่อคลิก Next ใน Step 2
    // document.getElementById("nextBtn").addEventListener("click", displayDataInStep3);
    function displayDataInStep3() {
        // ข้อมูลจาก Step 1
        const courseType = document.getElementById("course_type").value;
        const courseName = document.getElementById("course_name").value;
        const certificateName = document.getElementById("certificateName").value;
        const major = document.getElementById("major_id").value;
        const course_principle = document.getElementById("floatingTextarea2").value;
        const course_img = document.getElementById("preview").src; // เพิ่มบรรทัดนี้

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
        document.getElementById("displayPreview").src = course_img; // เพิ่มบรรทัดนี้
        document.getElementById("displayObjectives").textContent = Array.from(objectives).map(obj => obj.value).join(", ");
        document.getElementById("displayTotalHours").textContent = totalHours;
        document.getElementById("displayFee").textContent = fee;
        document.getElementById("displayCourseFile").textContent = courseFile;
        document.getElementById("displayTargetOccupation").textContent = targetOccupation;
    }

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
            document.getElementById("nextBtn2").innerHTML = "Submit";
        } else {
            document.getElementById("nextBtn").innerHTML = "Next";
            document.getElementById("nextBtn2").innerHTML = "Next";
        }
        //... and run a function that will display the correct step indicator:
        fixStepIndicator(n)
    }
    function validateStep1() {
        // เรียกใช้เมื่อผู้ใช้คลิก Next ในขั้นตอน 1

        // รับค่าจากฟอร์ม
        var courseType = document.getElementById("course_type").value;
        var courseName = document.getElementById("course_name").value;
        var certificateName = document.getElementById("certificateName").value;
        var major = document.getElementById("major_id").value;
        var coursePrinciple = document.getElementById("floatingTextarea2").value;
        var fileInput = document.getElementById("fileInput");

        var regExName = /^[ก-์A-Za-z0-9]{2,225}$/;

        if (courseType === "") {
            alert("กรุณาเลือกประเภทหลักสูตร");
            return false;
        }
        // ตรวจสอบว่าข้อมูลถูกต้องหรือไม่
        if (courseName === "") {
            document.getElementById("invalidCourseName").innerHTML = "กรุณากรอกชื่อหลักสูตร";
            return false;
        }else if (!regExName.test(courseName)){
            document.getElementById("invalidCourseName").innerHTML = "ต้องประกอบด้วยอักขระภาษาไทย อังกฤษ ตัวเลข และมีจำนวน 2-225 ตัวอักษร";
            return false;
        }else {
            document.getElementById("invalidCourseName").innerHTML = "";
        }
        if (certificateName === "") {
            document.getElementById("invalidCertificateName").innerHTML = "กรุณากรอกชื่อเกียรติบัตร";
            return false;
        }else if (!regExName.test(certificateName)){
            document.getElementById("invalidCertificateName").innerHTML = "ต้องประกอบด้วยอักขระภาษาไทย อังกฤษ ตัวเลข และมีจำนวน 2-225 ตัวอักษร";
            return false;
        }else {
            document.getElementById("invalidCertificateName").innerHTML = "";
        }
        if (coursePrinciple === "") {
            document.getElementById("invalidCoursePrinciple").innerHTML = "กรุณากรอกหลักการและเหตุผล";
            return false;
        }else if (!regExName.test(coursePrinciple)){
            document.getElementById("invalidCoursePrinciple").innerHTML = "ต้องประกอบด้วยอักขระภาษาไทย อังกฤษ ตัวเลข และมีจำนวน 2-225 ตัวอักษร";
            return false;
        }else {
            document.getElementById("invalidCoursePrinciple").innerHTML = "";
        }
        if (major === "") {
            alert("กรุณาเลือกสาขา");
            return false;
        }

        // ถ้าข้อมูลถูกต้อง ให้เรียกฟังก์ชัน nextPrev(1) เพื่อย้ายไปยังขั้นตอนถัดไป
        var x = document.getElementById("nextBtn")
        var y = document.getElementById("nextBtn2")
        x.style.display = "none";
        y.style.display = "block";
        nextPrev(1);
        return true;
    }
    function validateStep2() {
        // เรียกใช้เมื่อผู้ใช้คลิก Next ในขั้นตอน 2

        // รับค่าจากฟอร์มขั้นตอนที่ 2
        var objectives = document.querySelectorAll("input[name='course_objectives[]']");
        var totalHours = document.getElementById("course_totalHours").value;
        var fee = document.getElementById("course_fee").value;
        var courseFileInput = document.getElementById("course_file");
        var courseFile = document.getElementById("course_file").value;
        var targetOccupation = document.getElementById("floatingTextarea3").value;

        // ตรวจสอบว่าค่าประกอบด้วยภาษาไทย อังกฤษ ตัวเลข และมีจำนวน 2-225 ตัวอักษร
        var regExName = /^[ก-์A-Za-z0-9]{2,225}$/;

        // ตรวจสอบว่าค่าประกอบด้วยตัวเลขเท่านั้นและไม่มีช่องว่าง
        var regNumber = /^[0-9]+$/;

        // ตรวจสอบว่าข้อมูลถูกต้องหรือไม่
        for (var i = 0; i < objectives.length; i++) {
            if (objectives[i].value === "") {
                alert("กรุณากรอกวัตถุประสงค์ทั้งหมด");
                return false;
            }else if (!regExName.test(objectives[i].value)){
                alert("วัตถุประสงค์ต้องประกอบด้วยอักขระภาษาไทย อังกฤษ ตัวเลข และมีจำนวน 2-225 ตัวอักษร");
                return false;
            }
        }

        if (totalHours === "") {
            document.getElementById("invalidCourseTotalHours").innerHTML = "กรุณากรอกระยะเวลาในการเรียน";
            return false;
        }else if (!regNumber.test(totalHours)){
            document.getElementById("invalidCourseTotalHours").innerHTML = "ต้องเป็นตัวเลข ต้องไม่มีช่องว่างระหว่างตัวเลข";
            return false;
        }else {
            document.getElementById("invalidCourseTotalHours").innerHTML = "";
        }

        if (fee === "") {
            document.getElementById("invalidCourseFee").innerHTML = "กรุณากรอกค่าธรรมเนียม";
            return false;
        }else if (!regNumber.test(fee)){
            document.getElementById("invalidCourseFee").innerHTML = "ต้องเป็นตัวเลข ต้องไม่มีช่องว่างระหว่างตัวเลข";
            return false;
        }else {
            document.getElementById("invalidCourseFee").innerHTML = "";
        }

        if (targetOccupation === "") {
            document.getElementById("invalidCourseTargetOccupation").innerHTML = "กรุณากรอกกลุ่มเป้าหมายอาชีพ";
            return false;
        }else if (!regExName.test(targetOccupation)){
            document.getElementById("invalidCourseTargetOccupation").innerHTML = "ต้องประกอบด้วยอักขระภาษาไทย อังกฤษ ตัวเลข และมีจำนวน 2-225 ตัวอักษร";
            return false;
        }else {
            document.getElementById("invalidCourseTargetOccupation").innerHTML = "";
        }

        // ตรวจสอบว่าผู้ใช้เลือกไฟล์เนื้อหาหลักสูตรหรือไม่
        // if (courseFile === "") {
        //     alert("กรุณาเลือกไฟล์เนื้อหาหลักสูตร");
        //     return false;
        // }
        // ตรวจสอบนามสกุลของไฟล์
        // var allowedExtensions = /(\.pdf)$/i;
        // if (!allowedExtensions.exec(courseFile)) {
        //     alert('เอกสารหลักสูตรต้องเป็นไฟล์ PDF เท่านั้น');
        //     courseFileInput.focus();
        //     return false;
        // }

        // ถ้าข้อมูลถูกต้อง ให้เรียกฟังก์ชัน nextPrev(1) เพื่อย้ายไปยังขั้นตอนถัดไป
        nextPrev(1);
        return true;
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
        // If you have reached the end of the form...
        if (currentTab >= x.length) {
            // ... the form gets submitted:
            document.getElementById("signUpForm").submit();
            return false;
        }
        // Otherwise, display the correct tab:
        showTab(currentTab);

        // เรียกใช้ฟังก์ชันแสดงข้อมูลใน Step 3 ในขั้นตอนการสร้างแบบฟอร์ม
        if (currentTab === 2) {
            displayDataInStep3();
        }
    }


    function validateForm() {
        // This function deals with validation of the form fields
        var x, y, i, valid = true;
        x = document.getElementsByClassName("step");
        y = x[currentTab].getElementsByTagName("input");

        // A loop that checks every input field in the current tab:
        for (i = 0; i < y.length; i++) {
            // If a field is empty and not the file input field...
            if (y[i].value === "" && y[i].type !== "file") {
                // Add an "invalid" class to the field:
                y[i].className += " invalid";
                // And set the current valid status to false
                valid = false;
            }
        }

        // If the valid status is true, mark the step as finished and valid:
        if (valid) {
            document.getElementsByClassName("stepIndicator")[currentTab].className += " finish";
        }

        return valid; // Return the valid status
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

    // function updateRemoveButtons() {
    //     var containers = document.getElementsByClassName('objective-container');
    //     var removeButtons = document.querySelectorAll('.objective-container button.btn-danger');
    //
    //     if (containers.length === 1) {
    //         for (var i = 0; i < removeButtons.length; i++) {
    //             removeButtons[i].style.display = 'none';
    //         }
    //     } else {
    //         for (var i = 0; i < removeButtons.length; i++) {
    //             removeButtons[i].style.display = 'block';
    //         }
    //     }
    // }
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
