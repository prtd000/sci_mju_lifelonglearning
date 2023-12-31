<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="lifelong.model.*" %>
<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 8/9/2023
  Time: 4:24 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>รายชื่อผู้สมัคร</title>
    <%--    <link href="${pageContext.request.contextPath}/assets/css/list_open_course_style.css" rel="stylesheet">--%>
    <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/list_all_course.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/admin/list_approve_member.css" rel="stylesheet">
    <style>
        body{
            font-family: 'Prompt', sans-serif;
        }
        h1{
            font-family: 'Prompt', sans-serif;
            font-weight: 700 !important;
        }
        table{
            font-size: 12px;
        }
    </style>
    <jsp:include page="/WEB-INF/view/layouts/detail-all-style.jsp"/>
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
        <br>
        <br>
        <c:set var="colorBar" value="#fbc44f"/>
        <div align="center" style="width: 100%; font-size: 12px">
            <div align="left" style="width: 85%">
                    <%--                <h2>${request_name.course.name}</h2>--%>
                <div align="center" class="main_container">

                    <div class="course_div" style="align-self: flex-start; background-color: #dddddd">
                        <div>
                            <div style="padding: 20px 20px 0px 20px" align="left">
                                <b><label style="font-size: 20px">${request_name.course.name}</label></b>
                                <label>${request_name.course.major.name}</label>
                                <hr>
                            </div>
                            <div style="padding: 0px 20px 20px 20px" align="left">
                                <b><label>วันเปิดรับสมัคร</label></b>
                                <div class="mb-3">
                                    <div class="flex-container">
                                        <fmt:formatDate value="${request_name.startRegister}" pattern="dd/MM/yyyy" var="startRegister" />
                                        <fmt:formatDate value="${request_name.endRegister}" pattern="dd/MM/yyyy" var="endRegister" />
                                        <label>${startRegister} - ${endRegister}</label>
                                    </div>
                                </div>
                                <b><label>ค่าธรรมเนียม</label></b>
                                <div class="mb-3">
                                    <c:choose>
                                        <c:when test="${request_name.course.fee == 0}">
                                            <div class="flex-container">
                                                <label>ไม่มีค่าธรรมเนียม</label>
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                            <fmt:parseNumber var="courseFee" type="number" value="${request_name.course.fee}"/>
                                            <div class="flex-container">
                                                <label><fmt:formatNumber value="${courseFee}"/> บาท</label>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <c:choose>
                                    <c:when test="${request_name.course.fee != 0}">
                                        <b><label>ระยะเวลาการชำระเงิน</label></b>
                                        <div class="mb-3">
                                            <div class="flex-container">
                                                <fmt:formatDate value="${request_name.startPayment}" pattern="dd/MM/yyyy" var="startPayment" />
                                                <fmt:formatDate value="${request_name.endPayment}" pattern="dd/MM/yyyy" var="endPayment" />
                                                <label>${startPayment} - ${endPayment}</label><br>
                                            </div>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <b><label>ระยะเวลาการชำระเงิน</label></b>
                                        <div class="mb-3">
                                            <div class="flex-container">
                                                <label>ไม่มีการชำระเงิน</label>
                                            </div>
                                        </div>
                                    </c:otherwise>
                                </c:choose>

                                <b><label>วันประกาศผลการสมัคร</label></b>
                                <div class="mb-3">
                                    <div class="flex-container">
                                        <fmt:formatDate value="${request_name.applicationResult}" pattern="dd/MM/yyyy" var="applicationResult" />
                                        <label>${applicationResult}</label>
                                    </div>
                                </div>
                                <b><label>ระยะเวลาการเรียน</label></b>
                                <div class="mb-3">
                                    <div class="flex-container">
                                        <fmt:formatDate value="${request_name.startStudyDate}" pattern="dd/MM/yyyy" var="startStudyDate" />
                                        <fmt:formatDate value="${request_name.endStudyDate}" pattern="dd/MM/yyyy" var="endStudyDate" />
                                        <label>${startStudyDate} - ${endStudyDate}</label><br>
                                        <c:set var="delimiter" value="$%"/>
                                        <c:set var="subText"
                                               value="${fn:split(request_name.studyTime, delimiter)}"/>
                                        <c:forEach var="ogText" items="${subText}">
                                            <c:set var="parts" value="${fn:split(ogText, '/')}"/>
                                            <label>${parts[0]} ${parts[1]} - ${parts[2]} น.</label><br>
                                        </c:forEach>

                                    </div>
                                </div>
                                    <%--                            <div class="mb-3">--%>
                                    <%--                                <div class="flex-container">--%>
                                    <%--                                    <label>จำนวนรับสมัคร ${request_name.numberOfAllRegistrations} / ${request_name.quantity} คน</label>--%>
                                    <%--                                </div>--%>
                                    <%--                            </div>--%>
                                <b><label>รูปแบบการสอน</label></b>
                                <div class="mb-3">
                                    <div class="flex-container">
                                        <label>${request_name.type_teach}</label>
                                    </div>
                                </div>
                                <b><label>รูปแบบการสอน</label></b>
                                <div class="mb-3">
                                    <div class="flex-container">
                                        <label>${request_name.type_learn}</label>
                                    </div>
                                </div>
                                <hr>
                                <b><label>อาจารย์ผู้สอน</label></b>
                                <div class="mb-3">
                                    <div class="flex-container">
                                        <label>${request_name.lecturer.position} ${request_name.lecturer.firstName} ${request_name.lecturer.lastName}</label>
                                    </div>
                                </div>
                                <hr>
                            </div>
                        </div>

                        <div align="center">
                            <form action="${pageContext.request.contextPath}/course/admin/list_all_course" method="get">
                                <c:if test="${request_name.course.status == 'ลงทะเบียน'}">
                                    <input type="hidden" name="fromPage" value="regisPage">
                                    <button class="btn btn-outline-dark" style="width: 90%;border-radius: 10px;">ย้อนกลับ</button>
                                </c:if>
                                <c:if test="${request_name.course.status == 'ลงทะเบียน/ชำระเงิน'}">
                                    <input type="hidden" name="fromPage" value="regispayPage">
                                    <button class="btn btn-outline-dark" style="width: 90%;border-radius: 10px;">ย้อนกลับ</button>
                                </c:if>
                                <c:if test="${request_name.course.status == 'ชำระเงิน'}">
                                    <input type="hidden" name="fromPage" value="payPage">
                                    <button class="btn btn-outline-dark" style="width: 90%;border-radius: 10px;">ย้อนกลับ</button>
                                </c:if>
                                <c:if test="${request_name.course.status == 'รอประกาศผล'}">
                                    <input type="hidden" name="fromPage" value="appPage">
                                    <button class="btn btn-outline-dark" style="width: 90%;border-radius: 10px;">ย้อนกลับ</button>
                                </c:if>
                                <c:if test="${request_name.course.status == 'เปิดสอน'}">
                                    <input type="hidden" name="fromPage" value="กำลังสอน">
                                    <button class="btn btn-outline-dark" style="width: 90%;border-radius: 10px;">ย้อนกลับ</button>
                                </c:if>
                                <c:if test="${request_name.requestStatus == 'เสร็จสิ้น'}">
                                    <input type="hidden" name="fromPage" value="หลักสูตรที่เสร็จสิ้นการเรียน">
                                    <button class="btn btn-outline-dark" style="width: 90%;border-radius: 10px;">ย้อนกลับ</button>
                                </c:if>
                                <c:if test="${request_name.requestStatus == 'ถูกยกเลิก'}">
                                    <input type="hidden" name="fromPage" value="ถูกยกเลิก">
                                    <button class="btn btn-outline-dark" style="width: 90%;border-radius: 10px;">ย้อนกลับ</button>
                                </c:if>
                            </form>
                        </div>
                    </div>


                    <c:if test="${request_name.course.status == 'ลงทะเบียน'}">
                        <div id="div_register" style="width: 100%; align-self: flex-start;" align="left">
                            <div style="display: flex; width: 100%" >
                                <div align="left" style="width: 50%"><h4>รายชื่อผู้สมัคร (อยู่ในช่วงลงทะเบียน)</h4></div>
                                <div align="right" style="width: 50%;">
                                    <div style="display:flex; width: 180px">
                                        <div style="margin-right: 10px"><i class="fa fa-users fa-2x"></i></div>
                                        <div><h4>${request_name.numberOfAllRegistrations} / ${request_name.quantity}</h4></div>
                                    </div>
                                </div>
                            </div>
                            <hr>
                            <table class="table table-hover" style="width: 100%; align-self: flex-start;">
                                <thead style="background-color: ${colorBar};">
                                    <tr style="color: black">
                                        <td style="width: 5%"></td>
                                        <td style="width: 20%"><b style="font-size: 14px">รหัสบัตรประชาชน</b></td>
                                        <td style="width: 20%" align="center"><b style="font-size: 14px">ชื่อ - นามสกุล</b></td>
                                        <td style="width: 15%" align="center"><b style="font-size: 14px">วันที่สมัคร</b></td>
                                        <td style="width: 20%" align="center"><b style="font-size: 14px">เบอร์โทรศัพท์</b></td>
                                        <td style="width: 20%" align="center"><b style="font-size: 14px">สถานะการสมัคร</b></td>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:choose>
                                        <c:when test="${all_register_detail.size() == 0}">
                                            <tr>
                                                <td colspan="6" align="center">ยังไม่มีผู้ลงทะเบียน</td>
                                            </tr>
                                        </c:when>
                                        <c:otherwise>
                                            <c:set var="count" value="1"/>
                                            <c:forEach var="registers" items="${all_register_detail}">
                                                <fmt:formatDate value="${registers.register_date}" pattern="dd/MM/yyyy" var="register_date" />
                                                <tr style="color: black">
                                                    <td><p>${count}</p></td>
                                                    <td><p>${registers.member.idcard}</p></td>
                                                    <td><p>${registers.member.firstName} ${registers.member.lastName}</p></td>
                                                    <td align="center">
                                                        <p>${register_date}</p>
                                                    </td>
                                                    <td align="center">${registers.member.tel}</td>
                                                    <c:choose>
                                                        <c:when test="${registers.requestOpenCourse.course.fee == 0}">
                                                            <td align="center" style="font-size: 14px;">
                                                                <i class='fas fa-clock'></i>
                                                                <b>รอเรียน</b>
                                                            </td>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <td align="center" style="color: orange;font-size: 14px;">
                                                                <i class='fa fa-minus-circle'></i>
                                                                <b>รอชำระเงิน</b>
                                                            </td>
                                                        </c:otherwise>
                                                    </c:choose>

                                                </tr>
                                                <c:set var="count" value="${count+1}"/>
                                            </c:forEach>
                                        </c:otherwise>
                                    </c:choose>
                                </tbody>
                            </table>
                        </div>
                    </c:if>

                    <c:if test="${request_name.course.status == 'ลงทะเบียน/ชำระเงิน'}">
                        <div id="div_register" style="width: 100%; align-self: flex-start;" align="left">
                            <div style="display: flex; width: 100%" >
                                <div align="left" style="width: 50%"><h4>รายชื่อผู้สมัคร (อยู่ในช่วงลงทะเบียน/ชำระเงิน)</h4></div>
                                <div align="right" style="width: 50%;">
                                    <div style="display:flex; width: 180px">
                                        <div style="margin-right: 10px"><i class="fa fa-users fa-2x"></i></div>
                                        <div><h4>${request_name.registerList.size()} / ${request_name.quantity}</h4></div>
                                    </div>
                                </div>
                            </div>
                            <hr>
                            <table class="table table-hover" style="width: 100%; align-self: flex-start;">
                                <thead style="background-color: ${colorBar};">
                                    <tr style="color: black">
                                        <td style="width: 5%"></td>
                                        <td style="width: 20%"><b style="font-size: 14px">รหัสบัตรประชาชน</b></td>
                                        <td style="width: 20%" align="center"><b style="font-size: 14px">ชื่อ - นามสกุล</b></td>
                                        <td style="width: 10%" align="center"><b style="font-size: 14px">วันที่สมัคร</b></td>
                                        <td style="width: 15%" align="center"><b style="font-size: 14px">วันที่ชำระเงิน</b></td>
                                        <td style="width: 15%" align="center"><b style="font-size: 14px">เบอร์โทรศัพท์</b></td>
                                        <td style="width: 20%" align="center"><b style="font-size: 14px">สถานะการสมัคร</b></td>
                                    </tr>
                                </thead>
                                <tbody>
                                <c:choose>
                                    <c:when test="${all_register_detail.size() == 0}">
                                        <tr>
                                            <td colspan="5" align="center">ยังไม่มีผู้ลงทะเบียน</td>
                                        </tr>
                                    </c:when>
                                    <c:otherwise>
                                        <c:set var="count1" value="1"/>
                                        <c:forEach var="registers" items="${all_register_detail}">
                                            <fmt:formatDate value="${registers.register_date}" pattern="dd/MM/yyyy" var="register_date" />
                                            <tr style="color: black">
                                                <td><p>${count1}</p></td>
                                                <td><p>${registers.member.idcard}</p></td>
                                                <td><p>${registers.member.firstName} ${registers.member.lastName}</p></td>
                                                <td align="center">
                                                    <p>${register_date}</p>
                                                </td>
                                                <c:choose>
                                                    <c:when test="${registers.requestOpenCourse.course.fee == 0}">
                                                        <td>ไม่มีค่าธรรมเนียม(ฟรี)</td>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <c:set value="0" var="count"/>
                                                        <c:forEach var="receipts" items="${receipt}">
                                                            <fmt:formatDate value="${receipts.pay_date}" pattern="dd/MM/yyyy" var="pay_date" />
                                                            <c:if test="${registers.invoice.invoice_id == receipts.invoice.invoice_id}">
                                                                <td align="center">${pay_date} ${receipts.pay_time} น.</td>
                                                                <c:set var="count" value="${count +1}"/>
                                                            </c:if>
                                                        </c:forEach>
                                                        <c:if test="${count == 0}">
                                                            <td align="center">ยังไม่มีการชำระเงิน</td>
                                                        </c:if>
                                                    </c:otherwise>
                                                </c:choose>
                                                <td align="center">${registers.member.tel}</td>
                                                <c:choose>
                                                    <c:when test="${registers.requestOpenCourse.course.fee == 0}">
                                                        <td align="center" style="font-size: 14px;">
                                                            <i class='fas fa-clock'></i>
                                                            <b>รอเรียน</b>
                                                        </td>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <c:if test="${registers.invoice.approve_status == 'ผ่าน'}">
                                                            <td align="center" style="color: green; font-size: 15px">
                                                                <i class='fa fa-check-circle' style='color:#008f11'></i>
                                                                <b> ผ่าน</b>
                                                            </td>
                                                        </c:if>
                                                        <c:if test="${registers.invoice.approve_status == 'ไม่ผ่าน'}">
                                                            <td align="center" style="color: red;font-size: 14px">
                                                                <i class='fa fa-times-circle' style='color: red'></i>
                                                                <b>ไม่ผ่าน</b>
                                                            </td>
                                                        </c:if>
                                                        <c:if test="${registers.invoice.approve_status == 'รอดำเนินการ'}">
                                                            <c:if test="${registers.invoice.pay_status == true}">
                                                                <td align="center">
                                                                    <a href="${pageContext.request.contextPath}/course/${request_name.request_id}/view_payment_detail/${registers.invoice.invoice_id}">
                                                                        <button class="button-48" role="button" style="font-size: 14px">
                                                                            <span class="text">
                                                                                <i class='fas fa-money-check'></i>
                                                                                <b>ดูข้อมูลการชำระเงิน</b>
                                                                            </span>
                                                                        </button>
                                                                    </a>
                                                                </td>
                                                            </c:if>
                                                            <c:if test="${registers.invoice.pay_status == false}">
                                                                <td align="center" style="color: orange;font-size: 14px;">
                                                                    <i class='fa fa-minus-circle'></i>
                                                                    <b>ยังไม่ได้ชำระเงิน</b>
                                                                </td>
                                                            </c:if>
                                                        </c:if>
                                                    </c:otherwise>
                                                </c:choose>
                                            </tr>
                                            <c:set var="count1" value="${count1+1}"/>
                                        </c:forEach>
                                    </c:otherwise>
                                </c:choose>
                                </tbody>
                            </table>
                        </div>
                    </c:if>

