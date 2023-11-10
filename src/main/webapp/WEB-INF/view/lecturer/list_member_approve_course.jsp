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
    <style>
        .wrapper{
            display: inline-flex;
            background: #fff;
            height: 70px;
            width: 600px;
            align-items: center;
            justify-content: space-evenly;
            border-radius: 5px;
            padding: 20px 15px;
            /*box-shadow: 5px 5px 30px rgba(0,0,0,0.2);*/
        }
        .wrapper .option{
            background: #fff;
            height: 100%;
            width: 100%;
            display: flex;
            align-items: center;
            justify-content: space-evenly;
            margin: 0 10px;
            border-radius: 5px;
            cursor: pointer;
            padding: 0 10px;
            border: 2px solid lightgrey;
            transition: all 0.3s ease;
        }
        .wrapper .option .dot{
            height: 10px;
            width: 10px;
            background: #d9d9d9;
            border-radius: 50%;
            /*position: relative;*/
            display: none;
        }
        .wrapper .option .dot::before{
            position: absolute;
            content: "";
            top: 4px;
            left: 4px;
            width: 12px;
            height: 12px;
            background: #0069d9;
            border-radius: 50%;
            opacity: 0;
            transform: scale(1.5);
            transition: all 0.3s ease;
        }
        input[type="radio"]{
            display: none;
        }
        #option-1:checked:checked ~ .option-1{
            border-color: #0069d9;
            background: #0069d9;
        }
        #option-2:checked:checked ~ .option-2{
            border-color: #005f00;
            background: #005f00;
        }
        #option-3:checked:checked ~ .option-3{
            border-color: #d90000;
            background: #d90000;
        }
        #option-1:checked:checked ~ .option-1 .dot,
        #option-2:checked:checked ~ .option-2 .dot,
        #option-3:checked:checked ~ .option-3 .dot{
            background: #fff;
        }
        #option-1:checked:checked ~ .option-1 .dot::before,
        #option-2:checked:checked ~ .option-2 .dot::before,
        #option-3:checked:checked ~ .option-3 .dot::before{
            opacity: 1;
            transform: scale(1);
        }
        .wrapper .option span{
            font-size: 12px;
            color: #808080;
        }
        #option-1:checked:checked ~ .option-1 span,
        #option-2:checked:checked ~ .option-2 span,
        #option-3:checked:checked ~ .option-3 span{
            color: #fff;
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
                    <a href="${pageContext.request.contextPath}/lecturer/<%=lecturer.getUsername()%>/add_roc" class="nav-item nav-link" style="font-size: 18px">ร้องขอหลักสูตร</a>
                    <a href="${pageContext.request.contextPath}/lecturer/<%=lecturer.getUsername()%>/list_request_open_course" class="nav-item nav-link" style="font-size: 18px">รายการร้องขอ</a>
                    <a href="${pageContext.request.contextPath}/lecturer/<%=lecturer.getUsername()%>/list_approve_request_open_course" class="nav-item nav-link active" style="font-size: 18px">หลักสูตรที่เปิดสอน</a>
                    <a href="${pageContext.request.contextPath}/view_activity" class="nav-item nav-link" style="font-size: 18px">ข่าวสารและกิจกรรม</a>
                    <a href="${pageContext.request.contextPath}/doLogout" class="nav-item nav-link" style="font-size: 18px">ออกจากระบบ</a>
                </div>
            </div>
        </nav>
        <!-- Navbar End -->
        <c:set var="colorBar" value="#fbc44f"/>
        <div align="center" style="width: 100%; margin-top: 20px">
            <div align="left" style="width: 85%">
                    <%--                <h2>${request_name.course.name}</h2>--%>
                <div align="center" class="main_container">

                    <div class="course_div" style="align-self: flex-start;">
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
                            <form action="${pageContext.request.contextPath}/lecturer/<%=lecturer.getUsername()%>/list_approve_request_open_course" method="get">
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
                                    <input type="hidden" name="fromPage" value="กำลังเรียน">
                                    <button class="btn btn-outline-dark" style="width: 90%;border-radius: 10px;">ย้อนกลับ</button>
                                </c:if>
                                <c:if test="${request_name.requestStatus == 'เสร็จสิ้น'}">
                                    <input type="hidden" name="fromPage" value="หลักสูตรที่เสร็จสิ้นการเรียน">
                                    <button class="btn btn-outline-dark" style="width: 90%;border-radius: 10px;">ย้อนกลับ</button>
                                </c:if>
                            </form>
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
                                    <thead style="background-color: ${colorBar};">
                                        <tr style="color: black">
                                            <td style="width: 5%"><b style="font-size: 14px;"></b></td>
                                            <td style="width: 25%"><b style="font-size: 14px;">รหัสบัตรประชาชน</b></td>
                                            <td style="width: 30%" align="center"><b style="font-size: 14px;">ชื่อ - นามสกุล</b></td>
                                            <td style="width: 15%" align="center"><b style="font-size: 14px;">วันที่สมัคร</b></td>
                                            <td style="width: 20%" align="center"><b style="font-size: 14px;">สถานะการสมัคร</b></td>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%--                            <c:forEach var="list" items="${registers}">--%>
                                    <c:choose>
                                        <c:when test="${all_register.size() == 0}">
                                            <tr>
                                                <td colspan="5" align="center">ไม่มีข้อมูล</td>
                                            </tr>
                                        </c:when>
                                        <c:otherwise>
                                            <c:set var="count" value="1" />
                                            <c:forEach items="${all_register}" var="list" >
                                                <tr>
                                                        <%--                                        <c:set var="count" value="${startIndex + 1}"/>--%>
                                                    <td align="center">${count}</td>
                                                    <td>${list.member.idcard}</td>
                                                    <td align="center">${list.member.firstName} ${list.member.lastName}</td>
                                                    <fmt:formatDate value="${list.register_date}" pattern="dd/MM/yyyy" var="date" />
                                                    <td align="center">${date}</td>
                                                    <td align="center" style="font-size: 14px">
                                                        <c:choose>
                                                            <c:when test="${request_name.course.fee == 0}">
                                                                <i class='fas fa-clock'></i>
                                                                <b>รอเรียน</b>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <i class='fa fa-minus-circle'></i>
                                                                <b>รอชำระเงิน</b>
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
                                    <thead style="background-color: ${colorBar};">
                                        <tr style="color: black">
                                            <td style="width: 5%"><b style="font-size: 14px;"></b></td>
                                            <td style="width: 20%"><b style="font-size: 14px;">รหัสบัตรประชาชน</b></td>
                                            <td style="width: 20%"><b style="font-size: 14px;">ชื่อ - นามสกุล</b></td>
                                            <td style="width: 10%" align="center"><b style="font-size: 14px;">วันที่สมัคร</b></td>
