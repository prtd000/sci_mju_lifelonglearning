<%@ page import="lifelong.model.*" %>
<%@ page import="java.util.Date" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>หลักสูตรที่ผ่านการร้องขอ</title>
    <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet">
<%--    <link href="${pageContext.request.contextPath}/assets/css/lecturer/list_request_open_course.css" rel="stylesheet">--%>
    <jsp:include page="/WEB-INF/view/layouts/detail-all-style.jsp"/>
    <link href="${pageContext.request.contextPath}/assets/css/lecturer/list_request_open_course.css" rel="stylesheet">
<%--    <link href="${pageContext.request.contextPath}/assets/css/list_open_course_style.css" rel="stylesheet">--%>
    <style>
        body{
            font-family: 'Prompt', sans-serif;
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
                    <a href="${pageContext.request.contextPath}/" class="nav-item nav-link" style="font-size: 18px">หน้าหลัก</a>
                    <a href="${pageContext.request.contextPath}/search_course" class="nav-item nav-link" style="font-size: 18px">หลักสูตรการอบรม</a>
                    <a href="${pageContext.request.contextPath}/lecturer/<%=lecturer.getUsername()%>/add_roc" class="nav-item nav-link" style="font-size: 18px">ร้องขอหลักสูตร</a>
                    <a href="${pageContext.request.contextPath}/lecturer/<%=lecturer.getUsername()%>/list_request_open_course" class="nav-item nav-link" style="font-size: 18px">รายการร้องขอ</a>
                    <a href="${pageContext.request.contextPath}/lecturer/<%=lecturer.getUsername()%>/list_approve_request_open_course" class="nav-item nav-link active" style="font-size: 18px">หลักสูตรที่เปิดสอน</a>
                    <a href="${pageContext.request.contextPath}/view_activity" class="nav-item nav-link" style="font-size: 18px">ข่าวสารและกิจกรรม</a>
                    <a href="#" class="nav-item nav-link" style="font-size: 17px">อาจารย์</a>
                    <a href="${pageContext.request.contextPath}/doLogout" class="nav-item nav-link" style="font-size: 18px">ออกจากระบบ</a>
                </div>
            </div>
        </nav>
        <!-- Navbar End -->

<div align="center" style="margin-top: 20px">
    <h3>รายการหลักสูตรที่ผ่านการร้องขอ</h3><br>
    <table class="container">
        <tr align="center">
            <td class="list_course" align="center">
                <div id="course" class="tabcontent">
                    <table style="width: 100%;">
                        <tr>
                            <td align="left" style="width: 50%">
                                <h4><b id="tag_line"></b></h4>
                            </td>
                            <td align="right" style="width: 30%">
                                <select style="font-size: 12px" id="select_type" class="form-select" aria-label="Default select example" onchange="checkSelection()">
                                    <option value="กำลังลงทะเบียน" selected>กำลังลงทะเบียน</option>
                                    <option value="กำลังชำระเงิน">กำลังชำระเงิน</option>
                                    <option value="กำลังเรียน">กำลังเรียน</option>
                                </select>
                            </td>
                        </tr>
                    </table>
                    <hr>
                    <div id="list_register" >
                        <table class="table table-striped table-hover" style="font-size: 12px">
                            <tr style="color: black">
                                <td>รายละเอียดหลักสูตร</td>
                                <td style="width: 15%" align="center">ระยะเวลาลงทะเบียน</td>
                                <td style="width: 15%" align="center">ระยะเวลาชำระเงิน</td>
                                <td style="width: 15%" align="center">ระยะเวลาเรียน</td>
                                <td style="width: 10%" align="center">ประเภท</td>
                                <td style="width: 10%" align="center">ผู้สมัคร</td>
                                <td style="width: 5%" align="center"></td>
                            </tr>
                            <c:choose>
                                <c:when test="${requests_open_course.size() == 0}">
                                    <tr>
                                        <td colspan="7" align="center">ไม่มีข้อมูล</td>
                                    </tr>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach var="request_course" items="${requests_open_course}">
                                        <%
                                            Date currentDate = new Date(); // วันปัจจุบัน
                                        %>
                                        <c:set var="currentDate1" value="<%=currentDate%>"/>
                                        <c:if test="${request_course.requestStatus == 'ผ่าน' && currentDate1 <= request_course.endRegister}">
                                            <fmt:formatDate value="${request_course.startRegister}" pattern="dd/MM/yyyy" var="startRegister" />
                                            <fmt:formatDate value="${request_course.endRegister}" pattern="dd/MM/yyyy" var="endRegister" />
                                            <fmt:formatDate value="${request_course.startPayment}" pattern="dd/MM/yyyy" var="startPayment" />
                                            <fmt:formatDate value="${request_course.endPayment}" pattern="dd/MM/yyyy" var="endPayment" />
                                            <fmt:formatDate value="${request_course.startStudyDate}" pattern="dd/MM/yyyy" var="startStudyDate" />
                                            <fmt:formatDate value="${request_course.endStudyDate}" pattern="dd/MM/yyyy" var="endStudyDate" />
                                            <tr style="color: black">
                                                <td><p>${request_course.course.name}</p></td>
                                                <td align="center"><p>${startRegister} - ${endRegister}</p></td>
                                                <c:choose>
                                                    <c:when test="${request_course.course.fee == 0}">
                                                        <td align="center"><p>ไม่มีค่าธรรมเนียม</p></td>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <td align="center"><p>${startPayment} - ${endPayment}</p></td>
                                                    </c:otherwise>
                                                </c:choose>
                                                <td align="center"><p>${startStudyDate} - ${endStudyDate}</p></td>
                                                <td align="center"><p>${request_course.course.course_type}</p></td>
                                                <td align="center">
                                                    <a href="${pageContext.request.contextPath}/lecturer/${lecturer_id}/${request_course.request_id}/list_member_to_approve">
                                                        <button class="button-5" role="button" style="font-size: 12px">
                                                            <i class='fas fa-user-friends' style='color: white; margin-right: 5px'></i>${request_course.registerList.size()}/${request_course.quantity}
                                                        </button>
                                                    </a>
                                                </td>
                                                <td align="center">
                                                    <!-- เช็คว่าวันที่ applicationResult เลยหรือไม่ -->
                                                    <c:if test="${currentDate1 < request_course.endRegister}">
                                                        <i class='fa fa-times-circle' style='color: red;font-size: 25px; margin-top: 5px' onclick="if((confirm('คุณแน่ใจหรือว่าต้องการยกเลิกหลักสูตรนี้?'))) { window.location.href='${pageContext.request.contextPath}/lecturer/<%=lecturer.getUsername()%>/${request_course.request_id}/cancel_request_open_course'; return false; }"></i>
                                                    </c:if>
                                                </td>
                                            </tr>
                                        </c:if>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                        </table>
                    </div>

                    <div id="list_payment">
                        <div style="width: 100%" align="center">
                            <input type="radio" name="listPay" value="การชำระเงิน" checked>
                            <label>การชำระเงิน</label>
                            <input type="radio" name="listPay" value="รอประกาศผล">
                            <label>รอประกาศผล</label>
                        </div>
                        <hr>
                        <div id="payment_list" style="display:block;">
                            <table class="table table-striped table-hover" style="font-size: 15px">
                                <tr style="color: black">
                                    <td>รายละเอียดหลักสูตร</td>
                                    <td style="width: 15%" align="center">ระยะเวลาชำระเงิน</td>
                                    <td style="width: 15%" align="center">วันประกาศผล</td>
                                    <td style="width: 15%" align="center">ระยะเวลาเรียน</td>
                                    <td style="width: 10%" align="center">ประเภท</td>
                                    <td style="width: 10%" align="center">ผู้สมัคร</td>
                                </tr>
                                <c:choose>
                                    <c:when test="${requests_sort_payment_date.size() == 0}">
                                        <tr>
                                            <td colspan="6" align="center">ไม่มีข้อมูล</td>
                                        </tr>
                                    </c:when>
                                    <c:otherwise>
                                        <c:forEach var="request_course" items="${requests_sort_payment_date}">
                                            <%
                                                Date currentDate = new Date(); // วันปัจจุบัน
                                            %>
                                            <c:set var="currentDate1" value="<%=currentDate%>"/>
                                            <c:if test="${request_course.requestStatus == 'ผ่าน' &&
                                              currentDate1 > request_course.endRegister &&
                                              currentDate1 <= request_course.endPayment}">
                                                <fmt:formatDate value="${request_course.startPayment}" pattern="dd/MM/yyyy" var="startPayment" />
                                                <fmt:formatDate value="${request_course.endPayment}" pattern="dd/MM/yyyy" var="endPayment" />
                                                <fmt:formatDate value="${request_course.applicationResult}" pattern="dd/MM/yyyy" var="applicationResult" />
                                                <fmt:formatDate value="${request_course.startStudyDate}" pattern="dd/MM/yyyy" var="startStudyDate" />
                                                <fmt:formatDate value="${request_course.endStudyDate}" pattern="dd/MM/yyyy" var="endStudyDate" />
                                                <tr style="color: black">
                                                    <td><p>${request_course.course.name}</p></td>
                                                    <td align="center"><p>${startPayment} - ${endPayment}</p></td>
                                                    <td align="center"><p>${applicationResult}</p></td>
                                                    <td align="center"><p>${startStudyDate} - ${endStudyDate}</p></td>
                                                    <td align="center"><p>${request_course.course.course_type}</p></td>
                                                    <td align="center">
                                                        <a href="${pageContext.request.contextPath}/lecturer/${lecturer_id}/${request_course.request_id}/list_member_to_approve">
                                                            <button class="button-5" role="button" style="font-size: 12px">
                                                                <i class='fas fa-user-friends' style='color: white; margin-right: 5px'></i>${request_course.numberOfAllRegistrationsToPass}/${request_course.numberOfAllRegistrations}
                                                            </button>
                                                        </a>
                                                    </td>
                                                </tr>
                                            </c:if>
                                        </c:forEach>
                                    </c:otherwise>
                                </c:choose>
                            </table>
                        </div>
                        <div id="app_list" style="display:none;">
                            <table class="table table-striped table-hover" style="font-size: 15px">
                                <tr style="color: black">
                                    <td>รายละเอียดหลักสูตร</td>
                                    <td style="width: 15%" align="center">ระยะเวลาชำระเงิน</td>
                                    <td style="width: 15%" align="center">วันประกาศผล</td>
                                    <td style="width: 15%" align="center">ระยะเวลาเรียน</td>
                                    <td style="width: 10%" align="center">ประเภท</td>
                                    <td style="width: 12%" align="center">ผู้สมัคร</td>
                                </tr>
                                <c:choose>
                                    <c:when test="${requests_sort_Application_date.size() == 0}">
                                        <tr>
                                            <td colspan="6" align="center">ไม่มีข้อมูล</td>
                                        </tr>
                                    </c:when>
                                    <c:otherwise>
                                        <c:forEach var="request_course" items="${requests_sort_Application_date}">
                                            <%
                                                Date currentDate = new Date(); // วันปัจจุบัน
                                            %>
                                            <c:set var="currentDate1" value="<%=currentDate%>"/>
                                            <c:if test="${request_course.endPayment.before(currentDate1) && request_course.applicationResult.after(currentDate1)}">
                                                <c:if test="${request_course.requestStatus == 'ผ่าน' &&
                                              currentDate1 > request_course.endPayment &&
                                              currentDate1 < request_course.applicationResult}">
                                                    <fmt:formatDate value="${request_course.startPayment}" pattern="dd/MM/yyyy" var="startPayment" />
                                                    <fmt:formatDate value="${request_course.endPayment}" pattern="dd/MM/yyyy" var="endPayment" />
                                                    <fmt:formatDate value="${request_course.applicationResult}" pattern="dd/MM/yyyy" var="applicationResult" />
                                                    <fmt:formatDate value="${request_course.startStudyDate}" pattern="dd/MM/yyyy" var="startStudyDate" />
                                                    <fmt:formatDate value="${request_course.endStudyDate}" pattern="dd/MM/yyyy" var="endStudyDate" />
                                                    <tr style="color: black">
                                                        <td><p>${request_course.course.name}</p></td>
                                                        <td align="center"><p>${startPayment} - ${endPayment}</p></td>
                                                        <td align="center"><p>${applicationResult}</p></td>
                                                        <td align="center"><p>${startStudyDate} - ${endStudyDate}</p></td>
                                                        <td align="center"><p>${request_course.course.course_type}</p></td>
                                                        <td align="center">
                                                            <a href="${pageContext.request.contextPath}/lecturer/${lecturer_id}/${request_course.request_id}/list_member_to_approve">
                                                                <button class="button-5" role="button" style="font-size: 12px">
                                                                    <i class='fas fa-user-friends' style='color: white; margin-right: 5px'></i>${request_course.numberOfAllRegistrationsToPass}/${request_course.numberOfAllRegistrations}
                                                                </button>
                                                            </a>
                                                        </td>
                                                    </tr>
                                                </c:if>
                                            </c:if>
                                            <c:if test="${request_course.requestStatus == 'ผ่าน' &&
                                              request_course.course.fee == 0 &&
                                              currentDate1 < request_course.applicationResult}">
                                                <fmt:formatDate value="${request_course.startPayment}" pattern="dd/MM/yyyy" var="startPayment" />
                                                <fmt:formatDate value="${request_course.endPayment}" pattern="dd/MM/yyyy" var="endPayment" />
                                                <fmt:formatDate value="${request_course.applicationResult}" pattern="dd/MM/yyyy" var="applicationResult" />
                                                <fmt:formatDate value="${request_course.startStudyDate}" pattern="dd/MM/yyyy" var="startStudyDate" />
                                                <fmt:formatDate value="${request_course.endStudyDate}" pattern="dd/MM/yyyy" var="endStudyDate" />
                                                <tr style="color: black">
                                                    <td><p>${request_course.course.name}</p></td>
                                                    <td align="center"><p>ไม่มีค่าธรรมเนียม</p></td>
                                                    <td align="center"><p>${applicationResult}</p></td>
                                                    <td align="center"><p>${startStudyDate} - ${endStudyDate}</p></td>
                                                    <td align="center"><p>${request_course.course.course_type}</p></td>
                                                    <td align="center">
                                                        <a href="${pageContext.request.contextPath}/lecturer/${lecturer_id}/${request_course.request_id}/list_member_to_approve">
                                                            <button class="button-5" role="button" style="font-size: 12px">
                                                                <i class='fas fa-user-friends' style='color: white; margin-right: 5px'></i>${request_course.numberOfAllRegistrationsToPass}/${request_course.numberOfAllRegistrations}
                                                            </button>
                                                        </a>
                                                    </td>
                                                </tr>
                                            </c:if>
                                        </c:forEach>
                                    </c:otherwise>
                                </c:choose>
                            </table>
                        </div>
                    </div>

                    <div id="list_study">
                        <table class="table table-striped table-hover" style="font-size: 15px">
                            <tr style="color: black">
                                <td style="width: 25%;">รายละเอียดหลักสูตร</td>
                                <td style="width: 15%" align="center">ระยะเวลาเรียน</td>
                                <td style="width: 10%"align="center">ประเภท</td>
                                <td style="width: 10%"align="center">ตัวอย่างเกียรติบัตร</td>
                                <td style="width: 10%"align="center">ผู้สมัคร</td>
                                <td style="width: 20%"align="center"></td>
                            </tr>
                            <c:choose>
                                <c:when test="${requests_sort_endStudy_date.size() == 0}">
                                    <tr>
                                        <td colspan="6" align="center">ไม่มีข้อมูล</td>
                                    </tr>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach var="request_course" items="${requests_sort_endStudy_date}">
                                        <c:if test="${request_course.requestStatus == 'ผ่าน' && request_course.course.status == 'เปิดสอน'}">
                                            <fmt:formatDate value="${request_course.startStudyDate}" pattern="dd/MM/yyyy" var="startStudyDate" />
                                            <fmt:formatDate value="${request_course.endStudyDate}" pattern="dd/MM/yyyy" var="endStudyDate" />
                                            <tr style="color: black">
                                                <td><p>${request_course.course.name}</p></td>
                                                <td align="center"><p>${startStudyDate} - ${endStudyDate}</p></td>
                                                <td align="center"><p>${request_course.course.course_type}</p></td>
                                                <td align="center">
                                                    <a href="${pageContext.request.contextPath}/lecturer/${lecturer_id}/${request_course.request_id}/view_sample_certificate">ดูตัวอย่าง</a>
                                                </td>
                                                <td align="center">
                                                    <a href="${pageContext.request.contextPath}/lecturer/${lecturer_id}/${request_course.request_id}/list_member_to_approve">
                                                        <button class="button-5" role="button" style="font-size: 12px">
                                                            <i class='fas fa-user-friends' style='color: white; margin-right: 5px'></i>${request_course.numberOfApprovedRegistrations}/${request_course.numberOfAllRegistrationsToPass}
                                                        </button>
                                                    </a>
                                                </td>
                                                <td align="center">
                                                    <button type="button" style="font-size: 12px"
                                                            onclick="window.location.href='${pageContext.request.contextPath}/lecturer/${request_course.request_id}/add_course_activity'; return false;"
                                                            class="activity-btn">
                                                        <i class='fas fa-plus-circle' style='color: #ffffff; margin-right: 5px'></i> เพิ่มข่าวสาร
                                                    </button>
                                                    <button type="button" style="font-size: 12px"
                                                            onclick="window.location.href='${pageContext.request.contextPath}/lecturer/${request_course.request_id}/list_course_activity_news'; return false;"
                                                            class="list-activity-btn">
                                                        <i class='fa fa-list' style='color: #0077ff; margin-right: 5px'></i> รายการข่าวสาร
                                                    </button>
                                                </td>
                                            </tr>
                                        </c:if>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                        </table>
                    </div>
                </div>
            </td>
        </tr>

    </table>

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
    // ดึงค่าพารามิเตอร์ success จาก URL
    const urlParams = new URLSearchParams(window.location.search);
    const addParam = urlParams.get('addStatus');
    const editParam = urlParams.get('editStatus');
    const deleteParam = urlParams.get('deleteStatus');

    // ถ้ามีค่าเป็น 'true', แสดง Alert
    if (addParam === 'true') {
        alert("เพิ่มข้อมูลการร้องขอสำเร็จ");
    }else if (editParam === 'true'){
        alert("แก้ไขข้อมูลการร้องขอสำเร็จ");
    }else if (deleteParam === 'true'){
        alert("ลบข้อมูลการร้องขอสำเร็จ");
    }