<%--                    ถึงตรงนี้--%>
                    <c:if test="${request_name.course.status == 'ชำระเงิน'}">
                        <div id="div_payment" style="width: 100%; align-self: flex-start;" align="left">
                            <div style="display: flex; width: 100%" >
                                <div align="left" style="width: 50%"><h4>รายชื่อผู้สมัคร (อยู่ในช่วงชำระเงิน)</h4></div>
                                <div align="right" style="width: 50%;">
                                    <div style="display:flex; width: 180px">
                                        <div style="margin-right: 10px"><i class="fa fa-users fa-2x"></i></div>
                                        <div><h4>${request_name.numberOfAllRegistrationsPayStatus} / ${request_name.registerList.size()}</h4></div>
                                    </div>
                                </div>
                            </div>
                            <hr>
                            <div style="width: 100%" align="center">
                                <input type="radio" name="listDisplay" value="รายการทั้งหมด" checked>
                                <label>รายการทั้งหมด</label>
                                <input type="radio" name="listDisplay" value="ผ่านการชำระเงิน">
                                <label>ผ่านการชำระเงิน</label>
                                <input type="radio" name="listDisplay" value="ตรวจสอบการชำระเงิน">
                                <label>ตรวจสอบการชำระเงิน</label>
                                <input type="radio" name="listDisplay" value="ยังไม่ได้ชำระเงิน">
                                <label>ยังไม่ได้ชำระเงิน</label>
                                <input type="radio" name="listDisplay" value="ไม่ผ่านการชำระเงิน">
                                <label>ไม่ผ่านการชำระเงิน</label>
                            </div>
                            <hr>
                            <div id="all_payment" style="display: block">
                                <table class="table table-hover" style="width: 100%; align-self: flex-start;">
                                    <thead style="background-color: ${colorBar};">
                                        <tr style="color: black">
                                            <td style="width: 5%"><b style="font-size: 14px"></b></td>
                                            <td style="width: 20%"><b style="font-size: 14px">รหัสบัตรประชาชน</b></td>
                                            <td style="width: 20%" align="center"><b style="font-size: 14px">ชื่อ - นามสกุล</b></td>
                                            <td style="width: 20%" align="center"><b style="font-size: 14px">วันเวลาในการชำระเงิน</b></td>
                                            <td style="width: 15%" align="center"><b style="font-size: 14px">เบอร์โทรศัพท์</b></td>
                                            <td style="width: 20%" align="center"><b style="font-size: 14px">สถานะการสมัคร</b></td>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    <c:choose>
                                        <c:when test="${all_register_detail.size() == 0}">
                                            <tr>
                                                <td colspan="6" align="center">ไม่มีข้อมูล</td>
                                            </tr>
                                        </c:when>
                                        <c:otherwise>
                                            <c:set var="count1" value="1"/>
                                            <c:forEach var="registers" items="${all_register_detail}">
                                                <%--                                                <c:if test="${registers.invoice.pay_status == true || registers.invoice.approve_status == 'ไม่ผ่าน'}">--%>
                                                <tr style="color: black">
                                                    <td><p>${count1}</p></td>
                                                    <td><p>${registers.member.idcard}</p></td>
                                                    <td><p>${registers.member.firstName} ${registers.member.lastName}</p></td>
                                                    <c:choose>
                                                        <c:when test="${registers.requestOpenCourse.course.fee == 0}">
                                                            <td align="center"><p>ไม่มีค่าธรรมเนียม(ฟรี)</p></td>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <c:set value="0" var="count"/>
                                                            <c:forEach var="receipts" items="${receipt}">
                                                                <fmt:formatDate value="${receipts.pay_date}" pattern="dd/MM/yyyy" var="pay_date" />
                                                                <c:if test="${registers.invoice.invoice_id == receipts.invoice.invoice_id}">
                                                                    <td align="center">${pay_date} ${receipts.pay_time} น.</td>
                                                                    <c:set var="count" value="${count +1}"/>
                                                                </c:if>
                                                            </c:forEach>
                                                            <c:if test="${count == 0}">
                                                                <td align="center">ยังไม่มีการชำระเงิน</td>
                                                            </c:if>
                                                        </c:otherwise>
                                                    </c:choose>
                                                    <td align="center">${registers.member.tel}</td>
                                                    <c:if test="${registers.invoice.approve_status == 'ผ่าน'}">
                                                        <td align="center" style="color: green; font-size: 15px">
                                                            <i class='fa fa-check-circle' style='color:#008f11'></i>
                                                            <b> ผ่าน</b>
                                                        </td>
                                                    </c:if>
                                                    <c:if test="${registers.invoice.approve_status == 'ไม่ผ่าน'}">
                                                        <td align="center" style="color: red;font-size: 14px">
                                                            <i class='fa fa-times-circle' style='color: red'></i>
                                                            <b>ไม่ผ่าน</b>
                                                        </td>
                                                    </c:if>
                                                    <c:if test="${registers.invoice.approve_status == 'รอดำเนินการ'}">
                                                        <c:if test="${registers.invoice.pay_status == true}">
                                                            <td align="center">
                                                                <a href="${pageContext.request.contextPath}/course/${request_name.request_id}/view_payment_detail/${registers.invoice.invoice_id}">
                                                                    <button class="button-48" role="button" style="font-size: 14px">
                                                                            <span class="text">
                                                                                <i class='fas fa-money-check'></i>
                                                                                <b>ดูข้อมูลการชำระเงิน</b>
                                                                            </span>
                                                                    </button>
                                                                </a>
                                                            </td>
                                                        </c:if>
                                                        <c:if test="${registers.invoice.pay_status == false}">
                                                            <td align="center" style="color: orange;font-size: 14px;">
                                                                <i class='fa fa-minus-circle'></i>
                                                                <b>ยังไม่ได้ชำระเงิน</b>
                                                            </td>
                                                        </c:if>
                                                    </c:if>
                                                </tr>
                                                <%--                                                </c:if>--%>
                                                <c:set var="count1" value="${count1+1}"/>
                                            </c:forEach>
                                        </c:otherwise>
                                    </c:choose>
                                    </tbody>
                                </table>
                            </div>

                            <div id="pass_payment" style="display: none">
                                <table class="table table-hover" style="width: 100%; align-self: flex-start;">
                                    <thead style="background-color: ${colorBar};">
                                        <tr style="color: black">
                                            <td style="width: 5%"><b style="font-size: 14px"></b></td>
                                            <td style="width: 20%"><b style="font-size: 14px">รหัสบัตรประชาชน</b></td>
                                            <td style="width: 20%" align="center"><b style="font-size: 14px">ชื่อ - นามสกุล</b></td>
                                            <td style="width: 20%" align="center"><b style="font-size: 14px">วันเวลาในการชำระเงิน</b></td>
                                            <td style="width: 15%" align="center"><b style="font-size: 14px">เบอร์โทรศัพท์</b></td>
                                            <td style="width: 20%" align="center"><b style="font-size: 14px">สถานะการสมัคร</b></td>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    <c:choose>
                                        <c:when test="${all_register_detail.size() == 0}">
                                            <tr>
                                                <td colspan="6" align="center">ไม่มีข้อมูล</td>
                                            </tr>
                                        </c:when>
                                        <c:otherwise>
                                            <c:set var="count" value="0"/>
                                            <c:set var="count1" value="1"/>
                                            <c:forEach var="registers" items="${all_register_detail}">
                                                <c:if test="${registers.invoice.approve_status == 'ผ่าน'}">
                                                    <tr style="color: black">
                                                        <td><p>${count1}</p></td>
                                                        <td><p>${registers.member.idcard}</p></td>
                                                        <td><p>${registers.member.firstName} ${registers.member.lastName}</p></td>
                                                        <c:choose>
                                                            <c:when test="${registers.requestOpenCourse.course.fee == 0}">
                                                                <td align="center"><p>ไม่มีค่าธรรมเนียม(ฟรี)</p></td>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <c:set value="0" var="count"/>
                                                                <c:forEach var="receipts" items="${receipt}">
                                                                    <fmt:formatDate value="${receipts.pay_date}" pattern="dd/MM/yyyy" var="pay_date" />
                                                                    <c:if test="${registers.invoice.invoice_id == receipts.invoice.invoice_id}">
                                                                        <td align="center">${pay_date} ${receipts.pay_time} น.</td>
                                                                        <c:set var="count" value="${count +1}"/>
                                                                    </c:if>
                                                                </c:forEach>
                                                                <c:if test="${count == 0}">
                                                                    <td align="center">ยังไม่มีการชำระเงิน</td>
                                                                </c:if>
                                                            </c:otherwise>
                                                        </c:choose>
                                                        <td align="center">${registers.member.tel}</td>
                                                        <c:if test="${registers.invoice.approve_status == 'ผ่าน'}">
                                                            <td align="center" style="color: green; font-size: 15px">
                                                                <i class='fa fa-check-circle' style='color:#008f11'></i>
                                                                <b> ผ่าน</b>
                                                            </td>
                                                        </c:if>
                                                        <c:if test="${registers.invoice.approve_status == 'ไม่ผ่าน'}">
                                                            <td align="center" style="color: red;font-size: 14px">
                                                                <i class='fa fa-times-circle' style='color: red'></i>
                                                                <b>ไม่ผ่าน</b>
                                                            </td>
                                                        </c:if>
                                                        <c:if test="${registers.invoice.approve_status == 'รอดำเนินการ'}">
                                                            <c:if test="${registers.invoice.pay_status == true}">
                                                                <td align="center">
                                                                    <a href="${pageContext.request.contextPath}/course/${request_name.request_id}/view_payment_detail/${registers.invoice.invoice_id}">
                                                                        <button class="button-48" role="button" style="font-size: 14px">
                                                                            <span class="text">
                                                                                <i class='fas fa-money-check'></i>
                                                                                <b>ดูข้อมูลการชำระเงิน</b>
                                                                            </span>
                                                                        </button>
                                                                    </a>
                                                                </td>
                                                            </c:if>
                                                            <c:if test="${registers.invoice.pay_status == false}">
                                                                <td align="center" style="color: orange;font-size: 14px;">
                                                                    <i class='fa fa-minus-circle'></i>
                                                                    <b>ยังไม่ได้ชำระเงิน</b>
                                                                </td>
                                                            </c:if>
                                                        </c:if>
                                                        <c:set var="count" value="${count + 1}"/>
                                                        <c:set var="count1" value="${count1 + 1}"/>
                                                    </tr>
                                                </c:if>
                                            </c:forEach>
                                            <c:if test="${count == 0}">
                                                <tr>
                                                    <td colspan="6" align="center">ไม่มีข้อมูล</td>
                                                </tr>

                                            </c:if>
                                        </c:otherwise>
                                    </c:choose>
                                    </tbody>
                                </table>
                            </div>

                            <div id="check_payment" style="display: none">
                                <table class="table table-hover" style="width: 100%; align-self: flex-start;">
                                    <thead style="background-color: ${colorBar};">
                                        <tr style="color: black">
                                            <td style="width: 5%"><b style="font-size: 14px"></b></td>
                                            <td style="width: 20%"><b style="font-size: 14px">รหัสบัตรประชาชน</b></td>
                                            <td style="width: 20%" align="center"><b style="font-size: 14px">ชื่อ - นามสกุล</b></td>
                                            <td style="width: 20%" align="center"><b style="font-size: 14px">วันเวลาในการชำระเงิน</b></td>
                                            <td style="width: 15%" align="center"><b style="font-size: 14px">เบอร์โทรศัพท์</b></td>
                                            <td style="width: 20%" align="center"><b style="font-size: 14px">สถานะการสมัคร</b></td>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    <c:choose>
                                        <c:when test="${all_register_detail.size() == 0}">
                                            <tr>
                                                <td colspan="6" align="center">ไม่มีข้อมูล</td>
                                            </tr>
                                        </c:when>
                                        <c:otherwise>
                                            <c:set var="count" value="0"/>
                                            <c:set var="count1" value="1"/>
                                            <c:forEach var="registers" items="${all_register_detail}">
                                                <c:if test="${registers.invoice.approve_status == 'รอดำเนินการ' && registers.invoice.pay_status == true}">
                                                    <tr style="color: black">
                                                        <td><p>${count1}</p></td>
                                                        <td><p>${registers.member.idcard}</p></td>
                                                        <td><p>${registers.member.firstName} ${registers.member.lastName}</p></td>
                                                        <c:choose>
                                                            <c:when test="${registers.requestOpenCourse.course.fee == 0}">
                                                                <td align="center"><p>ไม่มีค่าธรรมเนียม(ฟรี)</p></td>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <c:set value="0" var="count"/>
                                                                <c:forEach var="receipts" items="${receipt}">
                                                                    <fmt:formatDate value="${receipts.pay_date}" pattern="dd/MM/yyyy" var="pay_date" />
                                                                    <c:if test="${registers.invoice.invoice_id == receipts.invoice.invoice_id}">
                                                                        <td align="center">${pay_date} ${receipts.pay_time} น.</td>
                                                                        <c:set var="count" value="${count +1}"/>
                                                                    </c:if>
                                                                </c:forEach>
                                                                <c:if test="${count == 0}">
                                                                    <td align="center">ยังไม่มีการชำระเงิน</td>
                                                                </c:if>
                                                            </c:otherwise>
                                                        </c:choose>
                                                        <td align="center">${registers.member.tel}</td>
                                                        <c:if test="${registers.invoice.approve_status == 'ผ่าน'}">
                                                            <td align="center" style="color: green; font-size: 14px">
                                                                <i class='fa fa-check-circle' style='color:#008f11'></i>
                                                                <b> ผ่าน</b>
                                                            </td>
                                                        </c:if>
                                                        <c:if test="${registers.invoice.approve_status == 'ไม่ผ่าน'}">
                                                            <td align="center" style="color: red;font-size: 14px">
                                                                <i class='fa fa-times-circle' style='color: red'></i>
                                                                <b>ไม่ผ่าน</b>
                                                            </td>
                                                        </c:if>
                                                        <c:if test="${registers.invoice.approve_status == 'รอดำเนินการ'}">
                                                            <c:if test="${registers.invoice.pay_status == true}">
                                                                <td align="center">
                                                                    <a href="${pageContext.request.contextPath}/course/${request_name.request_id}/view_payment_detail/${registers.invoice.invoice_id}">
                                                                        <button class="button-48" role="button" style="font-size: 14px">
                                                                            <span class="text">
                                                                                <i class='fas fa-money-check'></i>
                                                                                <b>ดูข้อมูลการชำระเงิน</b>
                                                                            </span>
                                                                        </button>
                                                                    </a>
                                                                </td>
                                                            </c:if>
                                                            <c:if test="${registers.invoice.pay_status == false}">
                                                                <td align="center" style="color: orange;font-size: 14px;">
                                                                    <i class='fa fa-minus-circle'></i>
                                                                    <b>ยังไม่ได้ชำระเงิน</b>
                                                                </td>
                                                            </c:if>
                                                        </c:if>
                                                    </tr>
                                                    <c:set var="count" value="${count + 1}"/>
                                                    <c:set var="count1" value="${count1 + 1}"/>
                                                </c:if>
                                            </c:forEach>
                                            <c:if test="${count == 0}">
                                                <tr>
                                                    <td colspan="6" align="center">ไม่มีข้อมูล</td>
                                                </tr>

                                            </c:if>
                                        </c:otherwise>
                                    </c:choose>
                                    </tbody>
                                </table>
                            </div>

                            <div id="not_payment" style="display: none">
                                <table class="table table-hover" style="width: 100%; align-self: flex-start;">
                                    <thead style="background-color: ${colorBar};">
                                        <tr style="color: black">
                                            <td style="width: 5%"><b style="font-size: 14px"></b></td>
                                            <td style="width: 20%"><b style="font-size: 14px">รหัสบัตรประชาชน</b></td>
                                            <td style="width: 20%" align="center"><b style="font-size: 14px">ชื่อ - นามสกุล</b></td>
                                            <td style="width: 20%" align="center"><b style="font-size: 14px">วันที่สมัคร</b></td>
                                            <td style="width: 15%" align="center"><b style="font-size: 14px">เบอร์โทรศัพท์</b></td>
                                            <td style="width: 20%" align="center"><b style="font-size: 14px">สถานะการสมัคร</b></td>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    <c:choose>
                                        <c:when test="${all_register_detail.size() == 0}">
                                            <tr>
                                                <td colspan="6" align="center">ไม่มีข้อมูล</td>
                                            </tr>
                                        </c:when>
                                        <c:otherwise>
                                            <c:set var="count" value="0"/>
                                            <c:set var="count1" value="1"/>
                                            <c:forEach var="registers" items="${all_register_detail}">
                                                <c:if test="${registers.invoice.approve_status == 'รอดำเนินการ' && registers.invoice.pay_status == false}">
                                                    <tr style="color: black">
                                                        <td><p>${count1}</p></td>
                                                        <td><p>${registers.member.idcard}</p></td>
                                                        <td><p>${registers.member.firstName} ${registers.member.lastName}</p></td>
                                                        <td align="center">
                                                            <fmt:formatDate value="${registers.register_date}" pattern="dd/MM/yyyy" var="register_date" />
                                                            <p>${register_date}</p>
                                                        </td>
                                                        <td align="center">${registers.member.tel}</td>
                                                        <c:if test="${registers.invoice.approve_status == 'ผ่าน'}">
                                                            <td align="center" style="color: green; font-size: 14px">
                                                                <i class='fa fa-check-circle' style='color:#008f11'></i>
                                                                <b> ผ่าน</b>
                                                            </td>
                                                        </c:if>
                                                        <c:if test="${registers.invoice.approve_status == 'ไม่ผ่าน'}">
                                                            <td align="center" style="color: red;font-size: 14px">
                                                                <i class='fa fa-times-circle' style='color: red'></i>
                                                                <b>ไม่ผ่าน</b>
                                                            </td>
                                                        </c:if>
                                                        <c:if test="${registers.invoice.approve_status == 'รอดำเนินการ'}">
                                                            <c:if test="${registers.invoice.pay_status == true}">
                                                                <td align="center">
                                                                    <a href="${pageContext.request.contextPath}/course/${request_name.request_id}/view_payment_detail/${registers.invoice.invoice_id}">
                                                                        <button class="button-48" role="button" style="font-size: 14px">
                                                                            <span class="text">
                                                                                <i class='fas fa-money-check'></i>
                                                                                <b>ดูข้อมูลการชำระเงิน</b>
                                                                            </span>
                                                                        </button>
                                                                    </a>
                                                                </td>
                                                            </c:if>
                                                            <c:if test="${registers.invoice.pay_status == false}">
                                                                <td align="center" style="color: orange;font-size: 14px;">
                                                                    <i class='fa fa-minus-circle'></i>
                                                                    <b>ยังไม่ได้ชำระเงิน</b>
                                                                </td>
                                                            </c:if>
                                                        </c:if>
                                                    </tr>
                                                    <c:set var="count" value="${count + 1}"/>
                                                    <c:set var="count1" value="${count1 + 1}"/>
                                                </c:if>
                                            </c:forEach>
                                            <c:if test="${count == 0}">
                                                <tr>
                                                    <td colspan="6" align="center">ไม่มีข้อมูล</td>
                                                </tr>

                                            </c:if>
                                        </c:otherwise>
                                    </c:choose>
                                    </tbody>
                                </table>
                            </div>

                            <div id="false_payment" style="display: none">
                                <table class="table table-hover" style="width: 100%; align-self: flex-start;">
                                    <thead style="background-color: ${colorBar};">
                                        <tr style="color: black">
                                            <td style="width: 5%"><b style="font-size: 14px"></b></td>
                                            <td style="width: 20%"><b style="font-size: 14px">รหัสบัตรประชาชน</b></td>
                                            <td style="width: 20%" align="center"><b style="font-size: 14px">ชื่อ - นามสกุล</b></td>
                                            <td style="width: 20%" align="center"><b style="font-size: 14px">วันเวลาในการชำระเงิน</b></td>
                                            <td style="width: 15%" align="center"><b style="font-size: 14px">เบอร์โทรศัพท์</b></td>
                                            <td style="width: 20%" align="center"><b style="font-size: 14px">สถานะการสมัคร</b></td>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    <c:choose>
                                        <c:when test="${all_register_detail.size() == 0}">
                                            <tr>all_register_detail
                                                <td colspan="6" align="center">ไม่มีข้อมูล</td>
                                            </tr>
                                        </c:when>
                                        <c:otherwise>
                                            <c:set var="count" value="0"/>
                                            <c:set var="count1" value="1"/>
                                            <c:forEach var="registers" items="${all_register_detail}">
                                                <c:if test="${registers.invoice.approve_status == 'ไม่ผ่าน'}">
                                                    <tr style="color: black">
                                                        <td><p>${count1}</p></td>
                                                        <td><p>${registers.member.idcard}</p></td>
                                                        <td><p>${registers.member.firstName} ${registers.member.lastName}</p></td>
                                                        <c:choose>
                                                            <c:when test="${registers.requestOpenCourse.course.fee == 0}">
                                                                <td align="center"><p>ไม่มีค่าธรรมเนียม(ฟรี)</p></td>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <c:set value="0" var="count"/>
                                                                <c:forEach var="receipts" items="${receipt}">
                                                                    <fmt:formatDate value="${receipts.pay_date}" pattern="dd/MM/yyyy" var="pay_date" />
                                                                    <c:if test="${registers.invoice.invoice_id == receipts.invoice.invoice_id}">
                                                                        <td align="center">${pay_date} ${receipts.pay_time} น.</td>
                                                                        <c:set var="count" value="${count +1}"/>
                                                                    </c:if>
                                                                </c:forEach>
                                                                <c:if test="${count == 0}">
                                                                    <td align="center">ยังไม่มีการชำระเงิน</td>
                                                                </c:if>
                                                            </c:otherwise>
                                                        </c:choose>
                                                        <td align="center">${registers.member.tel}</td>
                                                        <c:if test="${registers.invoice.approve_status == 'ผ่าน'}">
                                                            <td align="center" style="color: green; font-size: 14px">
                                                                <i class='fa fa-check-circle' style='color:#008f11'></i>
                                                                <b> ผ่าน</b>
                                                            </td>
                                                        </c:if>
                                                        <c:if test="${registers.invoice.approve_status == 'ไม่ผ่าน'}">
                                                            <td align="center" style="color: red;font-size: 14px">
                                                                <i class='fa fa-times-circle' style='color: red'></i>
                                                                <b>ไม่ผ่าน</b>
                                                            </td>
                                                        </c:if>
                                                        <c:if test="${registers.invoice.approve_status == 'รอดำเนินการ'}">
                                                            <c:if test="${registers.invoice.pay_status == true}">
                                                                <td align="center">
                                                                    <a href="${pageContext.request.contextPath}/course/${request_name.request_id}/view_payment_detail/${registers.invoice.invoice_id}">
                                                                        <button class="button-48" role="button" style="font-size: 14px">
                                                                            <span class="text">
                                                                                <i class='fas fa-money-check'></i>
                                                                                <b>ดูข้อมูลการชำระเงิน</b>
                                                                            </span>
                                                                        </button>
                                                                    </a>
                                                                </td>
                                                            </c:if>
                                                            <c:if test="${registers.invoice.pay_status == false}">
                                                                <td align="center" style="color: orange;font-size: 14px;">
                                                                    <i class='fa fa-minus-circle'></i>
                                                                    <b>ยังไม่ได้ชำระเงิน</b>
                                                                </td>
                                                            </c:if>
                                                        </c:if>
                                                    </tr>
                                                    <c:set var="count" value="${count + 1}"/>
                                                    <c:set var="count1" value="${count1 + 1}"/>
                                                </c:if>
                                            </c:forEach>
                                            <c:if test="${count == 0}">
                                                <tr>
                                                    <td colspan="6" align="center">ไม่มีข้อมูล</td>
                                                </tr>

                                            </c:if>
                                        </c:otherwise>
                                    </c:choose>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </c:if>

                    <c:if test="${request_name.course.status == 'รอประกาศผล'}">
                        <div id="div_register" style="width: 100%; align-self: flex-start;" align="left">
                            <div style="display: flex; width: 100%" >
                                <div align="left" style="width: 50%"><h4>รายชื่อผู้สมัคร (รอประกาศผล)</h4></div>
                                <div align="right" style="width: 50%;">
                                    <div style="display:flex; width: 180px">
                                        <div style="margin-right: 10px"><i class="fa fa-users fa-2x"></i></div>
                                        <div><h4>${request_name.numberOfAllRegistrationsPayStatus} / ${request_name.registerList.size()}</h4></div>
                                    </div>
                                </div>
                            </div>
                            <hr>
                            <div style="width: 100%" align="center">
                                <input type="radio" name="listAppDisplay" value="รายการทั้งหมด" checked>
                                <label>รายการทั้งหมด</label>
                                <input type="radio" name="listAppDisplay" value="ผ่านการชำระเงิน">
                                <label>ผ่านการชำระเงิน</label>
                                <input type="radio" name="listAppDisplay" value="ตรวจสอบการชำระเงิน">
                                <label>ตรวจสอบการชำระเงิน</label>
                                <input type="radio" name="listAppDisplay" value="ยังไม่ได้ชำระเงิน">
                                <label>ยังไม่ได้ชำระเงิน</label>
                                <input type="radio" name="listAppDisplay" value="ไม่ผ่านการชำระเงิน">
                                <label>ไม่ผ่านการชำระเงิน</label>
                            </div>
                            <hr>
                            <div id="all_payment_app" style="display: block">
                                <table class="table table-hover" style="width: 100%; align-self: flex-start;">
                                    <thead style="background-color: ${colorBar};">
                                        <tr style="color: black">
                                            <td style="width: 5%"><b style="font-size: 14px"></b></td>
                                            <td style="width: 20%"><b style="font-size: 14px">รหัสบัตรประชาชน</b></td>
                                            <td style="width: 20%" align="center"><b style="font-size: 14px">ชื่อ - นามสกุล</b></td>
                                            <td style="width: 20%" align="center"><b style="font-size: 14px">วันเวลาในการชำระเงิน</b></td>
                                            <td style="width: 15%" align="center"><b style="font-size: 14px">เบอร์โทรศัพท์</b></td>
                                            <td style="width: 20%" align="center"><b style="font-size: 14px">สถานะการสมัคร</b></td>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    <c:choose>
                                        <c:when test="${all_register_detail.size() == 0}">
                                            <tr>
                                                <td colspan="6" align="center">ไม่มีข้อมูล</td>
                                            </tr>
                                        </c:when>
                                        <c:otherwise>
                                            <c:set var="count1" value="1"/>
                                            <c:forEach var="registers" items="${all_register_detail}">
                                                <%--                                                <c:if test="${registers.invoice.pay_status == true || registers.invoice.approve_status == 'ไม่ผ่าน'}">--%>
                                                <tr style="color: black">
                                                    <td><p>${count1}</p></td>
                                                    <td><p>${registers.member.idcard}</p></td>
                                                    <td><p>${registers.member.firstName} ${registers.member.lastName}</p></td>
                                                    <c:choose>
                                                        <c:when test="${registers.requestOpenCourse.course.fee == 0}">
                                                            <td align="center"><p>ไม่มีค่าธรรมเนียม(ฟรี)</p></td>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <c:set value="0" var="count"/>
                                                            <c:forEach var="receipts" items="${receipt}">
                                                                <fmt:formatDate value="${receipts.pay_date}" pattern="dd/MM/yyyy" var="pay_date" />
                                                                <c:if test="${registers.invoice.invoice_id == receipts.invoice.invoice_id}">
                                                                    <td align="center">${pay_date} ${receipts.pay_time} น.</td>
                                                                    <c:set var="count" value="${count +1}"/>
                                                                </c:if>
                                                            </c:forEach>
                                                            <c:if test="${count == 0}">
                                                                <td align="center">ยังไม่มีการชำระเงิน</td>
                                                            </c:if>
                                                        </c:otherwise>
                                                    </c:choose>
                                                    <td align="center">${registers.member.tel}</td>
                                                    <c:if test="${registers.invoice.approve_status == 'ผ่าน'}">
                                                        <td align="center" style="color: green; font-size: 14px">
                                                            <i class='fa fa-check-circle' style='color:#008f11'></i>
                                                            <b> ผ่าน</b>
                                                        </td>
                                                    </c:if>
                                                    <c:if test="${registers.invoice.approve_status == 'ไม่ผ่าน'}">
                                                        <td align="center" style="color: red;font-size: 14px">
                                                            <i class='fa fa-times-circle' style='color: red'></i>
                                                            <b>ไม่ผ่าน</b>
                                                        </td>
                                                    </c:if>
                                                    <c:if test="${registers.invoice.approve_status == 'รอดำเนินการ'}">
                                                        <c:if test="${registers.invoice.pay_status == true}">
                                                            <td align="center">
                                                                <a href="${pageContext.request.contextPath}/course/${request_name.request_id}/view_payment_detail/${registers.invoice.invoice_id}">
                                                                    <button class="button-48" role="button" style="font-size: 14px">
                                                                            <span class="text">
                                                                                <i class='fas fa-money-check'></i>
                                                                                <b>ดูข้อมูลการชำระเงิน</b>
                                                                            </span>
                                                                    </button>
                                                                </a>
                                                            </td>
                                                        </c:if>
                                                        <c:if test="${registers.invoice.pay_status == false}">
                                                            <td align="center" style="color: orange;font-size: 14px;">
                                                                <i class='fa fa-minus-circle'></i>
                                                                <b>ยังไม่ได้ชำระเงิน</b>
                                                            </td>
                                                        </c:if>
                                                    </c:if>
                                                </tr>
                                                <%--                                                </c:if>--%>
                                                <c:set var="count1" value="${count1 + 1}"/>
                                            </c:forEach>
                                        </c:otherwise>
                                    </c:choose>
                                    </tbody>
                                </table>
                            </div>

                            <div id="pass_payment_app" style="display: none">
                                <table class="table table-hover" style="width: 100%; align-self: flex-start;">
                                    <thead style="background-color: ${colorBar};">
                                        <tr style="color: black">
                                            <td style="width: 5%"><b style="font-size: 14px"></b></td>
                                            <td style="width: 20%"><b style="font-size: 14px">รหัสบัตรประชาชน</b></td>
                                            <td style="width: 20%" align="center"><b style="font-size: 14px">ชื่อ - นามสกุล</b></td>
                                            <td style="width: 20%" align="center"><b style="font-size: 14px">วันเวลาในการชำระเงิน</b></td>
                                            <td style="width: 15%" align="center"><b style="font-size: 14px">เบอร์โทรศัพท์</b></td>
                                            <td style="width: 20%" align="center"><b style="font-size: 14px">สถานะการสมัคร</b></td>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    <c:choose>
                                        <c:when test="${all_register_detail.size() == 0}">
                                            <tr>
                                                <td colspan="6" align="center">ไม่มีข้อมูล</td>
                                            </tr>
                                        </c:when>
                                        <c:otherwise>
                                            <c:set var="count" value="0"/>
                                            <c:set var="count1" value="1"/>
                                            <c:forEach var="registers" items="${all_register_detail}">
                                                <c:if test="${registers.invoice.approve_status == 'ผ่าน'}">
                                                    <tr style="color: black">
                                                        <td><p>${count1}</p></td>
                                                        <td><p>${registers.member.idcard}</p></td>
                                                        <td><p>${registers.member.firstName} ${registers.member.lastName}</p></td>
                                                        <c:choose>
                                                            <c:when test="${registers.requestOpenCourse.course.fee == 0}">
                                                                <td align="center"><p>ไม่มีค่าธรรมเนียม(ฟรี)</p></td>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <c:set value="0" var="count"/>
                                                                <c:forEach var="receipts" items="${receipt}">
                                                                    <fmt:formatDate value="${receipts.pay_date}" pattern="dd/MM/yyyy" var="pay_date" />
                                                                    <c:if test="${registers.invoice.invoice_id == receipts.invoice.invoice_id}">
                                                                        <td align="center">${pay_date} ${receipts.pay_time} น.</td>
                                                                        <c:set var="count" value="${count +1}"/>
                                                                    </c:if>
                                                                </c:forEach>
                                                                <c:if test="${count == 0}">
                                                                    <td align="center">ยังไม่มีการชำระเงิน</td>
                                                                </c:if>
                                                            </c:otherwise>
                                                        </c:choose>
                                                        <td align="center">${registers.member.tel}</td>
                                                        <c:if test="${registers.invoice.approve_status == 'ผ่าน'}">
                                                            <td align="center" style="color: green; font-size: 14px">
                                                                <i class='fa fa-check-circle' style='color:#008f11'></i>
                                                                <b> ผ่าน</b>
                                                            </td>
                                                        </c:if>
                                                        <c:if test="${registers.invoice.approve_status == 'ไม่ผ่าน'}">
                                                            <td align="center" style="color: red;font-size: 14px">
                                                                <i class='fa fa-times-circle' style='color: red'></i>
                                                                <b>ไม่ผ่าน</b>
                                                            </td>
                                                        </c:if>
                                                        <c:if test="${registers.invoice.approve_status == 'รอดำเนินการ'}">
                                                            <c:if test="${registers.invoice.pay_status == true}">
                                                                <td align="center">
                                                                    <a href="${pageContext.request.contextPath}/course/${request_name.request_id}/view_payment_detail/${registers.invoice.invoice_id}">
                                                                        <button class="button-48" role="button" style="font-size: 14px">
                                                                            <span class="text">
                                                                                <i class='fas fa-money-check'></i>
                                                                                <b>ดูข้อมูลการชำระเงิน</b>
                                                                            </span>
                                                                        </button>
                                                                    </a>
                                                                </td>
                                                            </c:if>
                                                            <c:if test="${registers.invoice.pay_status == false}">
                                                                <td align="center" style="color: orange;font-size: 14px;">
                                                                    <i class='fa fa-minus-circle'></i>
                                                                    <b>ยังไม่ได้ชำระเงิน</b>
                                                                </td>
                                                            </c:if>
                                                        </c:if>
                                                        <c:set var="count" value="${count + 1}"/>
                                                        <c:set var="count1" value="${count1 + 1}"/>
                                                    </tr>
                                                </c:if>
                                            </c:forEach>
                                            <c:if test="${count == 0}">
                                                <tr>
                                                    <td colspan="6" align="center">ไม่มีข้อมูล</td>
                                                </tr>

                                            </c:if>
                                        </c:otherwise>
                                    </c:choose>
                                    </tbody>
                                </table>
                            </div>

                            <div id="check_payment_app" style="display: none">
                                <table class="table table-hover" style="width: 100%; align-self: flex-start;">
                                    <thead style="background-color: ${colorBar};">
                                        <tr style="color: black">
                                            <td style="width: 5%"><b style="font-size: 14px"></b></td>
                                            <td style="width: 20%"><b style="font-size: 14px">รหัสบัตรประชาชน</b></td>
                                            <td style="width: 20%" align="center"><b style="font-size: 14px">ชื่อ - นามสกุล</b></td>
                                            <td style="width: 20%" align="center"><b style="font-size: 14px">วันเวลาในการชำระเงิน</b></td>
                                            <td style="width: 15%" align="center"><b style="font-size: 14px">เบอร์โทรศัพท์</b></td>
                                            <td style="width: 20%" align="center"><b style="font-size: 14px">สถานะการสมัคร</b></td>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    <c:choose>
                                        <c:when test="${all_register_detail.size() == 0}">
                                            <tr>
                                                <td colspan="6" align="center">ไม่มีข้อมูล</td>
                                            </tr>
                                        </c:when>
                                        <c:otherwise>
                                            <c:set var="count" value="0"/>
                                            <c:set var="count1" value="1"/>
                                            <c:forEach var="registers" items="${all_register_detail}">
                                                <c:if test="${registers.invoice.approve_status == 'รอดำเนินการ' && registers.invoice.pay_status == true}">
                                                    <tr style="color: black">
                                                        <td><p>${count1}</p></td>
                                                        <td><p>${registers.member.idcard}</p></td>
                                                        <td><p>${registers.member.firstName} ${registers.member.lastName}</p></td>
                                                        <c:choose>
                                                            <c:when test="${registers.requestOpenCourse.course.fee == 0}">
                                                                <td align="center"><p>ไม่มีค่าธรรมเนียม(ฟรี)</p></td>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <c:set value="0" var="count"/>
                                                                <c:forEach var="receipts" items="${receipt}">
                                                                    <fmt:formatDate value="${receipts.pay_date}" pattern="dd/MM/yyyy" var="pay_date" />
                                                                    <c:if test="${registers.invoice.invoice_id == receipts.invoice.invoice_id}">
                                                                        <td align="center">${pay_date} ${receipts.pay_time} น.</td>
                                                                        <c:set var="count" value="${count +1}"/>
                                                                    </c:if>
                                                                </c:forEach>
                                                                <c:if test="${count == 0}">
                                                                    <td align="center">ยังไม่มีการชำระเงิน</td>
                                                                </c:if>
                                                            </c:otherwise>
                                                        </c:choose>
                                                        <td align="center">${registers.member.tel}</td>
                                                        <c:if test="${registers.invoice.approve_status == 'ผ่าน'}">
                                                            <td align="center" style="color: green; font-size: 14px">
                                                                <i class='fa fa-check-circle' style='color:#008f11'></i>
                                                                <b> ผ่าน</b>
                                                            </td>
                                                        </c:if>
                                                        <c:if test="${registers.invoice.approve_status == 'ไม่ผ่าน'}">
                                                            <td align="center" style="color: red;font-size: 14px">
                                                                <i class='fa fa-times-circle' style='color: red'></i>
                                                                <b>ไม่ผ่าน</b>
                                                            </td>
                                                        </c:if>
                                                        <c:if test="${registers.invoice.approve_status == 'รอดำเนินการ'}">
                                                            <c:if test="${registers.invoice.pay_status == true}">
                                                                <td align="center">
                                                                    <a href="${pageContext.request.contextPath}/course/${request_name.request_id}/view_payment_detail/${registers.invoice.invoice_id}">
                                                                        <button class="button-48" role="button" style="font-size: 14px">
                                                                            <span class="text">
                                                                                <i class='fas fa-money-check'></i>
                                                                                <b>ดูข้อมูลการชำระเงิน</b>
                                                                            </span>
                                                                        </button>
                                                                    </a>
                                                                </td>
                                                            </c:if>
                                                            <c:if test="${registers.invoice.pay_status == false}">
                                                                <td align="center" style="color: orange;font-size: 14px;">
                                                                    <i class='fa fa-minus-circle'></i>
                                                                    <b>ยังไม่ได้ชำระเงิน</b>
                                                                </td>
                                                            </c:if>
                                                        </c:if>
                                                    </tr>
                                                    <c:set var="count" value="${count + 1}"/>
                                                    <c:set var="count1" value="${count1 + 1}"/>
                                                </c:if>
                                            </c:forEach>
                                            <c:if test="${count == 0}">
                                                <tr>
                                                    <td colspan="6" align="center">ไม่มีข้อมูล</td>
                                                </tr>

                                            </c:if>
                                        </c:otherwise>
                                    </c:choose>
                                    </tbody>
                                </table>
                            </div>

                            <div id="not_payment_app" style="display: none">
                                <table class="table table-hover" style="width: 100%; align-self: flex-start;">
                                    <thead style="background-color: ${colorBar};">
                                        <tr style="color: black">
                                            <td style="width: 5%"><b style="font-size: 14px"></b></td>
                                            <td style="width: 20%"><b style="font-size: 14px">รหัสบัตรประชาชน</b></td>
                                            <td style="width: 20%" align="center"><b style="font-size: 14px">ชื่อ - นามสกุล</b></td>
                                            <td style="width: 20%" align="center"><b style="font-size: 14px">วันที่สมัคร</b></td>
                                            <td style="width: 15%" align="center"><b style="font-size: 14px">เบอร์โทรศัพท์</b></td>
                                            <td style="width: 20%" align="center"><b style="font-size: 14px">สถานะการสมัคร</b></td>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    <c:choose>
                                        <c:when test="${all_register_detail.size() == 0}">
                                            <tr>
                                                <td colspan="6" align="center">ไม่มีข้อมูล</td>
                                            </tr>
                                        </c:when>
                                        <c:otherwise>
                                            <c:set var="count" value="0"/>
                                            <c:set var="count1" value="1"/>
                                            <c:forEach var="registers" items="${all_register_detail}">
                                                <c:if test="${registers.invoice.approve_status == 'รอดำเนินการ' && registers.invoice.pay_status == false}">
                                                    <tr style="color: black">
                                                        <td><p>${count1}</p></td>
                                                        <td><p>${registers.member.idcard}</p></td>
                                                        <td><p>${registers.member.firstName} ${registers.member.lastName}</p></td>
                                                        <td align="center">
                                                            <fmt:formatDate value="${registers.register_date}" pattern="dd/MM/yyyy" var="register_date" />
                                                            <p>${register_date}</p>
                                                        </td>
                                                        <td align="center">${registers.member.tel}</td>
                                                        <c:if test="${registers.invoice.approve_status == 'ผ่าน'}">
                                                            <td align="center" style="color: green; font-size: 14px">
                                                                <i class='fa fa-check-circle' style='color:#008f11'></i>
                                                                <b> ผ่าน</b>
                                                            </td>
                                                        </c:if>
                                                        <c:if test="${registers.invoice.approve_status == 'ไม่ผ่าน'}">
                                                            <td align="center" style="color: red;font-size: 14px">
                                                                <i class='fa fa-times-circle' style='color: red'></i>
                                                                <b>ไม่ผ่าน</b>
                                                            </td>
                                                        </c:if>
                                                        <c:if test="${registers.invoice.approve_status == 'รอดำเนินการ'}">
                                                            <c:if test="${registers.invoice.pay_status == true}">
                                                                <td align="center">
                                                                    <a href="${pageContext.request.contextPath}/course/${request_name.request_id}/view_payment_detail/${registers.invoice.invoice_id}">
                                                                        <button class="button-48" role="button" style="font-size: 14px">
                                                                            <span class="text">
                                                                                <i class='fas fa-money-check'></i>
                                                                                <b>ดูข้อมูลการชำระเงิน</b>
                                                                            </span>
                                                                        </button>
                                                                    </a>
                                                                </td>
                                                            </c:if>
                                                            <c:if test="${registers.invoice.pay_status == false}">
                                                                <td align="center" style="color: orange;font-size: 14px;">
                                                                    <i class='fa fa-minus-circle'></i>
                                                                    <b>ยังไม่ได้ชำระเงิน</b>
                                                                </td>
                                                            </c:if>
                                                        </c:if>
                                                    </tr>
                                                    <c:set var="count" value="${count + 1}"/>
                                                    <c:set var="count1" value="${count1 + 1}"/>
                                                </c:if>
                                            </c:forEach>
                                            <c:if test="${count == 0}">
                                                <tr>
                                                    <td colspan="6" align="center">ไม่มีข้อมูล</td>
                                                </tr>

                                            </c:if>
                                        </c:otherwise>
                                    </c:choose>
                                    </tbody>
                                </table>
                            </div>

                            <div id="false_payment_app" style="display: none">
                                <table class="table table-hover" style="width: 100%; align-self: flex-start;">
                                    <thead style="background-color: ${colorBar};">
                                        <tr style="color: black">
                                            <td style="width: 5%"><b style="font-size: 14px"></b></td>
                                            <td style="width: 20%"><b style="font-size: 14px">รหัสบัตรประชาชน</b></td>
                                            <td style="width: 20%" align="center"><b style="font-size: 14px">ชื่อ - นามสกุล</b></td>
                                            <td style="width: 20%" align="center"><b style="font-size: 14px">วันเวลาในการชำระเงิน</b></td>
                                            <td style="width: 15%" align="center"><b style="font-size: 14px">เบอร์โทรศัพท์</b></td>
                                            <td style="width: 20%" align="center"><b style="font-size: 14px">สถานะการสมัคร</b></td>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    <c:choose>
                                        <c:when test="${all_register_detail.size() == 0}">
                                            <tr>
                                                <td colspan="6" align="center">ไม่มีข้อมูล</td>
                                            </tr>
                                        </c:when>
                                        <c:otherwise>
                                            <c:set var="count" value="0"/>
                                            <c:set var="count1" value="1"/>
                                            <c:forEach var="registers" items="${all_register_detail}">
                                                <c:if test="${registers.invoice.approve_status == 'ไม่ผ่าน'}">
                                                    <tr style="color: black">
                                                        <td><p>${count1}</p></td>
                                                        <td><p>${registers.member.idcard}</p></td>
                                                        <td><p>${registers.member.firstName} ${registers.member.lastName}</p></td>
                                                        <c:choose>
                                                            <c:when test="${registers.requestOpenCourse.course.fee == 0}">
                                                                <td align="center"><p>ไม่มีค่าธรรมเนียม(ฟรี)</p></td>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <c:set value="0" var="count"/>
                                                                <c:forEach var="receipts" items="${receipt}">
                                                                    <fmt:formatDate value="${receipts.pay_date}" pattern="dd/MM/yyyy" var="pay_date" />
                                                                    <c:if test="${registers.invoice.invoice_id == receipts.invoice.invoice_id}">
                                                                        <td align="center">${pay_date} ${receipts.pay_time} น.</td>
                                                                        <c:set var="count" value="${count +1}"/>
                                                                    </c:if>
                                                                </c:forEach>
                                                                <c:if test="${count == 0}">
                                                                    <td align="center">ยังไม่มีการชำระเงิน</td>
                                                                </c:if>
                                                            </c:otherwise>
                                                        </c:choose>
                                                        <td align="center">${registers.member.tel}</td>
                                                        <c:if test="${registers.invoice.approve_status == 'ผ่าน'}">
                                                            <td align="center" style="color: green; font-size: 14px">
                                                                <i class='fa fa-check-circle' style='color:#008f11'></i>
                                                                <b> ผ่าน</b>
                                                            </td>
                                                        </c:if>
                                                        <c:if test="${registers.invoice.approve_status == 'ไม่ผ่าน'}">
                                                            <td align="center" style="color: red;font-size: 14px">
                                                                <i class='fa fa-times-circle' style='color: red'></i>
                                                                <b>ไม่ผ่าน</b>
                                                            </td>
                                                        </c:if>
                                                        <c:if test="${registers.invoice.approve_status == 'รอดำเนินการ'}">
                                                            <c:if test="${registers.invoice.pay_status == true}">
                                                                <td align="center">
                                                                    <a href="${pageContext.request.contextPath}/course/${request_name.request_id}/view_payment_detail/${registers.invoice.invoice_id}">
                                                                        <button class="button-48" role="button" style="font-size: 14px">
                                                                            <span class="text">
                                                                                <i class='fas fa-money-check'></i>
                                                                                <b>ดูข้อมูลการชำระเงิน</b>
                                                                            </span>
                                                                        </button>
                                                                    </a>
                                                                </td>
                                                            </c:if>
                                                            <c:if test="${registers.invoice.pay_status == false}">
                                                                <td align="center" style="color: orange;font-size: 14px;">
                                                                    <i class='fa fa-minus-circle'></i>
                                                                    <b>ยังไม่ได้ชำระเงิน</b>
                                                                </td>
                                                            </c:if>
                                                        </c:if>
                                                    </tr>
                                                    <c:set var="count" value="${count + 1}"/>
                                                    <c:set var="count1" value="${count1 + 1}"/>
                                                </c:if>
                                            </c:forEach>
                                            <c:if test="${count == 0}">
                                                <tr>
                                                    <td colspan="6" align="center">ไม่มีข้อมูล</td>
                                                </tr>

                                            </c:if>
                                        </c:otherwise>
                                    </c:choose>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </c:if>

                    <c:if test="${request_name.course.status == 'เปิดสอน'}">
                        <div id="div_register" style="width: 100%; align-self: flex-start;" align="left">
                            <div style="display: flex; width: 100%" >
                                <div align="left" style="width: 50%"><h3>รายชื่อผู้สมัคร (อยู่ในช่วงระหว่างเรียน)</h3></div>
                                <div align="right" style="width: 50%;">
                                    <div style="display:flex; width: 180px">
                                        <div style="margin-right: 10px"><i class="fa fa-users fa-2x"></i></div>
                                        <div><h4>${request_name.numberOfAllRegistrationsToPass} คน</h4></div>
                                    </div>
                                </div>
                            </div>
                            <hr>
                            <table class="table table-hover" style="width: 100%; align-self: flex-start;">
                                <thead style="background-color: ${colorBar};">
                                    <tr style="color: black">
                                        <td style="width: 5%"><b style="font-size: 14px"></b></td>
                                        <td style="width: 20%"><b style="font-size: 14px">รหัสบัตรประชาชน</b></td>
                                        <td style="width: 20%" align="center"><b style="font-size: 14px">ชื่อ - นามสกุล</b></td>
                                        <td style="width: 20%" align="center"><b style="font-size: 14px">วันที่สมัคร</b></td>
                                        <td style="width: 15%" align="center"><b style="font-size: 14px">เบอร์โทรศัพท์</b></td>
                                        <td style="width: 20%" align="center"><b style="font-size: 14px">สถานะการเรียน</b></td>
                                    </tr>
                                </thead>
                                <tbody>
                                <c:choose>
                                    <c:when test="${all_register_detail.size() == 0}">
                                        <tr>
                                            <td colspan="6" align="center">ไม่มีข้อมูล</td>
                                        </tr>
                                    </c:when>
                                    <c:otherwise>
                                        <c:set var="count" value="0"/>
                                        <c:set var="count1" value="1"/>
                                        <c:forEach var="registers" items="${all_register_detail}">
                                            <c:if test="${registers.invoice.approve_status == 'ผ่าน'}">
                                                <fmt:formatDate value="${registers.register_date}" pattern="dd/MM/yyyy" var="register_date" />
                                                <tr style="color: black">
                                                    <td><p>${count1}</p></td>
                                                    <td><p>${registers.member.idcard}</p></td>
                                                    <td><p>${registers.member.firstName} ${registers.member.lastName}</p></td>
                                                    <td align="center">
                                                        <p>${register_date}</p>
                                                    </td>
                                                    <td align="center">${registers.member.tel}</td>
                                                    <td align="center" style="font-size: 14px;">
                                                        <c:choose>
                                                            <c:when test="${currentDate >= request_name.startStudyDate}">
                                                                <i class='fas fa-book-reader'></i>
                                                                <b style="color: orange">${registers.study_result}</b>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <i class='fas fa-clock'></i>
                                                                <b>รอถึงวันเรียน</b>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                </tr>
                                                <c:set var="count" value="${count + 1}"/>
                                                <c:set var="count1" value="${count1 + 1}"/>
                                            </c:if>
                                        </c:forEach>
                                        <c:if test="${count == 0}">
                                            <tr>
                                                <td colspan="6" align="center">ไม่มีข้อมูล</td>
                                            </tr>

                                        </c:if>
                                    </c:otherwise>
                                </c:choose>
                                </tbody>
                            </table>
                        </div>
                    </c:if>

                    <c:if test="${request_name.requestStatus == 'เสร็จสิ้น'}">
                        <div id="div_register" style="width: 100%; align-self: flex-start;" align="left">
                            <div style="display: flex; width: 100%" >
                                <div align="left" style="width: 50%"><h3>รายชื่อผู้สมัคร (เสร็จสิ้นการเรียนการสอน)</h3></div>
                                <div align="right" style="width: 50%;">
                                    <div style="display:flex; width: 180px">
                                        <div style="margin-right: 10px"><i class="fa fa-users fa-2x"></i></div>
                                        <div><h4>${request_name.numberOfAllRegistrationsByStudyResult} / ${request_name.numberOfAllRegistrationsToPass}</h4></div>
                                    </div>
                                </div>
                            </div>
                            <hr>
                            <table class="table table-hover" style="width: 100%; align-self: flex-start;">
                                <thead style="background-color: ${colorBar};">
                                <tr style="color: black">
                                    <td style="width: 5%"><b style="font-size: 14px"></b></td>
                                    <td style="width: 20%"><b style="font-size: 14px">รหัสบัตรประชาชน</b></td>
                                    <td style="width: 20%" align="center"><b style="font-size: 14px">ชื่อ - นามสกุล</b></td>
                                    <td style="width: 20%" align="center"><b style="font-size: 14px">วันที่สมัคร</b></td>
                                    <td style="width: 15%" align="center"><b style="font-size: 14px">เบอร์โทรศัพท์</b></td>
                                    <td style="width: 20%" align="center"><b style="font-size: 14px">สถานะการเรียน</b></td>
                                </tr>
                                </thead>
                                <tbody>
                                <c:choose>
                                    <c:when test="${all_register_detail.size() == 0}">
                                        <tr>
                                            <td colspan="6" align="center">ไม่มีข้อมูล</td>
                                        </tr>
                                    </c:when>
                                    <c:otherwise>
                                        <c:set var="count" value="0"/>
                                        <c:set var="count1" value="1"/>
                                        <c:forEach var="registers" items="${all_register_detail}">
                                            <c:if test="${registers.invoice.approve_status == 'ผ่าน'}">
                                                <fmt:formatDate value="${registers.register_date}" pattern="dd/MM/yyyy" var="register_date" />
                                                <tr style="color: black">
                                                    <td><p>${count1}</p></td>
                                                    <td><p>${registers.member.idcard}</p></td>
                                                    <td><p>${registers.member.firstName} ${registers.member.lastName}</p></td>
                                                    <td align="center">
                                                        <p>${register_date}</p>
                                                    </td>
                                                    <td align="center">${registers.member.tel}</td>

                                                    <c:choose>
                                                        <c:when test="${registers.study_result == 'ผ่าน'}">
                                                            <td align="center" style="color: green; font-size: 14px">
                                                                <i class='fa fa-check-circle' style='color:#008f11'></i>
                                                                <b> ${registers.study_result}</b>
                                                            </td>
                                                        </c:when>
                                                        <c:when test="${registers.study_result == 'ไม่ผ่าน'}">
                                                            <td align="center" style="color: red;font-size: 14px">
                                                                <i class='fa fa-times-circle' style='color: red'></i>
                                                                <b>${registers.study_result}</b>
                                                            </td>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <td align="center" style="color: orange;font-size: 14px;">
                                                                <i class='fa fa-minus-circle'></i>
                                                                <b>รอดำเนินการ</b>
                                                            </td>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </tr>
                                                <c:set var="count" value="${count + 1}"/>
                                                <c:set var="count1" value="${count1 + 1}"/>
                                            </c:if>
                                        </c:forEach>
                                        <c:if test="${count == 0}">
                                            <tr>
                                                <td colspan="6" align="center">ไม่มีข้อมูล</td>
                                            </tr>

                                        </c:if>
                                    </c:otherwise>
                                </c:choose>
                                </tbody>
                            </table>
                        </div>
                    </c:if>
                        <%--                    <c:if test="${request_name.requestStatus == 'ถูกยกเลิก' && currentDate <= request_name.applicationResult}">--%>
                    <c:if test="${request_name.requestStatus == 'ถูกยกเลิก'}">
                        <div id="div_register" style="width: 100%; align-self: flex-start;" align="left">
                            <div style="display: flex; width: 100%" >
                                <div align="left" style="width: 50%"><h3>รายชื่อผู้สมัคร (ถูกยกเลิก)</h3></div>
                                <div align="right" style="width: 50%;">
                                    <div style="display:flex; width: 180px">
                                        <div style="margin-right: 10px"><i class="fa fa-users fa-2x"></i></div>
                                        <div><h4>${request_name.numberOfAllRegistrations} / ${request_name.quantity}</h4></div>
                                    </div>
                                </div>
                            </div>
                            <hr>
                            <table class="table table-hover" style="width: 100%; align-self: flex-start;">
                                <thead style="background-color: ${colorBar};">
                                    <tr style="color: black">
                                        <td style="width: 5%"><b style="font-size: 14px"></b></td>
                                        <td style="width: 20%"><b style="font-size: 14px">รหัสบัตรประชาชน</b></td>
                                        <td style="width: 20%" align="center"><b style="font-size: 14px">ชื่อ - นามสกุล</b></td>
                                        <td style="width: 20%" align="center"><b style="font-size: 14px">วันที่สมัคร</b></td>
                                        <td style="width: 15%" align="center"><b style="font-size: 14px">เบอร์โทรศัพท์</b></td>
                                        <td style="width: 20%" align="center"><b style="font-size: 14px">สถานะการชำระเงิน</b></td>
                                    </tr>
                                </thead>
                                <tbody>
                                <c:choose>
                                    <c:when test="${all_register_detail.size() == 0}">
                                        <tr>
                                            <td colspan="6" align="center">ไม่มีข้อมูล</td>
                                        </tr>
                                    </c:when>
                                    <c:otherwise>
                                        <c:set var="count" value="0"/>
                                        <c:set var="count1" value="1"/>
                                        <c:forEach var="registers" items="${all_register_detail}">
                                            <fmt:formatDate value="${registers.register_date}" pattern="dd/MM/yyyy" var="register_date" />
                                            <tr style="color: black">
                                                <td><p>${count1}</p></td>
                                                <td><p>${registers.member.idcard}</p></td>
                                                <td><p>${registers.member.firstName} ${registers.member.lastName}</p></td>
                                                <td align="center">
                                                    <p>${register_date}</p>
                                                </td>
                                                <td align="center">${registers.member.tel}</td>

                                                    <%--                                                    <td align="center">${registers.invoice.pay_status}</td>--%>
                                                <c:if test="${registers.invoice.pay_status == true}">
                                                    <td align="center">
                                                        <a href="${pageContext.request.contextPath}/course/${request_name.request_id}/view_payment_detail/${registers.invoice.invoice_id}">
                                                            <button class="button-48" role="button" style="font-size: 14px">
                                                                            <span class="text">
                                                                                <i class='fas fa-money-check'></i>
                                                                                <b>ดูข้อมูลการชำระเงิน</b>
                                                                            </span>
                                                            </button>
                                                        </a>
                                                    </td>
                                                </c:if>
                                                <c:if test="${registers.invoice.pay_status == false}">
                                                    <td align="center" style="color: orange;font-size: 14px;">
                                                        <i class='fa fa-minus-circle'></i>
                                                        <b>ยังไม่ได้ชำระเงิน</b>
                                                    </td>
                                                </c:if>
                                            </tr>
                                            <c:set var="count" value="${count + 1}"/>
                                            <c:set var="count1" value="${count1 + 1}"/>
                                        </c:forEach>
                                        <c:if test="${count == 0}">
                                            <tr>
                                                <td colspan="6" align="center">ไม่มีข้อมูล</td>
                                            </tr>

                                        </c:if>
                                    </c:otherwise>
                                </c:choose>
                                </tbody>
                            </table>
                        </div>
                    </c:if>
                </div>
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
    // ดึงค่าพารามิเตอร์ success จาก URL
    const urlParams = new URLSearchParams(window.location.search);
    const approveParam = urlParams.get('approveStatus');
    const editParam = urlParams.get('editStatus');

    // ถ้ามีค่าเป็น 'true', แสดง Alert
    if (approveParam === 'true') {
        alert("ยืนยันการสมัครสำเร็จ");
    } else if (editParam === 'true') {
        alert("ยกเลิกการสมัครสำเร็จ");
    }