<%--                                            <td style="width: 15%" align="center"><b style="font-size: 14px;">วันที่ชำระเงิน</b></td>--%>
                                            <td style="width: 20%" align="center"><b style="font-size: 14px;">เบอร์โทรศัพท์</b></td>
                                            <td style="width: 20%" align="center"><b style="font-size: 14px;">สถานะการสมัคร</b></td>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    <c:choose>
                                        <c:when test="${all_register.size() == 0}">
                                            <tr>
                                                <td colspan="6" align="center">ยังไม่มีผู้ลงทะเบียน</td>
                                            </tr>
                                        </c:when>
                                        <c:otherwise>
                                            <c:set var="count" value="0"/>
                                            <c:set var="count1" value="1" />
                                            <c:forEach var="register" items="${all_register}">
                                                <fmt:formatDate value="${register.register_date}" pattern="dd/MM/yyyy" var="register_date" />
                                                <tr style="color: black">
                                                    <td align="center">${count1}</td>
                                                    <td><p>${register.member.idcard}</p></td>
                                                    <td><p>${register.member.firstName} ${register.member.lastName}</p></td>
                                                    <td align="center">
                                                        <p>${register_date}</p>
                                                    </td>
<%--                                                    <c:choose>--%>
<%--                                                        <c:when test="${register.requestOpenCourse.course.fee == 0}">--%>
<%--                                                            <td>ไม่มีค่าธรรมเนียม(ฟรี)</td>--%>
<%--                                                        </c:when>--%>
<%--                                                        <c:otherwise>--%>
<%--                                                            <c:set value="0" var="count"/>--%>
<%--                                                            <c:forEach var="receipts" items="${receipt}">--%>
<%--                                                                <fmt:formatDate value="${receipts.pay_date}" pattern="dd/MM/yyyy" var="pay_date" />--%>
<%--                                                                <c:if test="${register.invoice.invoice_id == receipts.invoice.invoice_id}">--%>
<%--                                                                    <td align="center">${pay_date} ${receipts.pay_time} น.</td>--%>
<%--                                                                    <c:set var="count" value="${count +1}"/>--%>
<%--                                                                </c:if>--%>
<%--                                                            </c:forEach>--%>
<%--                                                            <c:if test="${count == 0}">--%>
<%--                                                                <td align="center">ยังไม่มีการชำระเงิน</td>--%>
<%--                                                            </c:if>--%>
<%--                                                        </c:otherwise>--%>
<%--                                                    </c:choose>--%>
                                                    <td align="center">${register.member.tel}</td>
                                                    <c:choose>
                                                        <c:when test="${register.requestOpenCourse.course.fee == 0}">
                                                            <td align="center">รอเรียน</td>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <c:if test="${register.invoice.approve_status == 'ผ่าน'}">
                                                                <td align="center" style="color: green; font-size: 14px">
                                                                    <i class='fa fa-check-circle' style='color:#008f11'></i>
                                                                    <b> ผ่าน</b>
                                                                </td>
                                                            </c:if>
                                                            <c:if test="${register.invoice.approve_status == 'ไม่ผ่าน'}">
                                                                <td align="center" style="color: red;font-size: 14px">
                                                                    <i class='fa fa-times-circle' style='color: red'></i>
                                                                    <b>ไม่ผ่าน</b>
                                                                </td>
                                                            </c:if>
                                                            <c:if test="${register.invoice.approve_status == 'รอดำเนินการ'}">
                                                                <td align="center" style="color: orange;font-size: 14px">
                                                                    <i class='fa fa-minus-circle'></i>
                                                                    <b>รอดำเนินการ</b>
                                                                </td>
                                                            </c:if>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </tr>
                                                <c:set var="count" value="${count + 1}"/>
                                                <c:set var="count1" value="${count1+1}" />
                                            </c:forEach>
                                            <c:if test="${count == 0}">
                                                <tr>
                                                    <td style="font-size: 12px;" align="center">ไม่มีข้อมูล</td>
                                                </tr>
                                            </c:if>
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
                                            <div><h4>${request_name.numberOfAllRegistrationsToPass} / ${request_name.registerList.size()}</h4></div>
                                        </div>
                                    </div>
                                </div>
                                <hr>
                                <div id="all_payment" style="display: block">
                                    <table class="table table-hover" style="width: 100%; align-self: flex-start;">
                                        <thead style="background-color: ${colorBar};">
                                            <tr style="color: black">
                                                <td style="width: 5%"><b style="font-size: 14px;"></b></td>
                                                <td style="width: 20%"><b style="font-size: 14px;">รหัสบัตรประชาชน</b></td>
                                                <td style="width: 20%"><b style="font-size: 14px;">ชื่อ - นามสกุล</b></td>
<%--                                                <td style="width: 20%" align="center"><b style="font-size: 14px;">วันเวลาในการชำระเงิน</b></td>--%>
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
                                                <c:set var="count1" value="1" />
                                                <c:forEach var="register" items="${all_register}">
                                                    <tr style="color: black">
                                                        <td align="center">${count1}</td>
                                                        <td><p>${register.member.idcard}</p></td>
                                                        <td><p>${register.member.firstName} ${register.member.lastName}</p></td>

