<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="lifelong.model.*" %>
<%@ page import="java.util.List" %>
<html>
<head>
    <title>รายชื่อผู้สมัคร</title>
    <link href="${pageContext.request.contextPath}/assets/css/list_open_course_style.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/admin/list_approve_member.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/lecturer/list_member.css" rel="stylesheet">
    <jsp:include page="/WEB-INF/view/layouts/detail-all-style.jsp"/>
    <style>
        body{
            font-family: 'Prompt', sans-serif;
        }
        h1{
            font-family: 'Prompt', sans-serif;
            font-weight: 700 !important;
        }
        .btn-next-back {
            background-color: #aa4d13;
            border: 1px solid #aa4d13;
            border-radius: 4px;
            box-shadow: rgba(0, 0, 0, .1) 0 2px 4px 0;
            box-sizing: border-box;
            color: #fff;
            cursor: pointer;
            font-family: "Akzidenz Grotesk BQ Medium", -apple-system, BlinkMacSystemFont, sans-serif;
            font-size: 16px;
            font-weight: 400;
            outline: none;
            outline: 0;
            padding: 10px 25px;
            text-align: center;
            transform: translateY(0);
            transition: transform 150ms, box-shadow 150ms;
            user-select: none;
            -webkit-user-select: none;
            touch-action: manipulation;
        }
        .btn-next-back:hover {
            box-shadow: rgba(0, 0, 0, .15) 0 3px 9px 0;
            transform: translateY(-2px);
        }

        @media (min-width: 768px) {
            .btn-next-back {
                padding: 10px 30px;
            }
        }
        label{
            font-size: 12px;
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
        <%-- หน้าที่คุณต้องการแสดงและรายการต่อหน้า --%>
        <div align="center" style="width: 100%; margin-top: 20px">
            <div align="left" style="width: 85%">
                    <%--                <h2>${request_name.course.name}</h2>--%>
                <div align="center" class="main_container">

                    <div class="course_div" style="align-self: flex-start;">
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
                                        <div class="flex-container">
                                            <label>${request_name.course.fee} บาท</label>
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
                                            <label>${startPayment} - ${endPayment}</label>
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
                                    <c:set var="delimiter" value="$%"/>
                                    <c:set var="subText"
                                           value="${fn:split(request_name.studyTime, delimiter)}"/>
                                    <label>${startStudyDate} - ${endStudyDate}</label><br>
                                    <c:forEach var="ogText" items="${subText}">
                                        <c:set var="replaceSlash" value="${fn:replace(ogText, '/', ' ')}"/>
                                        <c:set var="newText" value="${fn:replace(replaceSlash, ',', ' - ')}"/>
                                        <label style="margin-bottom: 0px">${newText}</label>
                                    </c:forEach>
                                </div>
                            </div>
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
                        </div>
                    </div>
                    <div style="width: 100%; align-self: flex-start;" align="left">
                            <%--                        <div style="display: flex; width: 100%" >--%>
                            <%--                            <div align="left" style="width: 50%"><h3>รายชื่อผู้ที่ผ่านการสมัคร</h3></div>--%>
                            <%--                            <div align="right" style="width: 50%">--%>
                            <%--                                <h3>${request_name.} / ${request_name.quantity}</h3>--%>
                            <%--                            </div>--%>
                            <%--                        </div>--%>
                            <%--                        <hr>--%>
                        <c:if test="${request_name.course.status == 'ลงทะเบียน'}">
                            <div id="div_register" style="width: 100%; align-self: flex-start;" align="left">
                                <div style="display: flex; width: 100%" >
                                    <div align="left" style="width: 50%"><h3>รายชื่อผู้สมัคร (อยู่ในช่วงลงทะเบียน)</h3></div>
                                    <div align="right" style="width: 50%;">
                                        <div style="display:flex; width: 180px">
                                            <div style="margin-right: 10px"><i class="fa fa-users fa-2x"></i></div>
                                            <div><h4>${request_name.numberOfAllRegistrations} / ${request_name.quantity}</h4></div>
                                        </div>
                                    </div>
                                </div>
                                <hr>
                                <table class="table table-hover" style="width: 100%; align-self: flex-start;">
                                    <thead>
                                        <tr style="color: black">
                                            <td style="width: 25%"><b style="font-size: 14px;">รหัสบัตรประชาชน</b></td>
                                            <td style="width: 30%" align="center"><b style="font-size: 14px;">ชื่อ - นามสกุล</b></td>
                                            <td style="width: 15%" align="center"><b style="font-size: 14px;">วันที่สมัคร</b></td>
                                            <td style="width: 25%" align="center"><b style="font-size: 14px;">สถานะการสมัคร</b></td>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%--                            <c:forEach var="list" items="${registers}">--%>
                                    <c:choose>
                                        <c:when test="${registers_sort_by_action_date.size() == 0}">
                                            <tr>
                                                <td colspan="5" align="center">ไม่มีข้อมูล</td>
                                            </tr>
                                        </c:when>
                                        <c:otherwise>
                                            <c:set var="count" value="1" />
                                            <c:forEach items="${registers_sort_by_action_date}" var="list" >
                                                <tr>
                                                        <%--                                        <c:set var="count" value="${startIndex + 1}"/>--%>
                                                    <td>${list.member.idcard}</td>
                                                    <td align="center">${list.member.firstName} ${list.member.lastName}</td>
                                                    <fmt:formatDate value="${list.register_date}" pattern="dd/MM/yyyy" var="date" />
                                                    <td align="center">${date}</td>
                                                    <td align="center">
                                                        <c:choose>
                                                            <c:when test="${request_name.course.fee == 0}">
                                                                <p>รอเรียน</p>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <p>รอชำระเงิน</p>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                </tr>
                                                <c:set var="count" value="${count+1}" />
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
                                            <div><h4>${request_name.numberOfAllRegistrations} / ${request_name.quantity}</h4></div>
                                        </div>
                                    </div>
                                </div>
                                <hr>
                                <table class="table table-hover" style="width: 100%; align-self: flex-start;">
                                    <thead>
                                        <tr style="color: black">
                                            <td style="width: 20%"><b style="font-size: 14px;">รหัสบัตรประชาชน</b></td>
                                            <td style="width: 20%"><b style="font-size: 14px;">ชื่อ - นามสกุล</b></td>
                                            <td style="width: 10%" align="center"><b style="font-size: 14px;">วันที่สมัคร</b></td>
                                            <td style="width: 15%" align="center"><b style="font-size: 14px;">วันที่ชำระเงิน</b></td>
                                            <td style="width: 20%" align="center"><b style="font-size: 14px;">เบอร์โทรศัพท์</b></td>
                                            <td style="width: 20%" align="center"><b style="font-size: 14px;">สถานะการสมัคร</b></td>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    <c:choose>
                                        <c:when test="${all_register.size() == 0}">
                                            <tr>
                                                <td colspan="5" align="center">ยังไม่มีผู้ลงทะเบียน</td>
                                            </tr>
                                        </c:when>
                                        <c:otherwise>
                                            <c:forEach var="register" items="${all_register}">
                                                <fmt:formatDate value="${register.register_date}" pattern="dd/MM/yyyy" var="register_date" />
                                                <tr style="color: black">
                                                    <td><p>${register.member.idcard}</p></td>
                                                    <td><p>${register.member.firstName} ${register.member.lastName}</p></td>
                                                    <td align="center">
                                                        <p>${register_date}</p>
                                                    </td>
                                                    <c:choose>
                                                        <c:when test="${register.requestOpenCourse.course.fee == 0}">
                                                            <td>ไม่มีค่าธรรมเนียม(ฟรี)</td>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <c:set value="0" var="count"/>
                                                            <c:forEach var="receipts" items="${receipt}">
                                                                <fmt:formatDate value="${receipts.pay_date}" pattern="dd/MM/yyyy" var="pay_date" />
                                                                <c:if test="${register.invoice.invoice_id == receipts.invoice.invoice_id}">
                                                                    <td align="center">${pay_date} ${receipts.pay_time} น.</td>
                                                                    <c:set var="count" value="${count +1}"/>
                                                                </c:if>
                                                            </c:forEach>
                                                            <c:if test="${count == 0}">
                                                                <td align="center">ยังไม่มีการชำระเงิน</td>
                                                            </c:if>
                                                        </c:otherwise>
                                                    </c:choose>
                                                    <td align="center">${register.member.tel}</td>
                                                    <c:choose>
                                                        <c:when test="${register.requestOpenCourse.course.fee == 0}">
                                                            <td align="center">รอเรียน</td>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <c:if test="${register.invoice.approve_status == 'ผ่าน'}">
                                                                <td align="center" style="color: green">ผ่าน</td>
                                                            </c:if>
                                                            <c:if test="${register.invoice.approve_status == 'ไม่ผ่าน'}">
                                                                <td align="center" style="color: red">ไม่ผ่าน</td>
                                                            </c:if>
                                                            <c:if test="${register.invoice.approve_status == 'รอดำเนินการ'}">
                                                                <td align="center" style="color: orange">รอดำเนินการ</td>
                                                            </c:if>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </tr>
                                            </c:forEach>
                                        </c:otherwise>
                                    </c:choose>
                                    </tbody>
                                </table>
                            </div>
                        </c:if>

                        <c:if test="${request_name.course.status == 'ชำระเงิน'}">
                            <div id="div_payment" style="width: 100%; align-self: flex-start;" align="left">
                                <div style="display: flex; width: 100%" >
                                    <div align="left" style="width: 50%"><h3>รายชื่อผู้สมัคร (อยู่ในช่วงชำระเงิน)</h3></div>
                                    <div align="right" style="width: 50%;">
                                        <div style="display:flex; width: 180px">
                                            <div style="margin-right: 10px"><i class="fa fa-users fa-2x"></i></div>
                                            <div><h4>${request_name.numberOfAllRegistrationsPayStatus} / ${request_name.registerList.size()}</h4></div>
                                        </div>
                                    </div>
                                </div>
                                <hr>
                                <div id="all_payment" style="display: block">
                                    <table class="table table-hover" style="width: 100%; align-self: flex-start;">
                                        <thead>
                                            <tr style="color: black">
                                                <td style="width: 20%"><b style="font-size: 14px;">รหัสบัตรประชาชน</b></td>
                                                <td style="width: 20%"><b style="font-size: 14px;">ชื่อ - นามสกุล</b></td>
                                                <td style="width: 20%" align="center"><b style="font-size: 14px;">วันเวลาในการชำระเงิน</b></td>
                                                <td style="width: 20%" align="center"><b style="font-size: 14px;">เบอร์โทรศัพท์</b></td>
                                                <td style="width: 20%" align="center"><b style="font-size: 14px;">สถานะการสมัคร</b></td>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        <c:choose>
                                            <c:when test="${all_register.size() == 0}">
                                                <tr>
                                                    <td colspan="5" align="center">ไม่มีข้อมูล</td>
                                                </tr>
                                            </c:when>
                                            <c:otherwise>
                                                <c:forEach var="register" items="${all_register}">
                                                    <tr style="color: black">
                                                        <td><p>${register.member.idcard}</p></td>
                                                        <td><p>${register.member.firstName} ${register.member.lastName}</p></td>

                                                        <c:choose>
                                                            <c:when test="${request_name.course.fee == 0}">
                                                                <td align="center">ไม่มีค่าธรรมเนียม(ฟรี)</td>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <c:set value="0" var="count"/>
                                                                <c:forEach var="receipts" items="${receipt}">
                                                                    <fmt:formatDate value="${receipts.pay_date}" pattern="dd/MM/yyyy" var="pay_date" />
                                                                    <c:if test="${register.invoice.invoice_id == receipts.invoice.invoice_id}">
                                                                        <td align="center">${pay_date} ${receipts.pay_time} น.</td>
                                                                        <c:set var="count" value="${count +1}"/>
                                                                    </c:if>
                                                                </c:forEach>
                                                                <c:if test="${count == 0}">
                                                                    <td align="center">ยังไม่มีการชำระเงิน</td>
                                                                </c:if>
                                                            </c:otherwise>
                                                        </c:choose>
                                                        <td align="center">${register.member.tel}</td>
                                                        <c:choose>
                                                            <c:when test="${register.invoice.approve_status == 'ผ่าน'}">
                                                                <td align="center" style="color: green">ผ่าน</td>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <td align="center" style="color: orange">รอดำเนินการ</td>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </tr>
                                                </c:forEach>
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
                                <div id="all_payment_app" style="display: block">
                                    <table class="table table-hover" style="width: 100%; align-self: flex-start;">
                                        <thead>
                                            <tr style="color: black">
                                                <td style="width: 20%"><b style="font-size: 14px;">รหัสบัตรประชาชน</b></td>
                                                <td style="width: 20%"><b style="font-size: 14px;">ชื่อ - นามสกุล</b></td>
                                                <td style="width: 20%" align="center"><b style="font-size: 14px;">วันเวลาในการชำระเงิน</b></td>
                                                <td style="width: 20%" align="center"><b style="font-size: 14px;">เบอร์โทรศัพท์</b></td>
                                                <td style="width: 20%" align="center"><b style="font-size: 14px;">สถานะการสมัคร</b></td>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        <c:choose>
                                            <c:when test="${all_register.size() == 0}">
                                                <tr>
                                                    <td colspan="5" align="center">ไม่มีข้อมูล</td>
                                                </tr>
                                            </c:when>
                                            <c:otherwise>
                                                <c:forEach var="register" items="${all_register}">
                                                    <%--                                                <c:if test="${registers.invoice.pay_status == true || registers.invoice.approve_status == 'ไม่ผ่าน'}">--%>
                                                    <tr style="color: black">
                                                        <td><p>${register.member.idcard}</p></td>
                                                        <td><p>${register.member.firstName} ${register.member.lastName}</p></td>
                                                        <c:choose>
                                                            <c:when test="${register.requestOpenCourse.course.fee == 0}">
                                                                <td align="center"><p>ไม่มีค่าธรรมเนียม(ฟรี)</p></td>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <c:set value="0" var="count"/>
                                                                <c:forEach var="receipts" items="${receipt}">
                                                                    <fmt:formatDate value="${receipts.pay_date}" pattern="dd/MM/yyyy" var="pay_date" />
                                                                    <c:if test="${register.invoice.invoice_id == receipts.invoice.invoice_id}">
                                                                        <td align="center">${pay_date} ${receipts.pay_time} น.</td>
                                                                        <c:set var="count" value="${count +1}"/>
                                                                    </c:if>
                                                                </c:forEach>
                                                                <c:if test="${count == 0}">
                                                                    <td align="center">ยังไม่มีการชำระเงิน</td>
                                                                </c:if>
                                                            </c:otherwise>
                                                        </c:choose>
                                                        <td align="center">${register.member.tel}</td>
                                                        <c:if test="${register.invoice.approve_status == 'ผ่าน'}">
                                                            <td align="center" style="color: green">ผ่าน</td>
                                                        </c:if>
                                                        <c:if test="${register.invoice.approve_status == 'ไม่ผ่าน'}">
                                                            <td align="center" style="color: red">ไม่ผ่าน</td>
                                                        </c:if>
                                                        <c:if test="${register.invoice.approve_status == 'รอดำเนินการ'}">
                                                            <td align="center" style="color: orange">ยังไม่ได้ชำระเงิน</td>
                                                        </c:if>
                                                    </tr>
                                                    <%--                                                </c:if>--%>
                                                </c:forEach>
                                            </c:otherwise>
                                        </c:choose>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </c:if>

                        <c:if test="${request_name.course.status == 'เปิดสอน'}">
                            <div style="display: flex; width: 100%" >
                                <div align="left" style="width: 50%"><h3>รายชื่อผู้สมัคร (อยู่ในช่วงระหว่างเรียน)</h3></div>
                                <div align="right" style="width: 50%;">
                                    <div style="display:flex; width: 180px">
                                        <div style="margin-right: 10px"><i class="fa fa-users fa-2x"></i></div>
                                        <div><h4>${request_name.numberOfAllRegistrationsByStudyResult} / ${request_name.numberOfAllRegistrationsToPass}</h4></div>
                                    </div>
                                </div>
                            </div>
                            <hr>
                            <div style="display: flex; width: 100%" >
                                <div align="left" style="width: 50%"></div>
                                <div align="right" style="width: 50%">
                                    <input type="button" value="ดาวน์โหลดรายชื่อ"
                                           onclick="window.location.href='${pageContext.request.contextPath}/lecturer/${request_id}/downloadExcel'; return false;"
                                           class="btn btn-outline-primary"/>
                                </div>
                            </div>
                            <table id="afterApp" class="table table-hover" style="width: 100%; align-self: flex-start;">
                                <thead>
                                    <tr style="color: black">
                                        <td style="width: 5%"></td>
                                        <td style="width: 20%"><b style="font-size: 14px;">รหัสบัตรประชาชน</b></td>
                                        <td style="width: 35%" align="center"><b style="font-size: 14px;">ชื่อ - นามสกุล</b></td>
                                        <td style="width: 20%" align="center"><b style="font-size: 14px;">สถานะการอบรม</b></td>
                                        <td style="width: 10%" align="center"></td>
                                        <td style="width: 10%" align="center"></td>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%--                            <c:forEach var="list" items="${registers}">--%>
                                <c:set var="count" value="1" />
                                <c:forEach items="${registers}" var="list" >
                                    <c:if test="${list.invoice.approve_status == 'ผ่าน'}">
                                        <form action="${pageContext.request.contextPath}/lecturer/${request_id}/update_Status_Member_Result/${list.register_id}" method="POST" onsubmit="return confirmAction();">
                                            <tr>
                                                    <%--                                        <c:set var="count" value="${startIndex + 1}"/>--%>
                                                <td align="center">${count}</td>
                                                <td>${list.member.idcard}</td>
                                                <td align="center">${list.member.firstName} ${list.member.lastName}</td>
                                                <td align="center">
                                                    <c:set var="color" value="orange"></c:set>
                                                    <c:if test="${list.study_result == 'ผ่าน'}">
                                                        <c:set var="color" value="green"></c:set>
                                                    </c:if>
                                                    <c:if test="${list.study_result == 'ไม่ผ่าน'}">
                                                        <c:set var="color" value="red"></c:set>
                                                    </c:if>
                                                    <c:choose>
                                                        <c:when test="${currentDate >= request_name.startStudyDate}">
                                                            <p style="color: ${color}">${list.study_result}</p>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <p>รอถึงวันเรียน</p>
                                                        </c:otherwise>
                                                    </c:choose>

                                                </td align="center">
                                                    <%--                <td>--%>
                                                    <%--                    ${list.invoice.pay_status}--%>
                                                    <%--                </td>--%>


                                                <c:choose>
                                                    <c:when test="${currentDate >= request_name.startStudyDate}">
                                                        <c:choose>
                                                            <c:when test="${list.study_result == 'ผ่าน'}">
                                                                <td align="center">
                                                                    <input type="submit" name="studyResult" class="btn btn-danger" value="ไม่ผ่านหลักสูตร"/>
                                                                </td>
                                                                <td align="center">
                                                                    <input type="submit" name="studyResult" value="ผ่านหลักสูตร" class="btn btn-success" style="display: none;"/>
                                                                </td>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <td align="center">
                                                                    <input type="submit" name="studyResult" class="btn btn-success" value="ผ่านหลักสูตร"/>
                                                                </td>
                                                                <td align="center">
                                                                    <input type="submit" name="studyResult" value="ไม่ผ่านหลักสูตร" class="btn btn-danger" style="display: none;"/>
                                                                </td>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <td colspan="2"></td>
                                                    </c:otherwise>
                                                </c:choose>
                                            </tr>
                                        </form>
                                        <c:set var="count" value="${count+1}" />
                                    </c:if>


                                </c:forEach>
                                </tbody>
                            </table>
                        </c:if>
                    </div>
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
    const studyResultParam = urlParams.get('studyResult');

    // ถ้ามีค่าเป็น 'true', แสดง Alert
    if (studyResultParam === 'true') {
        alert("บันทึกการผ่านหลักสูตร");
    }else if (studyResultParam === 'false') {
        alert("บันทึกการไม่ผ่านหลักสูตร");
    }
</script>
<%--<script>--%>
<%--    var currentDate = new Date();--%>
<%--    var applicationDate = '${request_name.applicationResult}';--%>
<%--    var applicationResult = new Date(applicationDate);--%>

<%--    if (currentDate >= applicationResult) {--%>
<%--        document.getElementById("beforeApp").style.display = "none";--%>
<%--        document.getElementById("afterApp").style.display = "block";--%>
<%--    }else {--%>
<%--        document.getElementById("beforeApp").style.display = "block";--%>
<%--        document.getElementById("afterApp").style.display = "none";--%>
<%--    }--%>
<%--</script>--%>
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
</script>
<script>

    function confirmAction() {
        var result = confirm("คุณแน่ใจหรือไม่ว่าต้องการดำเนินการขั้นตอนต่อไปนี้?");
        if (result) {
            return true; // ถ้าผู้ใช้กด OK ให้ทำงานตามปกติ
        } else {
            return false; // ถ้าผู้ใช้กด Cancel ให้ยกเลิกการส่งฟอร์ม
        }
    }
</script>
</html>