</script>
<script>
    var allPayment = document.querySelector('input[name="listDisplay"][value="รายการทั้งหมด"]');
    allPayment.addEventListener("change", function() {
        if (allPayment.checked) {
            document.getElementById("all_payment").style.display = "block";
            document.getElementById("pass_payment").style.display = "none";
            document.getElementById("check_payment").style.display = "none";
            document.getElementById("not_payment").style.display = "none";
            document.getElementById("false_payment").style.display = "none";
        }
    });

    var passPayment = document.querySelector('input[name="listDisplay"][value="ผ่านการชำระเงิน"]');
    passPayment.addEventListener("change", function() {
        if (passPayment.checked) {
            document.getElementById("all_payment").style.display = "none";
            document.getElementById("pass_payment").style.display = "block";
            document.getElementById("check_payment").style.display = "none";
            document.getElementById("not_payment").style.display = "none";
            document.getElementById("false_payment").style.display = "none";
        }
    });

    var checkPayment = document.querySelector('input[name="listDisplay"][value="ตรวจสอบการชำระเงิน"]');
    checkPayment.addEventListener("change", function() {
        if (checkPayment.checked) {
            document.getElementById("all_payment").style.display = "none";
            document.getElementById("pass_payment").style.display = "none";
            document.getElementById("check_payment").style.display = "block";
            document.getElementById("not_payment").style.display = "none";
            document.getElementById("false_payment").style.display = "none";
        }
    });

    var notPayment = document.querySelector('input[name="listDisplay"][value="ยังไม่ได้ชำระเงิน"]');
    notPayment.addEventListener("change", function() {
        if (notPayment.checked) {
            document.getElementById("all_payment").style.display = "none";
            document.getElementById("pass_payment").style.display = "none";
            document.getElementById("check_payment").style.display = "none";
            document.getElementById("not_payment").style.display = "block";
            document.getElementById("false_payment").style.display = "none";
        }
    });

    var falsePayment = document.querySelector('input[name="listDisplay"][value="ไม่ผ่านการชำระเงิน"]');
    falsePayment.addEventListener("change", function() {
        if (falsePayment.checked) {
            document.getElementById("all_payment").style.display = "none";
            document.getElementById("pass_payment").style.display = "none";
            document.getElementById("check_payment").style.display = "none";
            document.getElementById("not_payment").style.display = "none";
            document.getElementById("false_payment").style.display = "block";
        }
    });
