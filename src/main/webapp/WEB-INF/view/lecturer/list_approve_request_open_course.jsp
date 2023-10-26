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
        table{
            font-size: 12px;
        }
        .button-35 {
            align-items: center;
            background-color: #fff;
            border-radius: 12px;
            box-shadow: transparent 0 0 0 3px,rgba(18, 18, 18, .1) 0 6px 20px;
            box-sizing: border-box;
            color: #121212;
            cursor: pointer;
            display: inline-flex;
            flex: 1 1 auto;
            justify-content: center;
            line-height: 1;
            margin: 0;
            outline: none;
            padding: 10px 10px 10px 10px;
            text-align: center;
            text-decoration: none;
            transition: box-shadow .2s,-webkit-box-shadow .2s;
            white-space: nowrap;
            border: 0;
            user-select: none;
            -webkit-user-select: none;
            touch-action: manipulation;
        }
        .button-35:hover {
            box-shadow: #121212 0 0 0 3px, transparent 0 0 0 0;
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
                                            <option value="กำลังเรียน">กำลังเรียน</option>
                                        </select>
                                    </td>
                                </tr>
                            </table>
                            <hr>
                            <div id="register_select" style="display: none">
                                <div style="width: 100%" align="center">
                                    <input type="radio" name="listDisplay" value="หลักสูตรทั้งหมด" checked>
                                    <label>หลักสูตรทั้งหมด</label>
                                    <input type="radio" name="listDisplay" value="หลักสูตรเปิดรับสมัคร">
                                    <label>หลักสูตรเปิดรับสมัคร</label>
                                    <input type="radio" name="listDisplay" value="หลักสูตรเปิดรับสมัคร/ชำระเงิน">
                                    <label>หลักสูตรเปิดรับสมัคร/ชำระเงิน</label>
                                    <input type="radio" name="listDisplay" value="หลักสูตรที่ชำระเงินเท่านั้น">
                                    <label>หลักสูตรที่ชำระเงินเท่านั้น</label>
                                        <%--                            <input type="radio" name="listDisplay" value="หลักสูตรที่สมัครครบแล้ว">--%>
                                        <%--                            <label>หลักสูตรที่สมัครครบแล้ว</label>--%>
                                    <input type="radio" name="listDisplay" value="รอประกาศผล">
                                    <label>รอประกาศผล</label>
                                </div>
                                <hr>

                                <div id="all_register" style="display: block">
                                    <table class="table table-striped table-hover">
                                        <tr style="color: black">
                                            <td style="width: 30%">ชื่อหลักสูตร</td>
                                            <td style="width: 16%" align="center">ระยะเวลาการลงทะเบียน</td>
                                            <td style="width: 15%" align="center">ระยะเวลาการชำระเงิน</td>
                                            <td style="width: 8%" align="center">วันประกาศผล</td>
                                            <td style="width: 15%" align="center">ระยะเวลาการเรียน</td>
                                            <td style="width: 10%" align="center">สถานะ</td>
                                            <td style="width: 10%" align="center">ผู้สมัคร</td>
                                        </tr>
                                        <c:choose>
                                            <c:when test="${courses_by_all_regis_pay_date.size() == 0}">
                                                <tr>
                                                    <td colspan="7" align="center">ไม่มีข้อมูล</td>
                                                </tr>
                                            </c:when>
                                            <c:otherwise>
                                                <c:forEach var="request" items="${courses_by_all_regis_pay_date}">
                                                    <tr style="color: black;">
                                                        <fmt:formatDate value="${request.requestDate}" pattern="dd/MM/yyyy" var="requestDate" />
                                                        <fmt:formatDate value="${request.startRegister}" pattern="dd/MM/yyyy" var="startRegister" />
                                                        <fmt:formatDate value="${request.endRegister}" pattern="dd/MM/yyyy" var="endRegister" />
                                                        <fmt:formatDate value="${request.startStudyDate}" pattern="dd/MM/yyyy" var="startStudyDate" />
                                                        <fmt:formatDate value="${request.endStudyDate}" pattern="dd/MM/yyyy" var="endStudyDate" />
                                                        <fmt:formatDate value="${request.startPayment}" pattern="dd/MM/yyyy" var="startPayment" />
                                                        <fmt:formatDate value="${request.endPayment}" pattern="dd/MM/yyyy" var="endPayment" />
                                                        <fmt:formatDate value="${request.applicationResult}" pattern="dd/MM/yyyy" var="applicationResult" />
                                                        <c:if test="${request.requestStatus == 'ผ่าน'}">
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
                                                            <td align="center"><a href="${pageContext.request.contextPath}/lecturer/${lecturer_id}/${request.request_id}/list_member_to_approve">
                                                                <button class="button-35" role="button"><i class="fa fa-users" style="margin-right: 10px"></i>
                                                                        ${request.numberOfAllRegistrations} / ${request.quantity}
                                                                </button>
                                                            </a></td>
                                                        </c:if>
                                                    </tr>
                                                </c:forEach>
                                            </c:otherwise>
                                        </c:choose>
                                    </table>
                                </div>
                                <div id="no_max_register" style="display: none">
                                    <table class="table table-striped table-hover">
                                        <tr style="color: black">
                                            <td style="width: 30%">ชื่อหลักสูตร</td>
                                            <td style="width: 12%" align="center">ระยะเวลาการลงทะเบียน</td>
                                            <td style="width: 12%" align="center">ระยะเวลาการชำระเงิน</td>
                                            <td style="width: 7%" align="center">วันประกาศผล</td>
                                            <td style="width: 12%" align="center">ระยะเวลาการเรียน</td>
                                            <td style="width: 9%" align="center">สถานะ</td>
                                            <td style="width: 10%" align="center">ผู้สมัคร</td>
                                            <td style="width: 10%" align="center"></td>
                                        </tr>
                                        <c:choose>
                                            <c:when test="${courses_by_register_date.size() == 0}">
                                                <tr>
                                                    <td colspan="8" align="center">ไม่มีข้อมูล</td>
                                                </tr>
                                            </c:when>
                                            <c:otherwise>
                                                <c:forEach var="request" items="${courses_by_register_date}">
                                                    <tr style="color: black;">
                                                        <c:if test="${request.quantity >= request.registerList.size()}">
                                                            <fmt:formatDate value="${request.requestDate}" pattern="dd/MM/yyyy" var="requestDate" />
                                                            <fmt:formatDate value="${request.startRegister}" pattern="dd/MM/yyyy" var="startRegister" />
                                                            <fmt:formatDate value="${request.endRegister}" pattern="dd/MM/yyyy" var="endRegister" />
                                                            <fmt:formatDate value="${request.startStudyDate}" pattern="dd/MM/yyyy" var="startStudyDate" />
                                                            <fmt:formatDate value="${request.endStudyDate}" pattern="dd/MM/yyyy" var="endStudyDate" />
                                                            <fmt:formatDate value="${request.startPayment}" pattern="dd/MM/yyyy" var="startPayment" />
                                                            <fmt:formatDate value="${request.endPayment}" pattern="dd/MM/yyyy" var="endPayment" />
                                                            <fmt:formatDate value="${request.applicationResult}" pattern="dd/MM/yyyy" var="applicationResult" />
                                                            <c:if test="${request.requestStatus == 'ผ่าน'}">
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
                                                                <td align="center"><a href="${pageContext.request.contextPath}/lecturer/${lecturer_id}/${request.request_id}/list_member_to_approve">
                                                                    <button class="button-35" role="button"><i class="fa fa-users" style="margin-right: 10px"></i>
                                                                            ${request.numberOfAllRegistrations} / ${request.quantity}
                                                                    </button>
                                                                </a></td>
                                                                <td align="center">
                                                                    <button type="button" style="font-size: 12px; border-radius: 12px;"
                                                                            onclick="if((confirm('คุณแน่ใจหรือว่าต้องการลบหลักสูตรที่ท่านกำลังเปิดนี้?'))) { window.location.href='${pageContext.request.contextPath}/lecturer/${lecturer_id}/${request.request_id}/cancel_request_open_course'; return false; }"
                                                                            class="btn btn-outline-danger">
                                                                        <i class='fas fa-trash' style='color: red'></i> ยกเลิก
                                                                    </button>
                                                                </td>
                                                            </c:if>
                                                        </c:if>
                                                    </tr>
                                                </c:forEach>
                                            </c:otherwise>
                                        </c:choose>
                                    </table>
                                </div>
                                <div id="register_and_payment" style="display: none">
                                    <table class="table table-striped table-hover">
                                        <tr style="color: black">
                                            <td style="width: 30%">ชื่อหลักสูตร</td>
                                            <td style="width: 12%" align="center">ระยะเวลาการลงทะเบียน</td>
                                            <td style="width: 12%" align="center">ระยะเวลาการชำระเงิน</td>
                                            <td style="width: 7%" align="center">วันประกาศผล</td>
                                            <td style="width: 12%" align="center">ระยะเวลาการเรียน</td>
                                            <td style="width: 9%" align="center">สถานะ</td>
                                            <td style="width: 10%" align="center">ผู้สมัคร</td>
                                            <td style="width: 10%" align="center"></td>
                                        </tr>
                                        <c:choose>
                                            <c:when test="${courses_by_register_pay_date.size() == 0}">
                                                <tr>
                                                    <td colspan="8" align="center">ไม่มีข้อมูล</td>
                                                </tr>
                                            </c:when>
                                            <c:otherwise>
                                                <c:forEach var="request" items="${courses_by_register_pay_date}">
                                                    <tr style="color: black;">

                                                        <c:if test="${request.quantity >= request.registerList.size()}">
                                                            <fmt:formatDate value="${request.requestDate}" pattern="dd/MM/yyyy" var="requestDate" />
                                                            <fmt:formatDate value="${request.startRegister}" pattern="dd/MM/yyyy" var="startRegister" />
                                                            <fmt:formatDate value="${request.endRegister}" pattern="dd/MM/yyyy" var="endRegister" />
                                                            <fmt:formatDate value="${request.startStudyDate}" pattern="dd/MM/yyyy" var="startStudyDate" />
                                                            <fmt:formatDate value="${request.endStudyDate}" pattern="dd/MM/yyyy" var="endStudyDate" />
                                                            <fmt:formatDate value="${request.startPayment}" pattern="dd/MM/yyyy" var="startPayment" />
                                                            <fmt:formatDate value="${request.endPayment}" pattern="dd/MM/yyyy" var="endPayment" />
                                                            <fmt:formatDate value="${request.applicationResult}" pattern="dd/MM/yyyy" var="applicationResult" />
                                                            <c:if test="${request.requestStatus == 'ผ่าน'}">
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
                                                                <td align="center"><a href="${pageContext.request.contextPath}/lecturer/${lecturer_id}/${request.request_id}/list_member_to_approve">
                                                                    <button class="button-35" role="button"><i class="fa fa-users" style="margin-right: 10px"></i>
                                                                            ${request.numberOfAllRegistrations} / ${request.quantity}
                                                                    </button>
                                                                </a></td>
                                                                <td align="center">
                                                                    <button type="button" style="font-size: 12px; border-radius: 12px;"
                                                                            onclick="if((confirm('คุณแน่ใจหรือว่าต้องการลบหลักสูตรที่ท่านกำลังเปิดนี้?'))) { window.location.href='${pageContext.request.contextPath}/lecturer/${lecturer_id}/${request.request_id}/cancel_request_open_course'; return false; }"
                                                                            class="btn btn-outline-danger">
                                                                        <i class='fas fa-trash' style='color: red'></i> ยกเลิก
                                                                    </button>
                                                                </td>
                                                            </c:if>
                                                        </c:if>
                                                    </tr>
                                                </c:forEach>
                                            </c:otherwise>
                                        </c:choose>
                                    </table>
                                </div>
                                <div id="payment_list" style="display: none">
                                    <table class="table table-striped table-hover">
                                        <tr style="color: black">
                                            <td style="width: 30%">ชื่อหลักสูตร</td>
                                            <td style="width: 20%" align="center">ระยะเวลาการชำระเงิน</td>
                                            <td style="width: 15%" align="center">วันประกาศผล</td>
                                            <td style="width: 20%" align="center">ระยะเวลาการเรียน</td>
                                            <td style="width: 10%" align="center">สถานะ</td>
                                            <td style="width: 10%" align="center">ผู้สมัคร</td>
                                        </tr>
                                        <c:choose>
                                            <c:when test="${courses_by_payment_date.size() == 0}">
                                                <tr>
                                                    <td colspan="6" align="center">ไม่มีข้อมูล</td>
                                                </tr>
                                            </c:when>
                                            <c:otherwise>
                                                <c:forEach var="request" items="${courses_by_payment_date}">
                                                    <tr style="color: black">
                                                        <fmt:formatDate value="${request.startPayment}" pattern="dd/MM/yyyy" var="startPayment" />
                                                        <fmt:formatDate value="${request.endPayment}" pattern="dd/MM/yyyy" var="endPayment" />
                                                        <fmt:formatDate value="${request.applicationResult}" pattern="dd/MM/yyyy" var="applicationResult" />
                                                        <fmt:formatDate value="${request.startStudyDate}" pattern="dd/MM/yyyy" var="startStudyDate" />
                                                        <fmt:formatDate value="${request.endStudyDate}" pattern="dd/MM/yyyy" var="endStudyDate" />
                                                        <c:if test="${request.requestStatus == 'ผ่าน'}">
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
                                                            <td align="center"><a href="${pageContext.request.contextPath}/lecturer/${lecturer_id}/${request.request_id}/list_member_to_approve">
                                                                <button class="button-35" role="button"><i class="fa fa-users" style="margin-right: 10px"></i>
                                                                        ${request.numberOfAllRegistrationsToPass} / ${request.registerList.size()}
                                                                </button>
                                                            </a></td>
                                                        </c:if>
                                                    </tr>
                                                </c:forEach>
                                            </c:otherwise>
                                        </c:choose>

                                    </table>
                                </div>
                                    <%--                        <div id="max_register" style="display: none">--%>
                                    <%--                            <table class="table table-striped table-hover">--%>
                                    <%--                                <tr style="color: black">--%>
                                    <%--                                    <td style="width: 30%">ชื่อหลักสูตร</td>--%>
                                    <%--                                    <td style="width: 16%" align="center">ระยะเวลาการลงทะเบียน</td>--%>
                                    <%--                                    <td style="width: 15%" align="center">ระยะเวลาการชำระเงิน</td>--%>
                                    <%--                                    <td style="width: 8%" align="center">วันประกาศผล</td>--%>
                                    <%--                                    <td style="width: 15%" align="center">ระยะเวลาการเรียน</td>--%>
                                    <%--                                    <td style="width: 10%" align="center">สถานะ</td>--%>
                                    <%--                                    <td style="width: 10%" align="center">ผู้สมัคร</td>--%>
                                    <%--                                </tr>--%>
                                    <%--                                <c:choose>--%>
                                    <%--                                    <c:when test="${courses_by_all_regis_pay_date.size() == 0}">--%>
                                    <%--                                        <tr>--%>
                                    <%--                                            <td colspan="8" align="center">ไม่มีข้อมูล</td>--%>
                                    <%--                                        </tr>--%>
                                    <%--                                    </c:when>--%>
                                    <%--                                    <c:otherwise>--%>
                                    <%--                                        <c:set var="count" value="0"/>--%>
                                    <%--                                        <c:forEach var="request" items="${courses_by_all_regis_pay_date}">--%>
                                    <%--                                            <tr style="color: black;">--%>


                                    <%--                                                <c:if test="${request.quantity <= request.registerList.size() && request.course.status != 'รอประกาศผล'}">--%>
                                    <%--                                                    <fmt:formatDate value="${request.requestDate}" pattern="dd/MM/yyyy" var="requestDate" />--%>
                                    <%--                                                    <fmt:formatDate value="${request.startRegister}" pattern="dd/MM/yyyy" var="startRegister" />--%>
                                    <%--                                                    <fmt:formatDate value="${request.endRegister}" pattern="dd/MM/yyyy" var="endRegister" />--%>
                                    <%--                                                    <fmt:formatDate value="${request.startStudyDate}" pattern="dd/MM/yyyy" var="startStudyDate" />--%>
                                    <%--                                                    <fmt:formatDate value="${request.endStudyDate}" pattern="dd/MM/yyyy" var="endStudyDate" />--%>
                                    <%--                                                    <fmt:formatDate value="${request.startPayment}" pattern="dd/MM/yyyy" var="startPayment" />--%>
                                    <%--                                                    <fmt:formatDate value="${request.endPayment}" pattern="dd/MM/yyyy" var="endPayment" />--%>
                                    <%--                                                    <fmt:formatDate value="${request.applicationResult}" pattern="dd/MM/yyyy" var="applicationResult" />--%>
                                    <%--                                                    <c:if test="${request.requestStatus == 'ผ่าน'}">--%>
                                    <%--                                                        <td><p>${request.course.name}</p></td>--%>
                                    <%--                                                        <td align="center">--%>
                                    <%--                                                            <p>${startRegister} - ${endRegister}</p><br>--%>
                                    <%--                                                        </td>--%>
                                    <%--                                                        <c:choose>--%>
                                    <%--                                                            <c:when test="${request.course.fee != 0}">--%>
                                    <%--                                                                <td align="center"><p>${startPayment} - ${endPayment}</p></td>--%>
                                    <%--                                                            </c:when>--%>
                                    <%--                                                            <c:otherwise>--%>
                                    <%--                                                                <td align="center"><p>ไม่มีการชำระเงิน(ฟรี)</p></td>--%>
                                    <%--                                                            </c:otherwise>--%>
                                    <%--                                                        </c:choose>--%>
                                    <%--                                                        <td align="center">--%>
                                    <%--                                                            <p>${applicationResult}</p><br>--%>
                                    <%--                                                        </td>--%>
                                    <%--                                                        <td align="center">--%>
                                    <%--                                                            <p>${startStudyDate} - ${endStudyDate}</p><br>--%>
                                    <%--                                                        </td>--%>
                                    <%--                                                        <td align="center">--%>
                                    <%--                                                            <p>${request.course.status}</p><br>--%>
                                    <%--                                                        </td>--%>
                                    <%--                                                        <td align="center"><a href="${pageContext.request.contextPath}/lecturer/${lecturer_id}/${request.request_id}/list_member_to_approve">--%>
                                    <%--                                                            <button class="button-35" role="button"><i class="fa fa-users" style="margin-right: 10px"></i>--%>
                                    <%--                                                                    ${request.numberOfAllRegistrations} / ${request.quantity}--%>
                                    <%--                                                            </button>--%>
                                    <%--                                                        </a></td>--%>
                                    <%--                                                    </c:if>--%>
                                    <%--                                                    <c:set var="count" value="${count + 1}"/>--%>
                                    <%--                                                </c:if>--%>
                                    <%--                                            </tr>--%>
                                    <%--                                        </c:forEach>--%>
                                    <%--                                        <c:if test="${count == 0}">--%>
                                    <%--                                            <tr>--%>
                                    <%--                                                <td colspan="8" align="center">ไม่มีข้อมูล</td>--%>
                                    <%--                                            </tr>--%>

                                    <%--                                        </c:if>--%>
                                    <%--                                    </c:otherwise>--%>
                                    <%--                                </c:choose>--%>
                                    <%--                            </table>--%>
                                    <%--                        </div>--%>
                                <div id="app_list" style="display: none">
                                    <table class="table table-striped table-hover">
                                        <tr style="color: black">
                                            <td style="width: 30%">ชื่อหลักสูตร</td>
                                            <td style="width: 20%" align="center">ระยะเวลาการชำระเงิน</td>
                                            <td style="width: 15%" align="center">วันประกาศผล</td>
                                            <td style="width: 20%" align="center">ระยะเวลาการเรียน</td>
                                            <td style="width: 10%" align="center">สถานะ</td>
                                            <td style="width: 15%" align="center">ผู้สมัคร</td>
                                        </tr>
                                        <c:choose>
                                            <c:when test="${courses_by_app_date.size() == 0}">
                                                <tr>
                                                    <td colspan="6" align="center">ไม่มีข้อมูล</td>
                                                </tr>
                                            </c:when>
                                            <c:otherwise>
                                                <c:forEach var="request" items="${courses_by_app_date}">
                                                    <tr style="color: black">
                                                        <fmt:formatDate value="${request.startPayment}" pattern="dd/MM/yyyy" var="startPayment" />
                                                        <fmt:formatDate value="${request.endPayment}" pattern="dd/MM/yyyy" var="endPayment" />
                                                        <fmt:formatDate value="${request.applicationResult}" pattern="dd/MM/yyyy" var="applicationResult" />
                                                        <fmt:formatDate value="${request.startStudyDate}" pattern="dd/MM/yyyy" var="startStudyDate" />
                                                        <fmt:formatDate value="${request.endStudyDate}" pattern="dd/MM/yyyy" var="endStudyDate" />
                                                        <c:if test="${request.requestStatus == 'ผ่าน'}">
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
                                                            <td align="center"><a href="${pageContext.request.contextPath}/lecturer/${lecturer_id}/${request.request_id}/list_member_to_approve">
                                                                <button class="button-35" role="button"><i class="fa fa-users" style="margin-right: 10px"></i>
                                                                        ${request.numberOfAllRegistrationsPayStatus} / ${request.registerList.size()}
                                                                </button>
                                                            </a></td>
                                                        </c:if>
                                                    </tr>
                                                </c:forEach>
                                            </c:otherwise>
                                        </c:choose>
                                    </table>
                                </div>

                            </div>
                            <div id="list_study" style="display: none">
                                <table class="table table-striped table-hover" style="font-size: 12px">
                                    <tr style="color: black">
                                        <td style="width: 25%;">รายละเอียดหลักสูตร</td>
                                        <td style="width: 15%" align="center">ระยะเวลาเรียน</td>
                                        <td style="width: 10%"align="center">ประเภท</td>
                                        <td style="width: 10%"align="center">ตัวอย่างเกียรติบัตร</td>
                                        <td style="width: 10%"align="center">ผู้สมัคร</td>
                                        <td style="width: 20%"align="center"></td>
                                    </tr>
                                    <c:choose>
                                        <c:when test="${courses_by_study_date.size() == 0}">
                                            <tr>
                                                <td colspan="6" align="center">ไม่มีข้อมูล</td>
                                            </tr>
                                        </c:when>
                                        <c:otherwise>
                                            <c:forEach var="request_course" items="${courses_by_study_date}">
                                                <c:if test="${request_course.requestStatus == 'ผ่าน'}">
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
                                                                    <i class='fas fa-user-friends' style='color: white; margin-right: 5px'></i>
                                                                        ${request_course.numberOfAllRegistrationsByStudyResult} / ${request_course.numberOfAllRegistrationsToPass}
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
    const cancelStatus = urlParams.get('cancelStatus');

    // ถ้ามีค่าเป็น 'true', แสดง Alert
    if (addParam === 'true') {
        alert("เพิ่มข้อมูลการร้องขอสำเร็จ");
    }else if (editParam === 'true'){
        alert("แก้ไขข้อมูลการร้องขอสำเร็จ");
    }else if (deleteParam === 'true'){
        alert("ลบข้อมูลการร้องขอสำเร็จ");
    }else if (cancelStatus === 'true'){
        alert("ยกเลิกหลักสูตรที่ท่านกำลังเปิดสำเร็จ");
    }
</script>
<script>
    function checkSelection() {
        var selectElement = document.getElementById("select_type");
        var selectedValue = selectElement.value;

        if (selectedValue === "กำลังลงทะเบียน") {
            document.getElementById("tag_line").textContent = "หลักสูตรที่กำลังลงทะเบียน/ชำระเงิน"
            document.getElementById("register_select").style.display = "block";
            document.getElementById("list_study").style.display = "none";
        }else if (selectedValue === "กำลังเรียน") {
            document.getElementById("tag_line").textContent = "หลักสูตรที่กำลังเรียน"
            document.getElementById("register_select").style.display = "none";
            document.getElementById("list_study").style.display = "block";
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
            document.getElementById("app_list").style.display = "block";
        }
    });
</script>
</html>