<%--                                                        <c:choose>--%>
<%--                                                            <c:when test="${request_name.course.fee == 0}">--%>
<%--                                                                <td align="center">ไม่มีค่าธรรมเนียม(ฟรี)</td>--%>
<%--                                                            </c:when>--%>
<%--                                                            <c:otherwise>--%>
<%--                                                                <c:set value="0" var="count"/>--%>
<%--                                                                <c:forEach var="receipts" items="${receipt}">--%>
<%--                                                                    <fmt:formatDate value="${receipts.pay_date}" pattern="dd/MM/yyyy" var="pay_date" />--%>
<%--                                                                    <c:if test="${register.invoice.invoice_id == receipts.invoice.invoice_id}">--%>
<%--                                                                        <td align="center">${pay_date} ${receipts.pay_time} น.</td>--%>
<%--                                                                        <c:set var="count" value="${count +1}"/>--%>
<%--                                                                    </c:if>--%>
<%--                                                                </c:forEach>--%>
<%--                                                                <c:if test="${count == 0}">--%>
<%--                                                                    <td align="center">ยังไม่มีการชำระเงิน</td>--%>
<%--                                                                </c:if>--%>
<%--                                                            </c:otherwise>--%>
<%--                                                        </c:choose>--%>
                                                        <td align="center">${register.member.tel}</td>
                                                        <c:choose>
                                                            <c:when test="${register.invoice.approve_status == 'ผ่าน'}">
                                                                <td align="center" style="color: green; font-size: 14px">
                                                                    <i class='fa fa-check-circle' style='color:#008f11'></i>
                                                                    <b> ผ่าน</b>
                                                                </td>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <td align="center" style="color: orange;font-size: 14px">
                                                                    <i class='fa fa-minus-circle'></i>
                                                                    <b>รอดำเนินการ</b>
                                                                </td>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </tr>
                                                    <c:set var="count1" value="${count1+1}" />
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
                                            <div><h4>${request_name.numberOfAllRegistrationsToPass} / ${request_name.registerList.size()}</h4></div>
                                        </div>
                                    </div>
                                </div>
                                <hr>
                                <div id="all_payment_app" style="display: block">
                                    <table class="table table-hover" style="width: 100%; align-self: flex-start;">
                                        <thead style="background-color: ${colorBar};">
                                            <tr style="color: black">
                                                <td style="width: 5%"><b style="font-size: 14px;"></b></td>
                                                <td style="width: 20%"><b style="font-size: 14px;">รหัสบัตรประชาชน</b></td>
                                                <td style="width: 20%"><b style="font-size: 14px;">ชื่อ - นามสกุล</b></td>
<%--                                                <td style="width: 20%" align="center"><b style="font-size: 14px;">วันเวลาในการชำระเงิน</b></td>--%>
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
                                                <c:set var="count1" value="1" />
                                                <c:forEach var="register" items="${all_register}">
                                                    <%--                                                <c:if test="${registers.invoice.pay_status == true || registers.invoice.approve_status == 'ไม่ผ่าน'}">--%>
                                                    <tr style="color: black">
                                                        <td align="center">${count1}</td>
                                                        <td><p>${register.member.idcard}</p></td>
                                                        <td><p>${register.member.firstName} ${register.member.lastName}</p></td>
<%--                                                        <c:choose>--%>
<%--                                                            <c:when test="${register.requestOpenCourse.course.fee == 0}">--%>
<%--                                                                <td align="center"><p>ไม่มีค่าธรรมเนียม(ฟรี)</p></td>--%>
<%--                                                            </c:when>--%>
<%--                                                            <c:otherwise>--%>
<%--                                                                <c:set value="0" var="count"/>--%>
<%--                                                                <c:forEach var="receipts" items="${receipt}">--%>
<%--                                                                    <fmt:formatDate value="${receipts.pay_date}" pattern="dd/MM/yyyy" var="pay_date" />--%>
<%--                                                                    <c:if test="${register.invoice.invoice_id == receipts.invoice.invoice_id}">--%>
<%--                                                                        <td align="center">${pay_date} ${receipts.pay_time} น.</td>--%>
<%--                                                                        <c:set var="count" value="${count +1}"/>--%>
<%--                                                                    </c:if>--%>
<%--                                                                </c:forEach>--%>
<%--                                                                <c:if test="${count == 0}">--%>
<%--                                                                    <td align="center">ยังไม่มีการชำระเงิน</td>--%>
<%--                                                                </c:if>--%>
<%--                                                            </c:otherwise>--%>
<%--                                                        </c:choose>--%>
                                                        <td align="center">${register.member.tel}</td>
                                                        <c:if test="${register.invoice.approve_status == 'ผ่าน'}">
                                                            <td align="center" style="color: green; font-size: 14px">
                                                                <i class='fa fa-check-circle' style='color:#008f11'></i>
                                                                <b> ผ่าน</b>
                                                            </td>
                                                        </c:if>
                                                        <c:if test="${register.invoice.approve_status == 'ไม่ผ่าน'}">
                                                            <td align="center" style="color: red;font-size: 14px">
                                                                <i class='fa fa-times-circle' style='color: red'></i>
                                                                <b>ไม่ผ่าน</b>
                                                            </td>
                                                        </c:if>
                                                        <c:if test="${register.invoice.approve_status == 'รอดำเนินการ'}">
                                                            <td align="center" style="color: orange;font-size: 14px">
                                                                <i class='fa fa-minus-circle'></i>
                                                                <b>รอดำเนินการ</b>
                                                            </td>
                                                        </c:if>
                                                    </tr>
                                                    <%--                                                </c:if>--%>
                                                    <c:set var="count1" value="${count1+1}" />
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
                                <thead style="background-color: ${colorBar};">
                                    <tr style="color: black">
                                        <td style="width: 5%"></td>
                                        <td style="width: 25%"><b style="font-size: 14px;">รหัสบัตรประชาชน</b></td>
                                        <td style="width: 25%" align="center"><b style="font-size: 14px;">ชื่อ - นามสกุล</b></td>
                                        <td style="width: 25%" align="center"><b style="font-size: 14px;">เบอร์โทรศัพท์</b></td>
                                        <td style="width: 20%" align="center"><b style="font-size: 14px;">สถานะการอบรม</b></td>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%--                            <c:forEach var="list" items="${registers}">--%>
                                <c:set var="count" value="1" />
                                <c:forEach items="${all_register}" var="list" >
                                        <form action="${pageContext.request.contextPath}/lecturer/${request_id}/update_Status_Member_Result/${list.register_id}" method="POST">
                                            <tr>
                                                    <%--                                        <c:set var="count" value="${startIndex + 1}"/>--%>
                                                <td align="center">${count}</td>
                                                <td>${list.member.idcard}</td>
                                                <td align="center">${list.member.firstName} ${list.member.lastName}</td>
                                                <td align="center">${list.member.tel}</td>
                                                <td align="center" style="font-size: 14px;">
                                                    <c:choose>
                                                        <c:when test="${currentDate >= request_name.startStudyDate}">
                                                            <i class='fas fa-book-reader' style="color: orange"></i>
                                                            <b style="color: orange">กำลังเรียน</b>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <i class='fas fa-clock'></i>
                                                            <b>รอถึงวันเรียน</b>
                                                        </c:otherwise>
                                                    </c:choose>

                                                </td align="center">
                                            </tr>
                                        </form>
                                        <c:set var="count" value="${count+1}" />
                                </c:forEach>
                                </tbody>
                            </table>
                        </c:if>

                        <c:if test="${request_name.requestStatus == 'เสร็จสิ้น'}">
                            <div style="display: flex; width: 100%" >
                                <div align="left" style="width: 50%"><h3>รายชื่อผู้สมัคร (เสร็จสิ้นการเรียนการสอน)</h3></div>
                                <div align="right" style="width: 50%;">
                                    <div style="display:flex; width: 180px">
                                        <div style="margin-right: 10px"><i class="fa fa-users fa-2x"></i></div>
                                        <div><h4>${request_name.numberOfAllRegistrationsByStudyResultCheckPF} / ${request_name.numberOfAllRegistrationsToPass}</h4></div>
                                    </div>
                                </div>
                            </div>
                            <hr>
                            <div style="display: flex; width: 100%" >
                                <div align="left" style="width: 50%"></div>
                                <div align="right" style="width: 50%">

                                    <button style="border-radius: 15px" onclick="window.location.href='${pageContext.request.contextPath}/lecturer/${request_id}/downloadExcel';" class="btn btn-outline-primary">
                                        <i class='fa fa-download'></i> รายชื่อผู้เรียน
                                    </button>
