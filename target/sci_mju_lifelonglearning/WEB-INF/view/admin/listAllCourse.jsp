<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="lifelong.model.Admin" %>
<%@ page import="lifelong.model.Member" %>
<%@ page import="lifelong.model.Lecturer" %>
<html>
<head>
    <title>หลักสูตรทั้งหมด</title>
    <%--    <link href="${pageContext.request.contextPath}/assets/css/list_open_course_style.css" rel="stylesheet">--%>
    <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/admin/listAllCourse.css" rel="stylesheet">

    <jsp:include page="/WEB-INF/view/layouts/detail-all-style.jsp"/>
    <style>
        body{
            font-family: 'Prompt', sans-serif;
        }
        table{
            font-size: 12px;
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
        <div align="center" class="main_container" style="font-size: 12px">
            <c:set var="colorBar" value="#fbc44f"/>
            <br>
            <br>
            <h1>หลักสูตรทั้งหมด</h1>
            <table class="container" style="font-size: 12px">
                <tr align="center">
                    <td class="list_course" align="center">
                            <%--DIV แรก--%>
                        <div id="course" class="tabcontent" align="left" style="width: 100%">
                            <br>
                            <table style="width: 100%;">
                                <tr>
                                    <td align="left" style="width: 50%">
                                        <h5 id="tag_line"><b></b></h5>
                                    </td>
                                    <td align="right" style="width: 30%">
                                        <select id="select_type" class="form-select" aria-label="Default select example" onchange="checkSelection()">
                                            <option value="กำลังลงทะเบียน" selected>กำลังลงทะเบียน</option>
                                                <%--                                            <option value="กำลังชำระเงิน">กำลังชำระเงิน</option>--%>
                                            <option value="กำลังสอน">กำลังสอน</option>
                                            <option value="หลักสูตรที่เสร็จสิ้นการเรียน">หลักสูตรที่เสร็จสิ้นการเรียน</option>
                                            <option value="ถูกยกเลิก">ถูกยกเลิก</option>
                                            <option value="ยังไม่เปิดสอน">ยังไม่เปิดสอน</option>
                                        </select>
                                    </td>
                                </tr>
                            </table>
                            <hr>
                            <div id="register_select" style="display: none">
                                <div style="width: 100%" align="center">
                                    <input type="radio" name="listDisplay" id="chk1" value="หลักสูตรทั้งหมด" checked>
                                    <label>หลักสูตรทั้งหมด</label>
                                    <input type="radio" name="listDisplay" id="chk2" value="หลักสูตรเปิดรับสมัคร">
                                    <label>หลักสูตรเปิดรับสมัคร</label>
                                    <input type="radio" name="listDisplay" id="chk3" value="หลักสูตรเปิดรับสมัคร/ชำระเงิน">
                                    <label>หลักสูตรเปิดรับสมัคร/ชำระเงิน</label>
                                    <input type="radio" name="listDisplay" id="chk4" value="หลักสูตรที่ชำระเงินเท่านั้น">
                                    <label>หลักสูตรที่ชำระเงินเท่านั้น</label>
                                    <input type="radio" name="listDisplay" id="chk5" value="หลักสูตรที่สมัครครบแล้ว">
                                    <label>หลักสูตรที่สมัครครบแล้ว</label>
                                    <input type="radio" name="listDisplay" id="chk6" value="รอประกาศผล">
                                    <label>รอประกาศผล</label>
                                </div>
                                <hr>

                                <div id="all_register" style="display: block">
                                    <table class="table table-hover">
                                        <thead style="background-color: ${colorBar};">
                                            <tr style="color: black">
                                                <td style="width: 30%"><b style="font-size: 14px">ชื่อหลักสูตร</b></td>
                                                <td style="width: 16%" align="center"><b style="font-size: 14px">ระยะเวลาการลงทะเบียน</b></td>
                                                <td style="width: 15%" align="center"><b style="font-size: 14px">ระยะเวลาการชำระเงิน</b></td>
                                                <td style="width: 8%" align="center"><b style="font-size: 14px">วันประกาศผล</b></td>
                                                <td style="width: 15%" align="center"><b style="font-size: 14px">ระยะเวลาการเรียน</b></td>
                                                <td style="width: 10%" align="center"><b style="font-size: 14px">สถานะ</b></td>
                                                <td style="width: 10%" align="center"><b style="font-size: 14px">ผู้สมัคร</b></td>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        <c:choose>
                                            <c:when test="${all_requests_by_register.size() == 0}">
                                                <tr>
                                                    <td colspan="7" align="center">ไม่มีข้อมูล</td>
                                                </tr>
                                            </c:when>
                                            <c:otherwise>
                                                <c:forEach var="request" items="${all_requests_by_register}">
                                                    <tr style="color: black;">
                                                        <fmt:formatDate value="${request.requestDate}" pattern="dd/MM/yyyy" var="requestDate" />
                                                        <fmt:formatDate value="${request.startRegister}" pattern="dd/MM/yyyy" var="startRegister" />
                                                        <fmt:formatDate value="${request.endRegister}" pattern="dd/MM/yyyy" var="endRegister" />
                                                        <fmt:formatDate value="${request.startStudyDate}" pattern="dd/MM/yyyy" var="startStudyDate" />
                                                        <fmt:formatDate value="${request.endStudyDate}" pattern="dd/MM/yyyy" var="endStudyDate" />
                                                        <fmt:formatDate value="${request.startPayment}" pattern="dd/MM/yyyy" var="startPayment" />
                                                        <fmt:formatDate value="${request.endPayment}" pattern="dd/MM/yyyy" var="endPayment" />
                                                        <fmt:formatDate value="${request.applicationResult}" pattern="dd/MM/yyyy" var="applicationResult" />

                                                        <td><p>${request.course.name}</p></td>
                                                        <td align="center">
                                                            <p>${startRegister} - ${endRegister}</p><br>
                                                        </td>
                                                        <c:choose>
                                                            <c:when test="${request.course.fee != 0}">
                                                                <td align="center"><p>${startPayment} - ${endPayment}</p></td>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <td align="center"><p>ไม่มีการชำระเงิน(ฟรี)</p></td>
                                                            </c:otherwise>
                                                        </c:choose>
                                                        <td align="center">
                                                            <p>${applicationResult}</p><br>
                                                        </td>
                                                        <td align="center">
                                                            <p>${startStudyDate} - ${endStudyDate}</p><br>
                                                        </td>
                                                        <td align="center">
                                                            <p>${request.course.status}</p><br>
                                                        </td>
                                                        <td align="center"><a href="${pageContext.request.contextPath}/course/${request.request_id}/list_member_to_course">
                                                            <button class="button-35" role="button"><i class="fa fa-users" style="margin-right: 10px"></i>
                                                                <c:choose>
                                                                    <c:when test="${request.course.status == 'ลงทะเบียน'}">
                                                                        ${request.numberOfAllRegistrations} / ${request.quantity}
                                                                    </c:when>
                                                                    <c:when test="${request.course.status == 'ลงทะเบียน/ชำระเงิน'}">
                                                                        ${request.registerList.size()} / ${request.quantity}
                                                                    </c:when>
                                                                    <c:when test="${request.course.status == 'ชำระเงิน'}">
                                                                        ${request.numberOfAllRegistrationsPayStatus} / ${request.registerList.size()}
                                                                    </c:when>
                                                                    <c:when test="${request.course.status == 'รอประกาศผล'}">
                                                                        ${request.numberOfAllRegistrationsPayStatus} / ${request.registerList.size()}
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        ${request.numberOfAllRegistrations} / ${request.quantity}
                                                                    </c:otherwise>
                                                                </c:choose>

                                                            </button>
                                                        </a></td>
                                                    </tr>
                                                </c:forEach>
                                            </c:otherwise>
                                        </c:choose>
                                        </tbody>
                                    </table>
                                </div>
                                <div id="no_max_register" style="display: none">
                                    <table class="table table-hover">
                                        <thead style="background-color: ${colorBar};">
                                            <tr style="color: black">
                                                <td style="width: 30%"><b style="font-size: 14px">ชื่อหลักสูตร</b></td>
                                                <td style="width: 16%" align="center"><b style="font-size: 14px">ระยะเวลาการลงทะเบียน</b></td>
                                                <td style="width: 15%" align="center"><b style="font-size: 14px">ระยะเวลาการชำระเงิน</b></td>
                                                <td style="width: 8%" align="center"><b style="font-size: 14px">วันประกาศผล</b></td>
                                                <td style="width: 15%" align="center"><b style="font-size: 14px">ระยะเวลาการเรียน</b></td>
                                                <td style="width: 10%" align="center"><b style="font-size: 14px">สถานะ</b></td>
                                                <td style="width: 10%" align="center"><b style="font-size: 14px">ผู้สมัคร</b></td>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        <c:choose>
                                            <c:when test="${no_max_requests_by_register.size() == 0}">
                                                <tr>
                                                    <td colspan="7" align="center">ไม่มีข้อมูล</td>
                                                </tr>
                                            </c:when>
                                            <c:otherwise>
                                                <c:forEach var="request" items="${no_max_requests_by_register}">
                                                    <tr style="color: black;">
                                                        <fmt:formatDate value="${request.requestDate}" pattern="dd/MM/yyyy" var="requestDate" />
                                                        <fmt:formatDate value="${request.startRegister}" pattern="dd/MM/yyyy" var="startRegister" />
                                                        <fmt:formatDate value="${request.endRegister}" pattern="dd/MM/yyyy" var="endRegister" />
                                                        <fmt:formatDate value="${request.startStudyDate}" pattern="dd/MM/yyyy" var="startStudyDate" />
                                                        <fmt:formatDate value="${request.endStudyDate}" pattern="dd/MM/yyyy" var="endStudyDate" />
                                                        <fmt:formatDate value="${request.startPayment}" pattern="dd/MM/yyyy" var="startPayment" />
                                                        <fmt:formatDate value="${request.endPayment}" pattern="dd/MM/yyyy" var="endPayment" />
                                                        <fmt:formatDate value="${request.applicationResult}" pattern="dd/MM/yyyy" var="applicationResult" />
                                                        <td><p>${request.course.name}</p></td>
                                                        <td align="center">
                                                            <p>${startRegister} - ${endRegister}</p><br>
                                                        </td>
                                                        <c:choose>
                                                            <c:when test="${request.course.fee != 0}">
                                                                <td align="center"><p>${startPayment} - ${endPayment}</p></td>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <td align="center"><p>ไม่มีการชำระเงิน(ฟรี)</p></td>
                                                            </c:otherwise>
                                                        </c:choose>
                                                        <td align="center">
                                                            <p>${applicationResult}</p><br>
                                                        </td>
                                                        <td align="center">
                                                            <p>${startStudyDate} - ${endStudyDate}</p><br>
                                                        </td>
                                                        <td align="center">
                                                            <p>${request.course.status}</p><br>
                                                        </td>
                                                        <td align="center"><a href="${pageContext.request.contextPath}/course/${request.request_id}/list_member_to_course">
                                                            <button class="button-35" role="button"><i class="fa fa-users" style="margin-right: 10px"></i>
                                                                    ${request.numberOfAllRegistrations} / ${request.quantity}
                                                            </button>
                                                        </a></td>
                                                    </tr>
                                                </c:forEach>
                                            </c:otherwise>
                                        </c:choose>
                                        </tbody>
                                    </table>
                                </div>
                                <div id="register_and_payment" style="display: none">
                                    <table class="table table-hover">
                                        <thead style="background-color: ${colorBar};">
                                            <tr style="color: black">
                                                <td style="width: 30%"><b style="font-size: 14px">ชื่อหลักสูตร</b></td>
                                                <td style="width: 16%" align="center"><b style="font-size: 14px">ระยะเวลาการลงทะเบียน</b></td>
                                                <td style="width: 15%" align="center"><b style="font-size: 14px">ระยะเวลาการชำระเงิน</b></td>
                                                <td style="width: 8%" align="center"><b style="font-size: 14px">วันประกาศผล</b></td>
                                                <td style="width: 15%" align="center"><b style="font-size: 14px">ระยะเวลาการเรียน</b></td>
                                                <td style="width: 10%" align="center"><b style="font-size: 14px">สถานะ</b></td>
                                                <td style="width: 10%" align="center"><b style="font-size: 14px">ผู้สมัคร</b></td>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        <c:choose>
                                            <c:when test="${regis_pay_requests_by_register.size() == 0}">
                                                <tr>
                                                    <td colspan="7" align="center">ไม่มีข้อมูล</td>
                                                </tr>
                                            </c:when>
                                            <c:otherwise>
                                                <c:forEach var="request" items="${regis_pay_requests_by_register}">
                                                    <tr style="color: black;">
                                                        <fmt:formatDate value="${request.requestDate}" pattern="dd/MM/yyyy" var="requestDate" />
                                                        <fmt:formatDate value="${request.startRegister}" pattern="dd/MM/yyyy" var="startRegister" />
                                                        <fmt:formatDate value="${request.endRegister}" pattern="dd/MM/yyyy" var="endRegister" />
                                                        <fmt:formatDate value="${request.startStudyDate}" pattern="dd/MM/yyyy" var="startStudyDate" />
                                                        <fmt:formatDate value="${request.endStudyDate}" pattern="dd/MM/yyyy" var="endStudyDate" />
                                                        <fmt:formatDate value="${request.startPayment}" pattern="dd/MM/yyyy" var="startPayment" />
                                                        <fmt:formatDate value="${request.endPayment}" pattern="dd/MM/yyyy" var="endPayment" />
                                                        <fmt:formatDate value="${request.applicationResult}" pattern="dd/MM/yyyy" var="applicationResult" />
                                                        <td><p>${request.course.name}</p></td>
                                                        <td align="center">
                                                            <p>${startRegister} - ${endRegister}</p><br>
                                                        </td>
                                                        <c:choose>
                                                            <c:when test="${request.course.fee != 0}">
                                                                <td align="center"><p>${startPayment} - ${endPayment}</p></td>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <td align="center"><p>ไม่มีการชำระเงิน(ฟรี)</p></td>
                                                            </c:otherwise>
                                                        </c:choose>
                                                        <td align="center">
                                                            <p>${applicationResult}</p><br>
                                                        </td>
                                                        <td align="center">
                                                            <p>${startStudyDate} - ${endStudyDate}</p><br>
                                                        </td>
                                                        <td align="center">
                                                            <p>${request.course.status}</p><br>
                                                        </td>
                                                        <td align="center"><a href="${pageContext.request.contextPath}/course/${request.request_id}/list_member_to_course">
                                                            <button class="button-35" role="button"><i class="fa fa-users" style="margin-right: 10px"></i>
                                                                    ${request.registerList.size()} / ${request.quantity}
                                                            </button>
                                                        </a></td>
                                                    </tr>
                                                </c:forEach>
                                            </c:otherwise>
                                        </c:choose>
                                        </tbody>
                                    </table>
                                </div>
                                <div id="payment_list" style="display: none">
                                    <table class="table table-hover">
                                        <thead style="background-color: ${colorBar};">
                                            <tr style="color: black">
                                                <td style="width: 30%"><b style="font-size: 14px">ชื่อหลักสูตร</b></td>
                                                <td style="width: 20%" align="center"><b style="font-size: 14px">ระยะเวลาการชำระเงิน</b></td>
                                                <td style="width: 15%" align="center"><b style="font-size: 14px">วันประกาศผล</b></td>
                                                <td style="width: 20%" align="center"><b style="font-size: 14px">ระยะเวลาการเรียน</b></td>
                                                <td style="width: 10%" align="center"><b style="font-size: 14px">สถานะ</b></td>
                                                <td style="width: 10%" align="center"><b style="font-size: 14px">ผู้สมัคร</b></td>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        <c:choose>
                                            <c:when test="${pay_requests_by_register.size() == 0}">
                                                <tr>
                                                    <td colspan="6" align="center">ไม่มีข้อมูล</td>
                                                </tr>
                                            </c:when>
                                            <c:otherwise>
                                                <c:forEach var="request" items="${pay_requests_by_register}">
                                                    <tr style="color: black">
                                                        <fmt:formatDate value="${request.startPayment}" pattern="dd/MM/yyyy" var="startPayment" />
                                                        <fmt:formatDate value="${request.endPayment}" pattern="dd/MM/yyyy" var="endPayment" />
                                                        <fmt:formatDate value="${request.applicationResult}" pattern="dd/MM/yyyy" var="applicationResult" />
                                                        <fmt:formatDate value="${request.startStudyDate}" pattern="dd/MM/yyyy" var="startStudyDate" />
                                                        <fmt:formatDate value="${request.endStudyDate}" pattern="dd/MM/yyyy" var="endStudyDate" />
                                                        <td><p>${request.course.name}</p></td>
                                                        <td align="center">
                                                            <p>${startPayment} - ${endPayment}</p><br>
                                                        </td>
                                                        <td align="center"><p>${applicationResult}</p></td>
                                                        <td align="center">
                                                            <p>${startStudyDate} - ${endStudyDate}</p><br>
                                                        </td>
                                                        <td align="center">
                                                            <p>${request.course.status}</p><br>
                                                        </td>
                                                        <td align="center"><a href="${pageContext.request.contextPath}/course/${request.request_id}/list_member_to_course">
                                                            <button class="button-35" role="button"><i class="fa fa-users" style="margin-right: 10px"></i>
                                                                    ${request.numberOfAllRegistrationsPayStatus} / ${request.registerList.size()}
                                                            </button>
                                                        </a></td>
                                                    </tr>
                                                </c:forEach>
                                            </c:otherwise>
                                        </c:choose>
                                        </tbody>
                                    </table>
                                </div>
                                <div id="max_register" style="display: none">
                                    <table class="table table-hover">
                                        <thead style="background-color: ${colorBar};">
                                            <tr style="color: black">
                                                <td style="width: 30%"><b style="font-size: 14px">ชื่อหลักสูตร</b></td>
                                                <td style="width: 16%" align="center"><b style="font-size: 14px">ระยะเวลาการลงทะเบียน</b></td>
                                                <td style="width: 15%" align="center"><b style="font-size: 14px">ระยะเวลาการชำระเงิน</b></td>
                                                <td style="width: 8%" align="center"><b style="font-size: 14px">วันประกาศผล</b></td>
                                                <td style="width: 15%" align="center"><b style="font-size: 14px">ระยะเวลาการเรียน</b></td>
                                                <td style="width: 10%" align="center"><b style="font-size: 14px">สถานะ</b></td>
                                                <td style="width: 10%" align="center"><b style="font-size: 14px">ผู้สมัคร</b></td>
                                                <td style="width: 10%" align="center"></td>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        <c:choose>
                                            <c:when test="${requests_by_max_register.size() == 0}">
                                                <tr>
                                                    <td colspan="8" align="center">ไม่มีข้อมูล</td>
                                                </tr>
                                            </c:when>
                                            <c:otherwise>
                                                <c:forEach var="request" items="${requests_by_max_register}">
                                                    <tr style="color: black;">
                                                        <fmt:formatDate value="${request.requestDate}" pattern="dd/MM/yyyy" var="requestDate" />
                                                        <fmt:formatDate value="${request.startRegister}" pattern="dd/MM/yyyy" var="startRegister" />
                                                        <fmt:formatDate value="${request.endRegister}" pattern="dd/MM/yyyy" var="endRegister" />
                                                        <fmt:formatDate value="${request.startStudyDate}" pattern="dd/MM/yyyy" var="startStudyDate" />
                                                        <fmt:formatDate value="${request.endStudyDate}" pattern="dd/MM/yyyy" var="endStudyDate" />
                                                        <fmt:formatDate value="${request.startPayment}" pattern="dd/MM/yyyy" var="startPayment" />
                                                        <fmt:formatDate value="${request.endPayment}" pattern="dd/MM/yyyy" var="endPayment" />
                                                        <fmt:formatDate value="${request.applicationResult}" pattern="dd/MM/yyyy" var="applicationResult" />
                                                        <td><p>${request.course.name}</p></td>
                                                        <td align="center">
                                                            <p>${startRegister} - ${endRegister}</p><br>
                                                        </td>
                                                        <c:choose>
                                                            <c:when test="${request.course.fee != 0}">
                                                                <td align="center"><p>${startPayment} - ${endPayment}</p></td>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <td align="center"><p>ไม่มีการชำระเงิน(ฟรี)</p></td>
                                                            </c:otherwise>
                                                        </c:choose>
                                                        <td align="center">
                                                            <p>${applicationResult}</p><br>
                                                        </td>
                                                        <td align="center">
                                                            <p>${startStudyDate} - ${endStudyDate}</p><br>
                                                        </td>
                                                        <td align="center">
                                                            <p>${request.course.status}</p><br>
                                                        </td>
                                                        <td align="center"><a href="${pageContext.request.contextPath}/course/${request.request_id}/list_member_to_course">
                                                            <button class="button-35" role="button"><i class="fa fa-users" style="margin-right: 10px"></i>
                                                                    ${request.registerList.size()} / ${request.quantity}
                                                            </button>
                                                        </a></td>
                                                        <td align="center"><a href="${pageContext.request.contextPath}/course/${request.request_id}/close_register">
                                                            <form method="post" action="${pageContext.request.contextPath}/course/${request.request_id}/close_register">
                                                                <button class="btn btn-outline-danger" role="button" style="font-size: 12px">
                                                                    ปิดลงทะเบียน
                                                                </button>
                                                            </form>
                                                        </a></td>
                                                    </tr>
                                                </c:forEach>
                                            </c:otherwise>
                                        </c:choose>
                                        </tbody>
                                    </table>
                                </div>
                                <div id="app_list" style="display: none">
                                    <table class="table table-hover">
                                        <thead style="background-color: ${colorBar};">
                                            <tr style="color: black">
                                                <td style="width: 30%"><b style="font-size: 14px">ชื่อหลักสูตร</b></td>
                                                <td style="width: 20%" align="center"><b style="font-size: 14px">ระยะเวลาการชำระเงิน</b></td>
                                                <td style="width: 15%" align="center"><b style="font-size: 14px">วันประกาศผล</b></td>
                                                <td style="width: 20%" align="center"><b style="font-size: 14px">ระยะเวลาการเรียน</b></td>
                                                <td style="width: 10%" align="center"><b style="font-size: 14px">สถานะ</b></td>
                                                <td style="width: 15%" align="center"><b style="font-size: 14px">ผู้สมัคร</b></td>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        <c:choose>
                                            <c:when test="${app_requests_by_register.size() == 0}">
                                                <tr>
                                                    <td colspan="6" align="center">ไม่มีข้อมูล</td>
                                                </tr>
                                            </c:when>
                                            <c:otherwise>
                                                <c:forEach var="request" items="${app_requests_by_register}">
                                                    <tr style="color: black">
                                                        <fmt:formatDate value="${request.startPayment}" pattern="dd/MM/yyyy" var="startPayment" />
                                                        <fmt:formatDate value="${request.endPayment}" pattern="dd/MM/yyyy" var="endPayment" />
                                                        <fmt:formatDate value="${request.applicationResult}" pattern="dd/MM/yyyy" var="applicationResult" />
                                                        <fmt:formatDate value="${request.startStudyDate}" pattern="dd/MM/yyyy" var="startStudyDate" />
                                                        <fmt:formatDate value="${request.endStudyDate}" pattern="dd/MM/yyyy" var="endStudyDate" />
                                                        <td><p>${request.course.name}</p></td>
                                                        <c:choose>
                                                            <c:when test="${request.course.fee != 0}">
                                                                <td align="center"><p>${startPayment} - ${endPayment}</p></td>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <td align="center"><p>ไม่มีการชำระเงิน(ฟรี)</p></td>
                                                            </c:otherwise>
                                                        </c:choose>
                                                        <td align="center"><p>${applicationResult}</p></td>
                                                        <td align="center">
                                                            <p>${startStudyDate} - ${endStudyDate}</p><br>
                                                        </td>
                                                        <td align="center">
                                                            <p>${request.course.status}</p><br>
                                                        </td>
                                                        <td align="center"><a href="${pageContext.request.contextPath}/course/${request.request_id}/list_member_to_course">
                                                            <button class="button-35" role="button"><i class="fa fa-users" style="margin-right: 10px"></i>
                                                                    ${request.numberOfAllRegistrationsPayStatus} / ${request.registerList.size()}
                                                            </button>
                                                        </a></td>
                                                    </tr>
                                                </c:forEach>
                                            </c:otherwise>
                                        </c:choose>
                                        </tbody>
                                    </table>
                                </div>

                            </div>
                            <div id="study_select" style="display: none">
                                <table class="table table-hover">
                                    <thead style="background-color: ${colorBar};">
                                        <tr style="color: black">
                                            <td style="width: 25%"><b style="font-size: 14px">ชื่อหลักสูตร</b></td>
                                            <td style="width: 20%" align="center"><b style="font-size: 14px">ระยะเวลาการเรียน</b></td>
                                            <td style="width: 20%" align="center"><b style="font-size: 14px">อาจารย์ผู้สอน</b></td>
                                            <td style="width: 20%" align="center"><b style="font-size: 14px">สาขา</b></td>
                                            <td style="width: 10%" align="center"><b style="font-size: 14px">ประเภท</b></td>
                                            <td style="width: 10%" align="center"><b style="font-size: 14px">ผู้สมัคร</b></td>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    <c:choose>
                                        <c:when test="${all_requests_by_study.size() == 0}">
                                            <tr>
                                                <td colspan="6" align="center">ไม่มีข้อมูล</td>
                                            </tr>
                                        </c:when>
                                        <c:otherwise>
                                            <c:forEach var="request" items="${all_requests_by_study}">
                                                <tr style="color: black">
                                                    <fmt:formatDate value="${request.startStudyDate}" pattern="dd/MM/yyyy" var="startStudyDate" />
                                                    <fmt:formatDate value="${request.endStudyDate}" pattern="dd/MM/yyyy" var="endStudyDate" />
                                                    <td><p>${request.course.name}</p></td>
                                                    <td align="center">
                                                        <p>${startStudyDate} - ${endStudyDate}</p><br>
                                                    </td>
                                                    <td align="center">
                                                        <p>${request.lecturer.firstName} ${request.lecturer.lastName}</p><br>
                                                    </td>
                                                    <td align="center">
                                                        <p>${request.course.major.name}</p><br>
                                                    </td>
                                                    <td align="center"><p>${request.course.course_type}</p></td>
                                                    <td align="center"><a href="${pageContext.request.contextPath}/course/${request.request_id}/list_member_to_course">
                                                        <button class="button-35" role="button"><i class="fa fa-users" style="margin-right: 10px"></i>
                                                                ${request.numberOfAllRegistrationsToPass} คน
                                                        </button>
                                                    </a></td>

                                                </tr>
                                            </c:forEach>
                                        </c:otherwise>
                                    </c:choose>
                                    </tbody>
                                </table>
                            </div>
                            <div id="finish_study" style="display: none">
                                <table class="table table-hover">
                                    <thead style="background-color: ${colorBar};">
                                    <tr style="color: black">
                                        <td style="width: 25%"><b style="font-size: 14px">ชื่อหลักสูตร</b></td>
                                        <td style="width: 20%" align="center"><b style="font-size: 14px">ระยะเวลาการเรียน</b></td>
                                        <td style="width: 15%" align="center"><b style="font-size: 14px">อาจารย์ผู้สอน</b></td>
                                        <td style="width: 10%" align="center"><b style="font-size: 14px">สถานะ</b></td>
                                        <td style="width: 15%" align="center"><b style="font-size: 14px">สาขา</b></td>
                                        <td style="width: 10%" align="center"><b style="font-size: 14px">ประเภท</b></td>
                                        <td style="width: 10%" align="center"><b style="font-size: 14px">ผู้สมัคร</b></td>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:choose>
                                        <c:when test="${all_requests_by_finish_study.size() == 0}">
                                            <tr>
                                                <td colspan="7" align="center">ไม่มีข้อมูล</td>
                                            </tr>
                                        </c:when>
                                        <c:otherwise>
                                            <c:forEach var="request" items="${all_requests_by_finish_study}">
                                                <tr style="color: black">
                                                    <fmt:formatDate value="${request.startStudyDate}" pattern="dd/MM/yyyy" var="startStudyDate" />
                                                    <fmt:formatDate value="${request.endStudyDate}" pattern="dd/MM/yyyy" var="endStudyDate" />
                                                    <td><p>${request.course.name}</p></td>
                                                    <td align="center">
                                                        <p>${startStudyDate} - ${endStudyDate}</p><br>
                                                    </td>
                                                    <td align="center">
                                                        <p>${request.lecturer.firstName} ${request.lecturer.lastName}</p><br>
                                                    </td>
                                                    <td align="center">
                                                        <p>${request.requestStatus}</p><br>
                                                    </td>
                                                    <td align="center">
                                                        <p>${request.course.major.name}</p><br>
                                                    </td>
                                                    <td align="center"><p>${request.course.course_type}</p></td>
                                                    <td align="center"><a href="${pageContext.request.contextPath}/course/${request.request_id}/list_member_to_course">
                                                        <button class="button-35" role="button"><i class="fa fa-users" style="margin-right: 10px"></i>
                                                                ${request.numberOfAllRegistrationsByStudyResult} / ${request.numberOfAllRegistrationsToPass}
                                                        </button>
                                                    </a></td>

                                                </tr>
                                            </c:forEach>
                                        </c:otherwise>
                                    </c:choose>
                                    </tbody>
                                </table>
                            </div>
                            <div id="not_study_select" style="display: none">
                                <table class="table table-hover">
                                    <thead style="background-color: ${colorBar};">
                                        <tr style="color: black">
                                            <td style="width: 30%"><b style="font-size: 14px">ชื่อหลักสูตร</b></td>
                                            <td style="width: 10%" align="center"><b style="font-size: 14px">วันที่เพิ่มหลักสูตร</b></td>
                                            <td style="width: 10%" align="center"><b style="font-size: 14px">ค่าธรรมเนียม</b></td>
                                            <td style="width: 7%" align="center"><b style="font-size: 14px">ชั่วโมงที่เรียน</b></td>
                                            <td style="width: 20%" align="center"><b style="font-size: 14px">สาขา</b></td>
                                            <td style="width: 10%" align="center"><b style="font-size: 14px">ประเภท</b></td>
                                            <td style="width: 10%" align="center"></td>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    <c:choose>
                                        <c:when test="${all_requests_by_not_study.size() == 0}">
                                            <tr>
                                                <td colspan="6" align="center">ไม่มีข้อมูล</td>
                                            </tr>
                                        </c:when>
                                        <c:otherwise>
                                            <c:forEach var="course" items="${all_requests_by_not_study}">
                                                <tr style="color: black">
                                                    <fmt:parseNumber var="courseFee" type="number" value="${course.fee}"/>
                                                    <fmt:formatDate value="${course.action_date}" pattern="dd/MM/yyyy" var="action_date" />
                                                    <td><p>${course.name}</p></td>
                                                    <td align="center"><p>${action_date}</p></td>
                                                    <c:choose>
                                                        <c:when test="${course.fee == 0}">
                                                            <td align="center"><p>ไม่มีค่าธรรมเนียม</p></td>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <td align="center"><p><fmt:formatNumber value="${courseFee}"/> บาท</p></td>
                                                        </c:otherwise>
                                                    </c:choose>
                                                    <td align="center"><p>${course.totalHours} ชั่วโมง</p></td>
                                                    <td align="center"><p>${course.major.name}</p></td>
                                                    <td align="center"><p>${course.course_type}</p></td>
                                                    <td align="center">
                                                        <a href="${pageContext.request.contextPath}/course/${course.course_id}/edit_course">
                                                            <button type="button" class="btn btn-outline-warning" style="font-size: 12px">
                                                                <i class='fa fa-edit'></i>แก้ไข</button>
                                                        </a>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </c:otherwise>
                                    </c:choose>
                                    </tbody>
                                </table>
                            </div>

                            <div id="cancel_request_select" style="display: none">
                                <table class="table table-hover">
                                    <thead style="background-color: ${colorBar};">
                                        <tr style="color: black">
                                            <td style="width: 30%"><b style="font-size: 14px">ชื่อหลักสูตร</b></td>
                                            <td style="width: 8%"  align="center"><b style="font-size: 14px">วันที่ร้องขอ</b></td>
                                            <td style="width: 15%" align="center"><b style="font-size: 14px">วันรับสมัคร</b></td>
                                            <td style="width: 8%" align="center"><b style="font-size: 14px">วันประกาศผล</b></td>
                                            <td style="width: 15%" align="center"><b style="font-size: 14px">ระยะเวลาการเรียน</b></td>
                                            <td style="width: 10%" align="center"><b style="font-size: 14px">ประเภท</b></td>
                                            <td style="width: 10%" align="center"></td>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:choose>
                                            <c:when test="${all_cancel_requests.size() == 0}">
                                                <tr>
                                                    <td colspan="7" align="center">ไม่มีข้อมูล</td>
                                                </tr>
                                            </c:when>
                                            <c:otherwise>
                                                <c:forEach var="request" items="${all_cancel_requests}">
                                                    <tr style="color: black">
                                                        <fmt:formatDate value="${request.applicationResult}" pattern="dd/MM/yyyy" var="applicationResult" />
                                                        <fmt:formatDate value="${request.startStudyDate}" pattern="dd/MM/yyyy" var="startStudyDate" />
                                                        <fmt:formatDate value="${request.endStudyDate}" pattern="dd/MM/yyyy" var="endStudyDate" />
                                                        <fmt:formatDate value="${request.startRegister}" pattern="dd/MM/yyyy" var="startRegister" />
                                                        <fmt:formatDate value="${request.endRegister}" pattern="dd/MM/yyyy" var="endRegister" />
                                                        <fmt:formatDate value="${request.requestDate}" pattern="dd/MM/yyyy" var="requestDate" />
                                                        <td><p>${request.course.name}</p></td>
                                                        <td><p>${requestDate}</p></td>
                                                        <td align="center">
                                                            <p>${startRegister} - ${endRegister}</p><br>
                                                        </td>
                                                        <td align="center">
                                                            <p>${applicationResult}</p><br>
                                                        </td>
                                                        <td align="center">

                                                            <p>${startStudyDate} - ${endStudyDate}</p><br>
                                                        </td>
                                                        <td align="center"><p>${request.course.course_type}</p></td>
                                                        <td align="center"><a href="${pageContext.request.contextPath}/course/${request.request_id}/list_member_to_course">
                                                            <button class="button-35" role="button"><i class="fa fa-users" style="margin-right: 10px"></i>
                                                                    ${request.numberOfAllRegistrations} / ${request.quantity}
                                                            </button>
                                                        </a></td>
                                                    </tr>
                                                </c:forEach>
                                            </c:otherwise>
                                        </c:choose>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </td>
                </tr>
            </table>
            <br>
            <br>
            <br>
            <br>
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
<br>
<br>
<br>
<br>
</body>
<script>
    // ดึงค่าพารามิเตอร์ success จาก URL
    const urlParams = new URLSearchParams(window.location.search);
    const successParam = urlParams.get('success');
    const editParam = urlParams.get('editStatus');
    const approveParam = urlParams.get('approve');

    // ถ้ามีค่าเป็น 'true', แสดง Alert
    if (successParam === 'true') {
        alert("บันทึกข้อมูลสำเร็จ");
    }else if (editParam === 'true'){
        alert("แก้ไขข้อมูลสำเร็จ")
    }else if (approveParam === 'true'){
        alert("ยืนยันคำร้องขอสำเร็จ")
    }else if (approveParam === 'false'){
        alert("ยกเลิกคำร้องขอสำเร็จ")
    }
</script>
<script>
    function checkSelection() {
        var selectElement = document.getElementById("select_type");
        var selectedValue = selectElement.value;

        if (selectedValue === "กำลังลงทะเบียน") {
            document.getElementById("tag_line").textContent = "หลักสูตรที่อยู่ในช่วงลงทะเบียน และการชำระเงิน"
            document.getElementById("register_select").style.display = "block";
            // document.getElementById("payment_select").style.display = "none";
            document.getElementById("study_select").style.display = "none";
            document.getElementById("finish_study").style.display = "none";
            document.getElementById("cancel_request_select").style.display = "none";
            document.getElementById("not_study_select").style.display = "none";
        }
            // else if (selectedValue === "กำลังชำระเงิน") {
            //     document.getElementById("tag_line").textContent = "หลักสูตรที่อยู่ในช่วงชำระเงิน"
            //     document.getElementById("register_select").style.display = "none";
            //     document.getElementById("payment_select").style.display = "block";
            //     document.getElementById("study_select").style.display = "none";
            //     document.getElementById("cancel_request_select").style.display = "none";
            //     document.getElementById("not_study_select").style.display = "none";
        // }
        else if (selectedValue === "กำลังสอน") {
            document.getElementById("tag_line").textContent = "หลักสูตรที่อยู่ในช่วงการสอน"
            document.getElementById("register_select").style.display = "none";
            // document.getElementById("payment_select").style.display = "none";
            document.getElementById("study_select").style.display = "block";
            document.getElementById("finish_study").style.display = "none";
            document.getElementById("cancel_request_select").style.display = "none";
            document.getElementById("not_study_select").style.display = "none";
        } else if (selectedValue === "หลักสูตรที่เสร็จสิ้นการเรียน") {
            document.getElementById("tag_line").textContent = "หลักสูตรที่อยู่ในช่วงการสอน"
            document.getElementById("register_select").style.display = "none";
            // document.getElementById("payment_select").style.display = "none";
            document.getElementById("study_select").style.display = "none";
            document.getElementById("finish_study").style.display = "block";
            document.getElementById("cancel_request_select").style.display = "none";
            document.getElementById("not_study_select").style.display = "none";
        }
        else if (selectedValue === "ยังไม่เปิดสอน") {
            document.getElementById("tag_line").textContent = "หลักสูตรที่ยังไม่มีการเปิดสอน"
            document.getElementById("register_select").style.display = "none";
            // document.getElementById("payment_select").style.display = "none";
            document.getElementById("study_select").style.display = "none";
            document.getElementById("finish_study").style.display = "none";
            document.getElementById("cancel_request_select").style.display = "none";
            document.getElementById("not_study_select").style.display = "block";
        }else if (selectedValue === "ถูกยกเลิก") {
            document.getElementById("tag_line").textContent = "หลักสูตรที่ถูกยกเลิก"
            document.getElementById("register_select").style.display = "none";
            // document.getElementById("payment_select").style.display = "none";
            document.getElementById("study_select").style.display = "none";
            document.getElementById("finish_study").style.display = "none";
            document.getElementById("cancel_request_select").style.display = "block";
            document.getElementById("not_study_select").style.display = "none";
        }
    }
    window.addEventListener('load',checkSelection);
</script>
<script>
    var allCourse = document.querySelector('input[name="listDisplay"][value="หลักสูตรทั้งหมด"]');
    allCourse.addEventListener("change", function() {
        if (allCourse.checked) {
            document.getElementById("all_register").style.display = "block";
            document.getElementById("no_max_register").style.display = "none";
            document.getElementById("register_and_payment").style.display = "none";
            document.getElementById("payment_list").style.display = "none";
            document.getElementById("max_register").style.display = "none";
            document.getElementById("app_list").style.display = "none";
        }
    });

    var regisCourse = document.querySelector('input[name="listDisplay"][value="หลักสูตรเปิดรับสมัคร"]');
    regisCourse.addEventListener("change", function() {
        if (regisCourse.checked) {
            document.getElementById("all_register").style.display = "none";
            document.getElementById("no_max_register").style.display = "block";
            document.getElementById("register_and_payment").style.display = "none";
            document.getElementById("payment_list").style.display = "none";
            document.getElementById("max_register").style.display = "none";
            document.getElementById("app_list").style.display = "none";
        }
    });

    var regisPayCourse = document.querySelector('input[name="listDisplay"][value="หลักสูตรเปิดรับสมัคร/ชำระเงิน"]');
    regisPayCourse.addEventListener("change", function() {
        if (regisPayCourse.checked) {
            document.getElementById("all_register").style.display = "none";
            document.getElementById("no_max_register").style.display = "none";
            document.getElementById("register_and_payment").style.display = "block";
            document.getElementById("payment_list").style.display = "none";
            document.getElementById("max_register").style.display = "none";
            document.getElementById("app_list").style.display = "none";
        }
    });
    var paymentCourse = document.querySelector('input[name="listDisplay"][value="หลักสูตรที่ชำระเงินเท่านั้น"]');
    paymentCourse.addEventListener("change", function() {
        if (paymentCourse.checked) {
            document.getElementById("all_register").style.display = "none";
            document.getElementById("no_max_register").style.display = "none";
            document.getElementById("register_and_payment").style.display = "none";
            document.getElementById("payment_list").style.display = "block";
            document.getElementById("max_register").style.display = "none";
            document.getElementById("app_list").style.display = "none";
        }
    });

    var maxRegisCourse = document.querySelector('input[name="listDisplay"][value="หลักสูตรที่สมัครครบแล้ว"]');
    maxRegisCourse.addEventListener("change", function() {
        if (maxRegisCourse.checked) {
            document.getElementById("all_register").style.display = "none";
            document.getElementById("no_max_register").style.display = "none";
            document.getElementById("register_and_payment").style.display = "none";
            document.getElementById("payment_list").style.display = "none";
            document.getElementById("max_register").style.display = "block";
            document.getElementById("app_list").style.display = "none";
        }
    });

    var appCourse = document.querySelector('input[name="listDisplay"][value="รอประกาศผล"]');
    appCourse.addEventListener("change", function() {
        if (appCourse.checked) {
            document.getElementById("all_register").style.display = "none";
            document.getElementById("no_max_register").style.display = "none";
            document.getElementById("register_and_payment").style.display = "none";
            document.getElementById("payment_list").style.display = "none";
            document.getElementById("max_register").style.display = "none";
            document.getElementById("app_list").style.display = "block";
        }
    });
</script>
<script>
    window.addEventListener('DOMContentLoaded', (event) => {
        // var button = document.getElementById('FClick');
        // button.click()
        if (`${fromPage}` === ''){
            document.getElementById('chk1').click();
        } else if (`${fromPage}` === 'regisPage'){
            document.getElementById('chk2').click();
        }else if (`${fromPage}` === 'regispayPage'){
            document.getElementById('chk3').click()
        }else if (`${fromPage}` === 'payPage'){
            document.getElementById('chk4').click()
        }else if (`${fromPage}` === 'appPage'){
            document.getElementById('chk6').click()
        } else {
            var selectElement = document.getElementById("select_type"); // เลือก element ของ <select>
            var selectedOption = `${fromPage}`; // ตัวเลือกที่คุณต้องการเลือก
            for (var i = 0; i < selectElement.options.length; i++) {
                if (selectElement.options[i].value === selectedOption) {
                    selectElement.selectedIndex = i; // เลือกตัวเลือกที่ตรงกับ "ถูกยกเลิก"
                    break;
                }
            }
        }

        console.log("fromPage : " + `${fromPage}`)
    });
</script>
<%--<script>--%>
<%--    var allPay = document.querySelector('input[name="listPay"][value="การชำระเงิน"]');--%>
<%--    allPay.addEventListener("change", function() {--%>
<%--        if (allPay.checked) {--%>
<%--            document.getElementById("payment_list").style.display = "block";--%>
<%--            document.getElementById("app_list").style.display = "none";--%>
<%--        }--%>
<%--    });--%>

<%--    var listApp = document.querySelector('input[name="listPay"][value="รอประกาศผล"]');--%>
<%--    listApp.addEventListener("change", function() {--%>
<%--        if (listApp.checked) {--%>
<%--            document.getElementById("payment_list").style.display = "none";--%>
<%--            document.getElementById("app_list").style.display = "block";--%>
<%--        }--%>
<%--    });--%>
<%--</script>--%>
</html>