</script>
<script>
    function checkSelection() {
        var selectElement = document.getElementById("select_type");
        var selectedValue = selectElement.value;

        if (selectedValue === "กำลังลงทะเบียน") {
            document.getElementById("tag_line").textContent = "หลักสูตรที่กำลังลงทะเบียน"
            document.getElementById("list_register").style.display = "block";
            document.getElementById("list_payment").style.display = "none";
            document.getElementById("list_study").style.display = "none";
        } else if (selectedValue === "กำลังชำระเงิน") {
            document.getElementById("tag_line").textContent = "หลักสูตรที่กำลังชำระเงิน"
            document.getElementById("list_register").style.display = "none";
            document.getElementById("list_payment").style.display = "block";
            document.getElementById("list_study").style.display = "none";
        }else if (selectedValue === "กำลังเรียน") {
            document.getElementById("tag_line").textContent = "หลักสูตรที่กำลังเรียน"
            document.getElementById("list_register").style.display = "none";
            document.getElementById("list_payment").style.display = "none";
            document.getElementById("list_study").style.display = "block";
        }
    }
    window.addEventListener('load',checkSelection);
</script>
<script>
    var allPay = document.querySelector('input[name="listPay"][value="การชำระเงิน"]');
    allPay.addEventListener("change", function() {
        if (allPay.checked) {
            document.getElementById("payment_list").style.display = "block";
            document.getElementById("app_list").style.display = "none";
        }
    });

    var listApp = document.querySelector('input[name="listPay"][value="รอประกาศผล"]');
    listApp.addEventListener("change", function() {
        if (listApp.checked) {
            document.getElementById("payment_list").style.display = "none";
            document.getElementById("app_list").style.display = "block";
        }
    });
</script>
</html>