<%--                                    <input type="button" value="ดาวน์โหลดรายชื่อ"--%>
<%--                                           onclick="window.location.href='${pageContext.request.contextPath}/lecturer/${request_id}/downloadExcel'; return false;"--%>
<%--                                           class="btn btn-outline-primary"/>--%>
                                </div>
                            </div><br>
<%--                            <div style="width: 100%" align="center">--%>
<%--                                <div class="wrapper">--%>
<%--                                    <input type="radio" name="select" id="option-1" checked>--%>
<%--                                    <input type="radio" name="select" id="option-2">--%>
<%--                                    <input type="radio" name="select" id="option-3">--%>
<%--                                    <label for="option-1" class="option option-1">--%>
<%--                                        <div class="dot"></div>--%>
<%--                                        <span>ยังไม่ได้ประเมิน (${request_name.numberOfAllRegistrationsByStudyResultToNotPassNotFalse}/${request_name.numberOfAllRegistrationsToPass})</span>--%>
<%--                                    </label>--%>
<%--                                    <label for="option-2" class="option option-2">--%>
<%--                                        <div class="dot"></div>--%>
<%--                                        <span>ผ่านการประเมิน (${request_name.numberOfAllRegistrationsByStudyResult}/${request_name.numberOfAllRegistrationsToPass})</span>--%>
<%--                                    </label>--%>
<%--                                    <label for="option-3" class="option option-3">--%>
<%--                                        <div class="dot"></div>--%>
<%--                                        <span>ไม่ผ่านการประเมิน (${request_name.numberOfAllRegistrationsByStudyResultToFalse}/${request_name.numberOfAllRegistrationsToPass})</span>--%>
<%--                                    </label>--%>
<%--                                </div>--%>
<%--                            </div>--%>

                            <div id="not_edit_status">
                                <form action="${pageContext.request.contextPath}/lecturer/${request_id}/update_Status_Member_Result" method="POST" id="updateForm">
                                    <table class="table table-hover" style="width: 100%; align-self: flex-start;">
                                        <thead style="background-color: ${colorBar};">
                                        <tr style="color: black">
                                            <td style="width: 5%" align="center">
                                                <input type="checkbox" id="selectAll">
                                            </td>
                                            <td style="width: 5%"></td>
                                            <td style="width: 20%"><b style="font-size: 14px;">รหัสบัตรประชาชน</b></td>
                                            <td style="width: 25%" align="center"><b style="font-size: 14px;">ชื่อ - นามสกุล</b></td>
                                            <td style="width: 15%" align="center"><b style="font-size: 14px;">เบอร์โทรศัพท์</b></td>
                                            <td style="width: 15%" align="center"><b style="font-size: 14px;">สถานะการอบรม</b></td>
                                        </tr>
                                        </thead>
                                        <tbody>
                                            <%--                            <c:forEach var="list" items="${registers}">--%>
                                        <c:set var="count" value="1" />
                                        <c:set var="count1" value="0" />
                                        <c:forEach items="${all_register}" var="list" >
                                                <tr>
                                                        <%--                                        <c:set var="count" value="${startIndex + 1}"/>--%>
                                                    <td align="center">
                                                        <input type="checkbox" name="registerIds" value="${list.register_id}">
                                                    </td>
                                                    <td align="center">${count}</td>
                                                    <td>${list.member.idcard}</td>
                                                    <td align="center">${list.member.firstName} ${list.member.lastName}</td>
                                                    <td align="center">${list.member.tel}</td>
                                                    <td align="center" style="font-size: 14px">
                                                        <c:set var="color" value="orange"></c:set>
                                                        <c:set var="fa" value="fa fa-check-circle"></c:set>
                                                        <c:if test="${list.study_result == 'ผ่าน'}">
                                                            <c:set var="color" value="green"></c:set>
                                                            <c:set var="fa" value="fa fa-check-circle"></c:set>
                                                        </c:if>
                                                        <c:if test="${list.study_result == 'ไม่ผ่าน'}">
                                                            <c:set var="color" value="red"></c:set>
                                                            <c:set var="fa" value="fa fa-times-circle"></c:set>
                                                        </c:if>
                                                        <c:choose>
                                                            <c:when test="${currentDate >= request_name.startStudyDate}">
                                                                <c:choose>
                                                                    <c:when test="${list.study_result == 'กำลังเรียน'}">
                                                                        <i class='fa fa-minus-circle' style="color: ${color}"></i>
                                                                        <b style="color: ${color}">รอประเมิน</b>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <i class='${fa}' style="color: ${color}"></i>
                                                                        <b style="color: ${color}">${list.study_result}</b>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <i class='fas fa-clock'></i>
                                                                <b>รอถึงวันเรียน</b>
                                                            </c:otherwise>
                                                        </c:choose>

                                                    </td align="center">
                                                        <%--                <td>--%>
                                                        <%--                    ${list.invoice.pay_status}--%>
                                                        <%--                </td>--%>

                                                </tr>
                                                <c:set var="count" value="${count+1}" />
                                                <c:set var="count1" value="${count1+1}" />
                                        </c:forEach>
                                        <c:if test="${count1 == 0}">
                                            <tr>
                                                <td colspan="7" align="center">ไม่มีข้อมูล</td>
                                            </tr>
                                        </c:if>
                                        </tbody>
                                    </table>
                                    <c:if test="${count1 != 0}">
                                        <div style="width: 100%" align="center">
                                            <input type="submit" style="width: 49%; font-size: 14px;" name="studyResult" class="btn btn-danger" value="ไม่ผ่านหลักสูตร" onclick="updateStatus()"/>
                                            <input type="submit" style="width: 49%; font-size: 14px;" name="studyResult" class="btn btn-success" value="ผ่านหลักสูตร" onclick="updateStatus()"/>
                                        </div>

                                    </c:if>

                                </form>
                            </div>



