<%@ page import="lifelong.model.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPEhtml>
<html>
<head>
    <title>${title}</title>
    <jsp:include page="/WEB-INF/view/layouts/detail-all-style.jsp"/>
    <!-- google font -->
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&display=swap" rel="stylesheet">

    <link href="${pageContext.request.contextPath}/assets/css/admin/addcourse.css" rel="stylesheet">
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
        <div class="container">
            <div id="container">
                <form id="signUpForm" name="frm" action="${pageContext.request.contextPath}/course/${admin_id}/save" method="POST" enctype="multipart/form-data" onsubmit="return confirmAction();">
                    <h3>เพิ่มหลักสูตรใหม่</h3>
                    <hr>
                    <!-- start step indicators -->
                    <div class="form-header d-flex mb-4">
                        <span class="stepIndicator">ชื่อหลักสูตร</span>
                        <span class="stepIndicator">เนื้อหาหลักสูตร</span>
                        <span class="stepIndicator">ยืนยันหลักสูตร</span>
                    </div>
                    <!-- end step indicators -->

                    <!-- step one -->
                    <div class="step" style="display: inline-block">
                        <table style="width: 100%; border: 1px">
                            <tr>
                                <td style="width: 70%">
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
                                        <a id="link" href="#">ตรวจสอบ</a> &nbsp; <label id="status"></label>
                                        <label id="invalidCourseName" style="color: red; font-size: 12px"></label>
                                    </div>
                                    <label>ชื่อเกียรติบัตร</label>
                                    <div class="mb-3">
                                        <input name="certificateName" type="text" id="certificateName" placeholder="ชื่อเกียรติบัตร" oninput="this.className = ''"/>
                                        <label id="invalidCertificateName" style="color: red; font-size: 12px"></label>
                                    </div>
                                    <label>สาขา:</label>
                                    <select name="major_id" id="major_id" class="form-select" oninput="this.className = ''">
                                        <option value="" label="--กรุณาเลือกสาขา--"></option>
                                        <c:forEach items="${majors}" var="major">
                                            <option value="${major.major_id}">${major.name}</option>
                                        </c:forEach>
                                    </select>
                                </td>
                                <td style="width: 30%; vertical-align: top;">
                                    <label>รูปหลักสูตร</label>
                                    <div class="mb-3" align="center">
                                        <input name="course_img" type="file" id="fileInput" accept="image/*" onchange="previewImage(this)" class="form-control"/>
                                        <img id="preview" src="" alt="Image Preview" style="display: none; height: 300px; margin-top: 10px; border-radius: 10px">
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <div class="mb-3">
                                        <label>หลักการและเหตุผล</label>
                                        <div class="form-floating" style="height: 500px">
<%--                                            <textarea class="form-control" placeholder="" id="floatingTextarea2" name="course_principle" style="height: 100px"></textarea>--%>
<%--                                            <label for="floatingTextarea2">หลักการและเหตุผล</label>--%>
                                                <div id="editor" style=""></div>
                                                <textarea style="display: none;" class="form-control" id="floatingTextarea2" name="course_principle"></textarea>
                                        </div>
                                        <label id="invalidCoursePrinciple" style="color: red; font-size: 12px"></label>
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </div>

                    <!-- step two -->
                    <div class="step">
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
                                        <label id="invalidCourseTotalHours" style="color: red; font-size: 12px"></label>
                                    </div>
                                </td>
                                <td>
                                    <label>ค่าธรรมเนียม</label>
                                    <div class="mb-3">
                                        <div class="course-fee-container">
                                            <input name="course_fee" type="number" id="course_fee" class="course_fee" placeholder="ค่าธรรมเนียม" oninput="this.className = ''">
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
    document.getElementById("nextBtn2").addEventListener("click", displayDataInStep3);
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
        var courseName = document.getElementById("course_name").value;

        document.getElementById("link").click();
        if(document.getElementById("course_name").value === ""){
            // alert("กรุณากรอกชื่อหลักสูตร");
            stt.innerHTML = "";
            document.getElementById("invalidCourseName").innerHTML = "กรุณากรอกชื่อหลักสูตร";
            document.getElementById("course_name").focus();
            return false;
        }else if (courseName.length < 2 || courseName.length > 225) {
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

        var certificateName = document.getElementById("certificateName").value;
        if (document.getElementById("certificateName").value === ""){
            // alert("กรุณากรอกชื่อเกียรติบัตร");
            document.getElementById("invalidCertificateName").innerHTML = "กรุณากรอกชื่อเกียรติบัตร";
            document.getElementById("certificateName").focus();
            return false;
        } else if (certificateName.length < 2 || certificateName.length > 225) {
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
        // var regExName = /^[ก-์A-Za-z0-9 ]{2,225}$/;
        var objectives = document.querySelectorAll("input[name='course_objectives[]']");
        for (var i = 0; i < objectives.length; i++) {
            var object = objectives[i].value;
            if (objectives[i].value === "") {
                document.getElementById("invalidObjective").innerHTML = "กรุณากรอกวัตถุประสงค์ทั้งหมด";
                objectives[i].focus();
                return false;
            }else if (object.length < 2 || object.length > 225){
                document.getElementById("invalidObjective").innerHTML = "วัตถุประสงค์ต้องมีจำนวน 2-225 ตัวอักษร";
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
<%--ส่งRich Test Editer--%>
<script>
    var quill = new Quill('#editor', {
        theme: 'snow',
        placeholder: 'กรอกเนื้อหาของคุณที่นี่...', // ข้อความที่จะแสดงในตอนเริ่มต้น
        // เนื้อหาเริ่มต้น (HTML หรือ plain text)
        // ตัวอย่างเช่น: '<p>เนื้อหาเริ่มต้น</p>'
    });

    // ให้ข้อมูลจาก Rich Text Editor เขียนลงในฟิลด์ 'ac_detail' ในฟอร์ม
    // function setCoursePrinciple() {
    //     var course_principle = quill.getText();
    //     document.getElementById('floatingTextarea2').value = course_principle;
    // }
</script>
</html>