</script>
<script>
    var allPaymentApp = document.querySelector('input[name="listAppDisplay"][value="รายการทั้งหมด"]');
    allPaymentApp.addEventListener("change", function() {
        if (allPaymentApp.checked) {
            document.getElementById("all_payment_app").style.display = "block";
            document.getElementById("pass_payment_app").style.display = "none";
            document.getElementById("check_payment_app").style.display = "none";
            document.getElementById("not_payment_app").style.display = "none";
            document.getElementById("false_payment_app").style.display = "none";
        }
    });

    var passPaymentApp = document.querySelector('input[name="listAppDisplay"][value="ผ่านการชำระเงิน"]');
    passPaymentApp.addEventListener("change", function() {
        if (passPaymentApp.checked) {
            document.getElementById("all_payment_app").style.display = "none";
            document.getElementById("pass_payment_app").style.display = "block";
            document.getElementById("check_payment_app").style.display = "none";
            document.getElementById("not_payment_app").style.display = "none";
            document.getElementById("false_payment_app").style.display = "none";
        }
    });

    var checkPaymentApp = document.querySelector('input[name="listAppDisplay"][value="ตรวจสอบการชำระเงิน"]');
    checkPaymentApp.addEventListener("change", function() {
        if (checkPaymentApp.checked) {
            document.getElementById("all_payment_app").style.display = "none";
            document.getElementById("pass_payment_app").style.display = "none";
            document.getElementById("check_payment_app").style.display = "block";
            document.getElementById("not_payment_app").style.display = "none";
            document.getElementById("false_payment_app").style.display = "none";
        }
    });

    var notPaymentApp = document.querySelector('input[name="listAppDisplay"][value="ยังไม่ได้ชำระเงิน"]');
    notPaymentApp.addEventListener("change", function() {
        if (notPaymentApp.checked) {
            document.getElementById("all_payment_app").style.display = "none";
            document.getElementById("pass_payment_app").style.display = "none";
            document.getElementById("check_payment_app").style.display = "none";
            document.getElementById("not_payment_app").style.display = "block";
            document.getElementById("false_payment_app").style.display = "none";
        }
    });

    var falsePaymentApp = document.querySelector('input[name="listAppDisplay"][value="ไม่ผ่านการชำระเงิน"]');
    falsePaymentApp.addEventListener("change", function() {
        if (falsePaymentApp.checked) {
            document.getElementById("all_payment_app").style.display = "none";
            document.getElementById("pass_payment_app").style.display = "none";
            document.getElementById("check_payment_app").style.display = "none";
            document.getElementById("not_payment_app").style.display = "none";
            document.getElementById("false_payment_app").style.display = "block";
        }
    });
</script>
</html>