<%--                            <div id="not_edit_status">--%>
<%--                                <form action="${pageContext.request.contextPath}/lecturer/${request_id}/update_Status_Member_Result" method="POST" id="updateForm">--%>
<%--                                    <table class="table table-hover" style="width: 100%; align-self: flex-start;">--%>
<%--                                        <thead style="background-color: ${colorBar};">--%>
<%--                                        <tr style="color: black">--%>
<%--                                            <td style="width: 5%" align="center">--%>
<%--                                                <input type="checkbox" id="selectAll">--%>
<%--                                            </td>--%>
<%--                                            <td style="width: 5%"></td>--%>
<%--                                            <td style="width: 20%"><b style="font-size: 14px;">รหัสบัตรประชาชน</b></td>--%>
<%--                                            <td style="width: 25%" align="center"><b style="font-size: 14px;">ชื่อ - นามสกุล</b></td>--%>
<%--                                            <td style="width: 15%" align="center"><b style="font-size: 14px;">เบอร์โทรศัพท์</b></td>--%>
<%--                                            <td style="width: 15%" align="center"><b style="font-size: 14px;">สถานะการอบรม</b></td>--%>
<%--                                        </tr>--%>
<%--                                        </thead>--%>
<%--                                        <tbody>--%>
<%--                                            &lt;%&ndash;                            <c:forEach var="list" items="${registers}">&ndash;%&gt;--%>
<%--                                        <c:set var="count" value="1" />--%>
<%--                                        <c:set var="count1" value="0" />--%>
<%--                                        <c:forEach items="${all_register}" var="list" >--%>
<%--                                            <c:if test="${list.study_result == 'กำลังเรียน'}">--%>
<%--                                                    <tr>--%>
<%--                                                            &lt;%&ndash;                                        <c:set var="count" value="${startIndex + 1}"/>&ndash;%&gt;--%>
<%--                                                        <td align="center">--%>
<%--                                                            <input type="checkbox" name="registerIds" value="${list.register_id}">--%>
<%--                                                        </td>--%>
<%--                                                        <td align="center">${count}</td>--%>
<%--                                                        <td>${list.member.idcard}</td>--%>
<%--                                                        <td align="center">${list.member.firstName} ${list.member.lastName}</td>--%>
<%--                                                        <td align="center">${list.member.tel}</td>--%>
<%--                                                        <td align="center" style="font-size: 14px">--%>
<%--                                                            <c:set var="color" value="orange"></c:set>--%>
<%--                                                            <c:set var="fa" value="fa fa-check-circle"></c:set>--%>
<%--                                                            <c:if test="${list.study_result == 'ผ่าน'}">--%>
<%--                                                                <c:set var="color" value="green"></c:set>--%>
<%--                                                                <c:set var="fa" value="fa fa-check-circle"></c:set>--%>
<%--                                                            </c:if>--%>
<%--                                                            <c:if test="${list.study_result == 'ไม่ผ่าน'}">--%>
<%--                                                                <c:set var="color" value="red"></c:set>--%>
<%--                                                                <c:set var="fa" value="fa fa-times-circle"></c:set>--%>
<%--                                                            </c:if>--%>
<%--                                                            <c:choose>--%>
<%--                                                                <c:when test="${currentDate >= request_name.startStudyDate}">--%>
<%--                                                                    <c:choose>--%>
<%--                                                                        <c:when test="${list.study_result == 'กำลังเรียน'}">--%>
<%--                                                                            <i class='fa fa-minus-circle' style="color: ${color}"></i>--%>
<%--                                                                            <b style="color: ${color}">รอประเมิน</b>--%>
<%--                                                                        </c:when>--%>
<%--                                                                        <c:otherwise>--%>
<%--                                                                            <i class='${fa}' style="color: ${color}"></i>--%>
<%--                                                                            <b style="color: ${color}">${list.study_result}</b>--%>
<%--                                                                        </c:otherwise>--%>
<%--                                                                    </c:choose>--%>
<%--                                                                </c:when>--%>
<%--                                                                <c:otherwise>--%>
<%--                                                                    <i class='fas fa-clock'></i>--%>
<%--                                                                    <b>รอถึงวันเรียน</b>--%>
<%--                                                                </c:otherwise>--%>
<%--                                                            </c:choose>--%>

