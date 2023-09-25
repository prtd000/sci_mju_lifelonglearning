<%@ page import="lifelong.model.Lecturer" %>
<%@ page import="lifelong.model.Member" %>
<%@ page import="lifelong.model.Admin" %><%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 5/30/2023
  Time: 1:26 PM
  To change this template use File | Settings | File Templates.
--%>
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
                <form action="${pageContext.request.contextPath}/course/<%=admin.getUsername()%>/${course.course_id}/update_edit_course" method="POST" enctype="multipart/form-data"onsubmit="return confirmAction();">
                    <table>
                        <colgroup>
                            <col style="width: 160px;">
                            <col style="width: auto;">
                        </colgroup>
                        <tbody>
                        <tr>
                            <td><label>ประเภท:</label></td>
                            <td>
                                <select name="course_type" id="course_type">
                                    <option value="" label="--กรุณาเลือกหลักสูตร--"></option>
                                    <option value="หลักสูตรอบรมระยะสั้น" label="หลักสูตรอบรมระยะสั้น" ${course.course_type == 'หลักสูตรอบรมระยะสั้น' ? 'selected' : ''}></option>
                                    <option value="Non-Degree" label="Non-Degree" ${course.course_type == 'Non-Degree' ? 'selected' : ''}></option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td><label>ชื่อหลักสูตร:</label></td>
                            <td><input name="course_name" type="text" id="course_name" value="${course.name}"/></td>
                        </tr>
                        <tr>
                            <td><label>ชื่อเกีตรติบัตร:</label></td>
                            <td><input name="certificateName" type="text" id="certificateName" value="${course.certificateName}"/></td>
                        </tr>
                        <tr>
                            <td><label>รูปหลักสูตร:</label></td>
                            <td>
                                <input name="course_img" type="file" id="course_img" />
                                <c:if test="${not empty course.file}">
                                    <input type="hidden" name="original_img" value="${course.img}" />
                                    <img src="${pageContext.request.contextPath}/assets/img/course_img/${course.img}" width="100px">
<%--                                    <a href="${course.img}" target="_blank">${course.img}</a>--%>
                                </c:if>
                            </td>
                        </tr>
                        <tr>
                            <td><label>หลักการและเหตุผล:</label></td>
                            <td><textarea name="course_principle" id="course_principle">${course.principle}</textarea></td>
                        </tr>
                        <c:set var="object" value="${course.object}"></c:set>
                        <c:set var="parts" value="${fn:split(object, '$%')}"/>
                        <tr>
                            <td><label>วัตถุประสงค์:</label></td>
                            <td>
                                <div id="objectives-container">
                                    <c:forEach items="${parts}" var="part">
                                        <div class="objective-container">
                                                <input type="text" name="course_objectives[]" class="objective" id="course_object" value="${part}"/>
                                                <button type="button" onclick="removeObjective(this)">ลบ</button><br>
                                        </div>
                                    </c:forEach>
                                </div>
                                <button type="button" onclick="addObjective()">เพิ่มวัตถุประสงค์</button>

                            </td>
                        </tr>
<%--                        <tr>--%>
<%--                            <td><label>วัตถุประสงค์:</label></td>--%>
<%--                            <td><textarea name="course_object" id="course_object">${course.object}</textarea></td>--%>
<%--                        </tr>--%>
                        <tr>
                            <td><label>ระยะเวลาในการเรียน:</label></td>
                            <td><input name="course_totalHours" type="number" id="course_totalHours" value="${course.totalHours}"/></td>
                        </tr>
                        <tr>
                            <td><label>เป้าหมายกลุ่มอาชีพ:</label></td>
                            <td><input name="course_targetOccupation" type="text" id="course_targetOccupation" value="${course.targetOccupation}"/></td>
                        </tr>
                        <tr>
                            <td><label>ค่าธรรมเนียม:</label></td>
                            <td><input name="course_fee" type="number" id="course_fee" value="${course.fee}"/></td>
                        </tr>
                        <tr>
                            <td><label>ไฟล์หลักสูตร:</label></td>
                            <td>
                                <input name="course_file" type="file" id="course_file" />
                                <c:if test="${not empty course.file}">
                                    <input type="hidden" name="original_file" value="${course.file}" />
                                    <a href="${course.file}" target="_blank">${course.file}</a>
                                </c:if>
                            </td>
                        </tr>
                        <tr>
                            <td><label>ลิ้งค์หลักสูตร:</label></td>
                            <td><input name="course_linkMooc" type="text" id="course_linkMooc" value="${course.linkMooc}"/></td>
                        </tr>
                        <tr>
                            <td><label>สาขา:</label></td>
                            <td>
                                <select name="major_id" id="major_id">
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
                        </tr>
                        <tr>
                            <td><input type="button" value="ย้อนกลับ"
                                       onclick="window.location.href='${pageContext.request.contextPath}/course/<%=admin.getUsername()%>/list_all_course'; return false;"
                                       class="cancel-button"/></td>
                            <td><input type="submit" value="บันทึก" class="save"/>
                                    <%--                        <input type="button" value="ยกเลิก"onclick="window.location.href='list'; return false;"class="cancel-button"/>--%>
                            </td>
                        </tr>
                        </tbody>
                    </table>
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