<%--                                                        </td align="center">--%>
<%--                                                            &lt;%&ndash;                <td>&ndash;%&gt;--%>
<%--                                                            &lt;%&ndash;                    ${list.invoice.pay_status}&ndash;%&gt;--%>
<%--                                                            &lt;%&ndash;                </td>&ndash;%&gt;--%>

<%--                                                    </tr>--%>
<%--                                                <c:set var="count" value="${count+1}" />--%>
<%--                                                <c:set var="count1" value="${count1+1}" />--%>
<%--                                            </c:if>--%>
<%--                                        </c:forEach>--%>
<%--                                        <c:if test="${count1 == 0}">--%>
<%--                                            <tr>--%>
<%--                                                <td colspan="7" align="center">ไม่มีข้อมูล</td>--%>
<%--                                            </tr>--%>
<%--                                        </c:if>--%>
<%--                                        </tbody>--%>
<%--                                    </table>--%>
<%--                                    <c:if test="${count1 != 0}">--%>
<%--                                        <div style="width: 100%" align="center">--%>
<%--                                            <input type="submit" style="width: 49%; font-size: 14px;" name="studyResult" class="btn btn-danger" value="ไม่ผ่านหลักสูตร" onclick="updateStatus()"/>--%>
<%--                                            <input type="submit" style="width: 49%; font-size: 14px;" name="studyResult" class="btn btn-success" value="ผ่านหลักสูตร" onclick="updateStatus()"/>--%>
<%--                                        </div>--%>

<%--                                    </c:if>--%>

<%--                                </form>--%>
<%--                            </div>--%>
<%--                            <div id="pass_status" style="display: none">--%>
<%--                                <form action="${pageContext.request.contextPath}/lecturer/${request_id}/update_Status_Member_Result" method="POST" id="updateForm2">--%>
<%--                                    <table class="table table-hover" style="width: 100%; align-self: flex-start;">--%>
<%--                                        <thead style="background-color: ${colorBar};">--%>
<%--                                        <tr style="color: black">--%>
<%--                                            <td style="width: 5%" align="center">--%>
<%--                                                <input type="checkbox" id="selectAll2">--%>
<%--                                            </td>--%>
<%--                                            <td style="width: 5%"></td>--%>
<%--                                            <td style="width: 20%"><b style="font-size: 14px;">รหัสบัตรประชาชน</b></td>--%>
<%--                                            <td style="width: 25%" align="center"><b style="font-size: 14px;">ชื่อ - นามสกุล</b></td>--%>
<%--                                            <td style="width: 15%" align="center"><b style="font-size: 14px;">เบอร์โทรศัพท์</b></td>--%>
<%--                                            <td style="width: 15%" align="center"><b style="font-size: 14px;">สถานะการอบรม</b></td>--%>
<%--                                        </tr>--%>
<%--                                        </thead>--%>
<%--                                        <tbody>--%>
<%--                                            &lt;%&ndash;                            <c:forEach var="list" items="${registers}">&ndash;%&gt;--%>
<%--                                        <c:set var="count" value="1" />--%>
<%--                                        <c:set var="count1" value="0" />--%>
<%--                                        <c:forEach items="${all_register}" var="list" >--%>
<%--                                            <c:if test="${list.study_result == 'ผ่าน'}">--%>
<%--                                                <tr>--%>
<%--                                                        &lt;%&ndash;                                        <c:set var="count" value="${startIndex + 1}"/>&ndash;%&gt;--%>
<%--                                                    <td align="center">--%>
<%--                                                        <input type="checkbox" name="registerIds" value="${list.register_id}">--%>
<%--                                                    </td>--%>
<%--                                                    <td align="center">${count}</td>--%>
<%--                                                    <td>${list.member.idcard}</td>--%>
<%--                                                    <td align="center">${list.member.firstName} ${list.member.lastName}</td>--%>
<%--                                                    <td align="center">${list.member.tel}</td>--%>
<%--                                                            <td align="center" style="font-size: 14px">--%>
<%--                                                                <c:set var="color" value="orange"></c:set>--%>
<%--                                                                <c:set var="fa" value="fa fa-check-circle"></c:set>--%>
<%--                                                                <c:if test="${list.study_result == 'ผ่าน'}">--%>
<%--                                                                    <c:set var="color" value="green"></c:set>--%>
<%--                                                                    <c:set var="fa" value="fa fa-check-circle"></c:set>--%>
<%--                                                                </c:if>--%>
<%--                                                                <c:if test="${list.study_result == 'ไม่ผ่าน'}">--%>
<%--                                                                    <c:set var="color" value="red"></c:set>--%>
<%--                                                                    <c:set var="fa" value="fa fa-times-circle"></c:set>--%>
<%--                                                                </c:if>--%>
<%--                                                                <c:choose>--%>
<%--                                                                    <c:when test="${currentDate >= request_name.startStudyDate}">--%>
<%--                                                                        <c:choose>--%>
<%--                                                                            <c:when test="${list.study_result == 'กำลังเรียน'}">--%>
<%--                                                                                <i class='fa fa-minus-circle' style="color: ${color}"></i>--%>
<%--                                                                                <b style="color: ${color}">รอประเมิน</b>--%>
<%--                                                                            </c:when>--%>
<%--                                                                            <c:otherwise>--%>
<%--                                                                                <i class='${fa}' style="color: ${color}"></i>--%>
<%--                                                                                <b style="color: ${color}">${list.study_result}</b>--%>
<%--                                                                            </c:otherwise>--%>
<%--                                                                        </c:choose>--%>
<%--                                                                    </c:when>--%>
<%--                                                                    <c:otherwise>--%>
<%--                                                                        <i class='fas fa-clock'></i>--%>
<%--                                                                        <b>รอถึงวันเรียน</b>--%>
<%--                                                                    </c:otherwise>--%>
<%--                                                                </c:choose>--%>

<%--                                                            </td align="center">--%>
<%--                                                        &lt;%&ndash;                <td>&ndash;%&gt;--%>
<%--                                                        &lt;%&ndash;                    ${list.invoice.pay_status}&ndash;%&gt;--%>
<%--                                                        &lt;%&ndash;                </td>&ndash;%&gt;--%>

<%--                                                </tr>--%>
<%--                                                <c:set var="count" value="${count+1}" />--%>
<%--                                                <c:set var="count1" value="${count1+1}" />--%>
<%--                                            </c:if>--%>
<%--                                        </c:forEach>--%>
<%--                                        <c:if test="${count1 == 0}">--%>
<%--                                            <tr>--%>
<%--                                                <td colspan="7" align="center">ไม่มีข้อมูล</td>--%>
<%--                                            </tr>--%>
<%--                                        </c:if>--%>
<%--                                        </tbody>--%>
<%--                                    </table>--%>
<%--                                    <c:if test="${count1 != 0}">--%>
<%--                                        <div style="width: 100%" align="center">--%>
<%--                                            <input type="submit" style="width: 49%; font-size: 14px;" name="studyResult" class="btn btn-danger" value="ไม่ผ่านหลักสูตร" onclick="updateStatusToFalse()"/>--%>
<%--                                        </div>--%>

<%--                                    </c:if>--%>

<%--                                </form>--%>
<%--                            </div>--%>
<%--                            <div id="false_status" style="display: none">--%>
<%--                                <form action="${pageContext.request.contextPath}/lecturer/${request_id}/update_Status_Member_Result" method="POST" id="updateForm3">--%>
<%--                                    <table class="table table-hover" style="width: 100%; align-self: flex-start;">--%>
<%--                                        <thead style="background-color: ${colorBar};">--%>
<%--                                        <tr style="color: black">--%>
<%--                                            <td style="width: 5%" align="center">--%>
<%--                                                <input type="checkbox" id="selectAll3">--%>
<%--                                            </td>--%>
<%--                                            <td style="width: 5%"></td>--%>
<%--                                            <td style="width: 20%"><b style="font-size: 14px;">รหัสบัตรประชาชน</b></td>--%>
<%--                                            <td style="width: 25%" align="center"><b style="font-size: 14px;">ชื่อ - นามสกุล</b></td>--%>
<%--                                            <td style="width: 15%" align="center"><b style="font-size: 14px;">เบอร์โทรศัพท์</b></td>--%>
<%--                                            <td style="width: 15%" align="center"><b style="font-size: 14px;">สถานะการอบรม</b></td>--%>
<%--                                        </tr>--%>
<%--                                        </thead>--%>
<%--                                        <tbody>--%>
<%--                                            &lt;%&ndash;                            <c:forEach var="list" items="${registers}">&ndash;%&gt;--%>
<%--                                        <c:set var="count" value="1" />--%>
<%--                                        <c:set var="count1" value="0" />--%>
<%--                                        <c:forEach items="${all_register}" var="list" >--%>
<%--                                            <c:if test="${list.study_result == 'ไม่ผ่าน'}">--%>
<%--                                                <tr>--%>
<%--                                                        &lt;%&ndash;                                        <c:set var="count" value="${startIndex + 1}"/>&ndash;%&gt;--%>
<%--                                                    <td align="center">--%>
<%--                                                        <input type="checkbox" name="registerIds" value="${list.register_id}">--%>
<%--                                                    </td>--%>
<%--                                                    <td align="center">${count}</td>--%>
<%--                                                    <td>${list.member.idcard}</td>--%>
<%--                                                    <td align="center">${list.member.firstName} ${list.member.lastName}</td>--%>
<%--                                                    <td align="center">${list.member.tel}</td>--%>
<%--                                                            <td align="center" style="font-size: 14px">--%>
<%--                                                                <c:set var="color" value="orange"></c:set>--%>
<%--                                                                <c:set var="fa" value="fa fa-check-circle"></c:set>--%>
<%--                                                                <c:if test="${list.study_result == 'ผ่าน'}">--%>
<%--                                                                    <c:set var="color" value="green"></c:set>--%>
<%--                                                                    <c:set var="fa" value="fa fa-check-circle"></c:set>--%>
<%--                                                                </c:if>--%>
<%--                                                                <c:if test="${list.study_result == 'ไม่ผ่าน'}">--%>
<%--                                                                    <c:set var="color" value="red"></c:set>--%>
<%--                                                                    <c:set var="fa" value="fa fa-times-circle"></c:set>--%>
<%--                                                                </c:if>--%>
<%--                                                                <c:choose>--%>
<%--                                                                    <c:when test="${currentDate >= request_name.startStudyDate}">--%>
<%--                                                                        <c:choose>--%>
<%--                                                                            <c:when test="${list.study_result == 'กำลังเรียน'}">--%>
<%--                                                                                <i class='fa fa-minus-circle'></i>--%>
<%--                                                                                <b style="color: ${color}">รอประเมิน</b>--%>
<%--                                                                            </c:when>--%>
<%--                                                                            <c:otherwise>--%>
<%--                                                                                <i class='${fa}' style="color: ${color}"></i>--%>
<%--                                                                                <b style="color: ${color}">${list.study_result}</b>--%>
<%--                                                                            </c:otherwise>--%>
<%--                                                                        </c:choose>--%>
<%--                                                                    </c:when>--%>
<%--                                                                    <c:otherwise>--%>
<%--                                                                        <i class='fas fa-clock'></i>--%>
<%--                                                                        <b>รอถึงวันเรียน</b>--%>
<%--                                                                    </c:otherwise>--%>
<%--                                                                </c:choose>--%>

<%--                                                            </td align="center">--%>
<%--                                                        &lt;%&ndash;                <td>&ndash;%&gt;--%>
<%--                                                        &lt;%&ndash;                    ${list.invoice.pay_status}&ndash;%&gt;--%>
<%--                                                        &lt;%&ndash;                </td>&ndash;%&gt;--%>

<%--                                                </tr>--%>
<%--                                                <c:set var="count" value="${count+1}" />--%>
<%--                                                <c:set var="count1" value="${count1+1}" />--%>
<%--                                            </c:if>--%>
<%--                                        </c:forEach>--%>
<%--                                        <c:if test="${count1 == 0}">--%>
<%--                                            <tr>--%>
<%--                                                <td colspan="7" align="center">ไม่มีข้อมูล</td>--%>
<%--                                            </tr>--%>
<%--                                        </c:if>--%>
<%--                                        </tbody>--%>
<%--                                    </table>--%>
<%--                                    <c:if test="${count1 != 0}">--%>
<%--                                        <div style="width: 100%" align="center">--%>
<%--                                            <input type="submit" style="width: 49%; font-size: 14px;" name="studyResult" class="btn btn-success" value="ผ่านหลักสูตร" onclick="updateStatusToPass()"/>--%>
<%--                                        </div>--%>

<%--                                    </c:if>--%>

<%--                                </form>--%>
<%--                            </div>--%>
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
    var notEditStatus = document.querySelector('input[name="select"][id="option-1"]');
    notEditStatus.addEventListener("change", function() {
        if (notEditStatus.checked) {
            document.getElementById("not_edit_status").style.display = "block";
            document.getElementById("pass_status").style.display = "none";
            document.getElementById("false_status").style.display = "none";
        }
    });
    var passStatus = document.querySelector('input[name="select"][id="option-2"]');
    passStatus.addEventListener("change", function() {
        if (passStatus.checked) {
            document.getElementById("not_edit_status").style.display = "none";
            document.getElementById("pass_status").style.display = "block";
            document.getElementById("false_status").style.display = "none";
        }
    });
    var falseStatus = document.querySelector('input[name="select"][id="option-3"]');
    falseStatus.addEventListener("change", function() {
        if (falseStatus.checked) {
            document.getElementById("not_edit_status").style.display = "none";
            document.getElementById("pass_status").style.display = "none";
            document.getElementById("false_status").style.display = "block";
        }
    });
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
<script>
    function updateStatus() {
        var form = document.getElementById("updateForm");
        var checkboxes = form.querySelectorAll('input[name="registerIds"]:checked');
        if (checkboxes.length > 0) {
            var result = confirm("คุณแน่ใจหรือไม่ว่าต้องการดำเนินการขั้นตอนต่อไปนี้?");
            if (result) {
                form.submit();
                return true; // ถ้าผู้ใช้กด OK ให้ทำงานตามปกติ
            } else {
                event.preventDefault();
                return false; // ถ้าผู้ใช้กด Cancel ให้ยกเลิกการส่งฟอร์ม
            }
        } else if (checkboxes.length <= 0){
            alert("กรุณาเลือกรายการที่ต้องการอัพเดทสถานะการเรียน?");
            event.preventDefault();
        }
    }
    function updateStatusToPass() {
        var form = document.getElementById("updateForm3");
        var checkboxes = form.querySelectorAll('input[name="registerIds"]:checked');
        if (checkboxes.length > 0) {
            var result = confirm("คุณแน่ใจหรือไม่ว่าต้องการดำเนินการขั้นตอนต่อไปนี้?");
            if (result) {
                form.submit();
                return true; // ถ้าผู้ใช้กด OK ให้ทำงานตามปกติ
            } else {
                event.preventDefault();
                return false; // ถ้าผู้ใช้กด Cancel ให้ยกเลิกการส่งฟอร์ม
            }
        } else if (checkboxes.length <= 0){
            alert("กรุณาเลือกรายการที่ต้องการอัพเดทสถานะการเรียน?");
            event.preventDefault();
        }
    }
    function updateStatusToFalse() {
        var form = document.getElementById("updateForm2");
        var checkboxes = form.querySelectorAll('input[name="registerIds"]:checked');
        if (checkboxes.length > 0) {
            var result = confirm("คุณแน่ใจหรือไม่ว่าต้องการดำเนินการขั้นตอนต่อไปนี้?");
            if (result) {
                form.submit();
                return true; // ถ้าผู้ใช้กด OK ให้ทำงานตามปกติ
            } else {
                event.preventDefault();
                return false; // ถ้าผู้ใช้กด Cancel ให้ยกเลิกการส่งฟอร์ม
            }
        } else if (checkboxes.length <= 0){
            alert("กรุณาเลือกรายการที่ต้องการอัพเดทสถานะการเรียน?");
            event.preventDefault();
        }
    }
</script>
<script>
    document.getElementById("selectAll").addEventListener("change", function() {
        var checkboxes = document.querySelectorAll('input[name="registerIds"]');
        for (var i = 0; i < checkboxes.length; i++) {
            checkboxes[i].checked = this.checked;
        }
    });
    document.getElementById("selectAll2").addEventListener("change", function() {
        var checkboxes = document.querySelectorAll('input[name="registerIds"]');
        for (var i = 0; i < checkboxes.length; i++) {
            checkboxes[i].checked = this.checked;
        }
    });
    document.getElementById("selectAll3").addEventListener("change", function() {
        var checkboxes = document.querySelectorAll('input[name="registerIds"]');
        for (var i = 0; i < checkboxes.length; i++) {
            checkboxes[i].checked = this.checked;
        }
    });
</script>
</html>
