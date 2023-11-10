<%@ page import="lifelong.model.Admin" %>
<%@ page import="lifelong.model.Member" %>
<%@ page import="lifelong.model.Lecturer" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.util.Date" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%--
  Created by IntelliJ IDEA.
  User: asus
  Date: 11/7/2566
  Time: 16:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>My List Course</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
            crossorigin="anonymous"></script>
    <jsp:include page="/WEB-INF/view/layouts/detail-all-style.jsp"/>
    <style>
        table tr th {
            font-size: 110%;
            color: black;
            text-align: center;
        }

        tr td p {
            color: black;
        }
    </style>
</head>
<body>
<!-- Navbar Start -->
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

<c:set var="flag" value="<%= flag %>"/>
<c:choose>
    <c:when test="${flag.equals('member')}">
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
                    <a href="${pageContext.request.contextPath}/" class="nav-item nav-link" style="font-size: 17px">หน้าหลัก</a>
                        <%--                    <a href="#" class="nav-item nav-link" style="font-size: 17px">เกี่ยวกับคณะ</a>--%>
                        <%--            <div class="nav-item dropdown">--%>
                        <%--                <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">หลักสูตรการอบรม</a>--%>
                    <a href="${pageContext.request.contextPath}/search_course" class="nav-item nav-link "
                       style="font-size: 17px">หลักสูตรการอบรม</a>
                        <%--                <div class="dropdown-menu m-0">--%>
                        <%--                    <a href="#" class="dropdown-item">Reskill/Upskill</a>--%>
                        <%--                    <a href="#" class="dropdown-item">อบรมระยะสั้น</a>--%>
                        <%--                </div>--%>
                        <%--            </div>--%>
                    <a href="${pageContext.request.contextPath}/member/<%=member.getUsername()%>/listcourse"
                       class="nav-item nav-link active" style="font-size: 17px">หลักสูตรของฉัน</a>
                    <a href="${pageContext.request.contextPath}/view_activity" class="nav-item nav-link"
                       style="font-size: 17px">ข่าวสารและกิจกรรม</a>
                        <%--                    <a href="#" class="nav-item nav-link" style="font-size: 17px">เกี่ยวกับเรา</a>--%>
                    <a href="${pageContext.request.contextPath}/member/<%=member.getUsername()%>/edit_profile"
                       class="nav-item nav-link" style="font-size: 17px">ข้อมูลส่วนตัว</a>
                    <a href="${pageContext.request.contextPath}/doLogout" class="nav-item nav-link"
                       style="font-size: 17px">ออกจากระบบ</a>
                </div>
            </div>
        </nav>
        <!-- Navbar End -->
    </c:when>
</c:choose>
<center>
    <c:set var="username" value="<%= member.getUsername() %>"/>
    <br>

    <%--    Button Switch--%>
    <button id="FClick" class="tablinks btn btn-success" style="width: 12%;" onclick="openList(event, 'listCourse')">หลักสูตร</button>
    <button id="SClick" class="tablinks btn btn-danger" style="width: 12%;" onclick="openList(event, 'listInvoice')">การชำระเงิน</button>
    <button id="TClick" class="tablinks btn btn-dark" style="width: 12%;" onclick="openList(event, 'listHistory')">ประวัติการทำรายการ</button>
    <br><br>


    <%--    List Register--%>
    <div class="tabcontent" id="listCourse">
        <table class="table table-striped table-hover" style="width: 1200px;">
            <tr>
                <th style="text-align: left;">รายการ</th>
                <th style="width: 130px;">เริ่มเรียน</th>
                <th style="width: 130px;">สิ้นสุดการเรียน</th>
                <th style="width: 200px;">วันที่เรียน</th>
                <th style="width: 140px;">ประเภทการเรียน</th>
                <th style="width: 105px;">สถานะ</th>
                <th style="width: 130px;"></th>
            </tr>
            <c:set var="current_register" value="<%= new Date()%>"/>
            <c:forEach var="invoice" items="${register}">
                <tr>
                    <c:choose>
<%--                        <c:when test="${invoice.requestOpenCourse.course.fee == 0 || invoice.invoice.pay_status == true && (current_register.equals(invoice.requestOpenCourse.applicationResult) || current_register.after(invoice.requestOpenCourse.applicationResult))}">--%>
                        <c:when test="${invoice.requestOpenCourse.course.fee == 0 || invoice.invoice.pay_status == true}">
                        <c:choose>
                                <c:when test="${invoice.invoice.approve_status.equals('ผ่าน')}">
                                    <td><p>${invoice.requestOpenCourse.course.name}</p></td>
                                    <fmt:formatDate value="${invoice.requestOpenCourse.startStudyDate}"
                                                    pattern="dd/MM/yyyy" var="startStudyDate"/>
                                    <fmt:formatDate value="${invoice.requestOpenCourse.endStudyDate}"
                                                    pattern="dd/MM/yyyy" var="endStudyDate"/>
                                    <td style="text-align: center;"><p>${startStudyDate}</p></td>
                                    <td style="text-align: center;"><p>${endStudyDate}</p></td>
                                    <td style="text-align: center;">
                                        <c:set var="delimiter" value="$%"/>
                                        <c:set var="subText"
                                               value="${fn:split(invoice.requestOpenCourse.studyTime, delimiter)}"/>
                                        <c:forEach var="ogText" items="${subText}">
                                            <c:set var="parts" value="${fn:split(ogText, '/')}"/>
                                            <label>${parts[0]} ${parts[1]} - ${parts[2]} น.</label><br>
                                        </c:forEach>
                                    </td>
                                    <td style="text-align: center;"><p>${invoice.requestOpenCourse.type_learn}</p></td>
                                    <c:choose>
                                        <c:when test="${invoice.study_result.equals('ผ่าน')}">
                                            <td style="width: 170px; text-align: center; color: green; font-weight: bold;">${invoice.study_result}</td>
                                            <td>
                                                <a href="${pageContext.request.contextPath}/member/${invoice.member.username}/certificate/${invoice.register_id}">
                                                    <button style="text-align: center; width: 95%;" class="btn btn-outline-success">
                                                        ดูเกียรติบัตร
                                                    </button>
                                                </a>
                                            </td>
                                        </c:when>

                                        <c:when test="${invoice.study_result.equals('กำลังเรียน')}">
                                            <c:if test="${(current_register.equals(invoice.requestOpenCourse.applicationResult) || current_register.after(invoice.requestOpenCourse.applicationResult))}">
                                                <c:set var="current" value="<%=LocalDate.now()%>"/>
                                                <c:set var="startStudyDate" value="${invoice.requestOpenCourse.startStudyDate.toLocalDate()}"/>
                                                <c:set var="endStudyDate" value="${invoice.requestOpenCourse.endStudyDate.toLocalDate()}"/>

                                                <c:if test="${current.isBefore(startStudyDate)}">
                                                    <td><p style="color: black; font-weight: bold; text-align: center;">
                                                        เร็วๆนี้</p></td>
                                                    <td></td>
                                                </c:if>

                                                <c:if test="${current.equals(startStudyDate) || current.equals(endStudyDate) || (current.isAfter(startStudyDate) && current.isBefore(endStudyDate))}">
                                                    <td style="width: 170px; text-align: center; color: #ee8e18; font-weight: bold;">${invoice.study_result}</td>
                                                    <td style="text-align: center">
                                                        <a href="${invoice.requestOpenCourse.linkMooc}">
                                                            <button type="button" style="width: 95%;" class="btn btn-outline-success">
                                                                เข้าเรียน
                                                            </button>
                                                        </a>
                                                    </td>
                                                </c:if>
                                            </c:if>
                                            <c:if test="${(current_register ne invoice.requestOpenCourse.applicationResult && current_register.before(invoice.requestOpenCourse.applicationResult))}">
                                                <td>
                                                    <p style="color: black; text-align: center;">รอประกาศผล</p>
                                                </td>
                                                <td></td>
                                            </c:if>
                                        </c:when>

                                        <c:when test="${invoice.study_result.equals('ไม่ผ่าน')}">
                                            <td style="width: 200px; text-align: center; color: #000000; font-weight: bold;">
                                                สิ้นสุดการเรียน
                                            </td>
                                            <td></td>
                                        </c:when>
                                    </c:choose>
                                </c:when>
                            </c:choose>
                        </c:when>
                    </c:choose>
                </tr>
            </c:forEach>
        </table>
    </div>

    <%--    List Invoice--%>
    <div class="tabcontent" id="listInvoice">
        <table class="table table-striped table-hover" style="width: 1260px;">
            <tr>
                <th style="text-align: left;">รายการ</th>
                <th style="width: 130px;">เริ่มชำระเงิน</th>
                <th style="width: 130px;">สิ้นสุดชำระเงิน</th>
                <th style="width: 146px;">ประกาศผลสมัคร</th>
                <th style="width: 160px;">สถานะการชำระเงิน</th>
                <th style="width: 170px;">หมายเหตุ</th>
            </tr>

            <c:forEach var="invoices" items="${register}">
                <c:set var="listAllDisplayed" value="false"/>
                <c:set var="paid" value="0"/>
                <c:if test="${!listAllDisplayed}">
                    <c:forEach var="listInvoice" items="${listAllInvoice}">
                        <c:if test="${listInvoice.register.requestOpenCourse.request_id == invoices.requestOpenCourse.request_id}">
                            <c:if test="${listInvoice.pay_status == true}">
                                <c:set var="paid" value="${paid + 1}"/>
                            </c:if>
                            <c:if test="${invoices.member.username.equals(listInvoice.register.member.username)}">

                                <c:set var="currentInvoice" value="<%=LocalDate.now()%>"/>
                                <tr>
                                    <c:if test="${invoices.invoice.approve_status ne 'ผ่าน'}">

                                        <td style="width: 550px;"><p>${invoices.requestOpenCourse.course.name}</p></td>
                                        <fmt:formatDate value="${invoices.invoice.startPayment}" pattern="dd/MM/yyyy" var="startPayment"/>
                                        <fmt:formatDate value="${invoices.invoice.endPayment}" pattern="dd/MM/yyyy" var="endPayment"/>
                                        <fmt:formatDate value="${invoices.requestOpenCourse.applicationResult}" pattern="dd/MM/yyyy" var="applicationResult"/>
                                        <td style="text-align: center;"><p>${startPayment}</p></td>
                                        <td style="text-align: center;"><p>${endPayment}</p></td>
                                        <td style="text-align: center;"><p>${applicationResult}</p></td>
                                    </c:if>
                                    <c:choose>
                                        <c:when test="${invoices.invoice.pay_status == true}">
                                            <c:if test="${invoices.invoice.approve_status.equals('รอดำเนินการ')}">
                                                <td style="text-align: center;">
                                                    <p style="font-weight: bold; color: #ee8e18;">${invoices.invoice.approve_status}</p>
                                                </td>
                                                <td style="text-align: center;"></td>
                                            </c:if>
                                            <c:if test="${invoices.invoice.approve_status.equals('ไม่ผ่าน')}">
                                                <% String stt_update = (String) session.getAttribute("update"); %>
                                                <c:set var="status_update" value="<%= stt_update %>"/>
                                                <c:choose>
                                                    <c:when test="${status_update.equals('success')}">
                                                        <td style="text-align: center;">
                                                            <p style="color: green; font-weight: bold;">
                                                                แก้ไขการชำระเงินแล้ว</p>
                                                        </td>
                                                        <td style="text-align: center;"><p
                                                                style="font-weight: bold; color: #ee8e18;">
                                                            รอดำเนินการ</p></td>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <td style="text-align: center;">
                                                            <a href="${pageContext.request.contextPath}/member/${invoices.member.username}/update_payment_fill_detail/${invoices.invoice.invoice_id}">
                                                                <button class="btn btn-outline-danger">แก้ไขการชำระเงิน
                                                                </button>
                                                            </a>
                                                        </td>
                                                        <td style="text-align: center;">
                                                            <p style="color: red; font-weight: bold; text-align: center;">
                                                            กรุณาอัพโหลดหลักฐานการชำระเงินใหม่</p></td>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:if>
                                        </c:when>
                                        <c:when test="${invoices.invoice.pay_status == false}">
                                            <c:choose>
                                                <c:when test="${paid == invoices.requestOpenCourse.quantity}">
                                                    <td style="text-align: center;"><p
                                                            style="color: red; font-weight: bold;">ขออภัย <br>ยอดผู้ชำระเงินครบ
                                                        <br>ตามจำนวนแล้ว</p></td>
                                                    <td></td>
                                                </c:when>
                                                <c:when test="${invoices.requestOpenCourse.requestStatus.equals('ถูกยกเลิก')}">
                                                    <td><p style="color: red; font-weight: bold;">
                                                        หลักสูตรนี้ได้ถูกยกเลิกการเรียน</p></td>
                                                    <td></td>
                                                </c:when>
                                                <c:otherwise>
                                                    <td style="width: 100px; text-align: center;">
                                                        <!---Start check date--->
                                                        <c:set var="startpay" value="${invoices.invoice.startPayment}"/>
                                                        <c:set var="s_year" value="${fn:substring(startpay, 0, 4)}"/>
                                                        <c:set var="s_month" value="${fn:substring(startpay, 5, 7)}"/>
                                                        <c:set var="s_day" value="${fn:substring(startpay, 8, 10)}"/>

                                                        <c:set var="endpay" value="${invoices.invoice.endPayment}"/>
                                                        <c:set var="e_year" value="${fn:substring(endpay, 0, 4)}"/>
                                                        <c:set var="e_month" value="${fn:substring(endpay, 5, 7)}"/>
                                                        <c:set var="e_day" value="${fn:substring(endpay, 8, 10)}"/>

                                                        <c:set var="currentDate" value="<%=LocalDate.now()%>"/>
                                                        <c:set var="startDate"
                                                               value="${LocalDate.of(s_year, s_month, s_day)}"/>
                                                        <c:set var="endDate"
                                                               value="${LocalDate.of(e_year, e_month, e_day)}"/>

                                                        <c:if test="${currentDate.isBefore(startDate)}">
                                                            <p style="color: black; font-weight: bold;">เร็วๆนี้</p>
                                                        </c:if>

                                                        <c:if test="${currentDate.isAfter(endDate)}">
                                                            <p style="color: red; font-weight: bold">
                                                                การลงทะเบียน<br>ถูกยกเลิก</p>
                                                        </c:if>

                                                        <c:if test="${currentDate.equals(startDate) || currentDate.equals(endDate)}">
                                                            <a href="${pageContext.request.contextPath}/member/${username}/payment_fill_detail/${invoices.invoice.invoice_id}">
                                                                <button class="btn btn-outline-dark">ชำระเงิน</button>
                                                            </a>
                                                        </c:if>

                                                        <c:if test="${currentDate.isAfter(startDate) && currentDate.isBefore(endDate)}">
                                                            <a href="${pageContext.request.contextPath}/member/${username}/payment_fill_detail/${invoices.invoice.invoice_id}">
                                                                <button class="btn btn-outline-dark">ชำระเงิน</button>
                                                            </a>
                                                        </c:if>
                                                    </td>
                                                    <!---End check date--->
                                                    <td>
                                                        <c:if test="${currentDate.isAfter(endDate)}">
                                                            <p style="color: black; font-weight: bold; text-align: center;">
                                                                เลยกำหนดชำระเงิน</p>
                                                        </c:if>
                                                    </td>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:when>
                                    </c:choose>
                                </tr>
                                <c:set var="listAllDisplayed" value="true"/>
                            </c:if>
                        </c:if>
                    </c:forEach>
                </c:if>
            </c:forEach>
        </table>
    </div>

    <%--    List History--%>
    <div class="tabcontent" id="listHistory">
        <table class="table table-striped table-hover" style="width: 1200px;">
            <tr>
                <th style="text-align: left;">รายการ</th>
                <th style="width: 130px;">วันที่ชำระเงิน</th>
                <th style="width: 130px;">จำนวน</th>
                <th style="width: 130px;">สถานะ</th>
                <th style="width: 130px;">หมายเหตุ</th>
            </tr>

            <c:forEach var="his" items="${receipt}">
                <tr>
                    <c:choose>
                        <c:when test="${his.invoice.pay_status == true && (his.invoice.register.requestOpenCourse.requestStatus.equals('ผ่าน') || his.invoice.register.requestOpenCourse.requestStatus.equals('เสร็จสิ้น'))}">
                            <c:choose>
                                <c:when test="${his.invoice.approve_status.equals('ผ่าน')}">
                                    <td><p>${his.invoice.register.requestOpenCourse.course.name}</p></td>
                                    <fmt:formatDate value="${his.pay_date}" pattern="dd/MM/yyyy" var="datePayment"/>
                                    <td style="text-align: center;"><p>${datePayment}</p></td>

                                    <c:set var="course_fee"
                                           value="${his.invoice.register.requestOpenCourse.course.fee}"/>
                                    <td style="text-align: center; color: black;"><fmt:formatNumber
                                            value="${course_fee}" type="number"/></td>

                                    <c:choose>
                                        <c:when test="${his.invoice.pay_status == true && his.invoice.approve_status.equals('ผ่าน')}">
                                            <td style="width: 200px; text-align: center; color: green; font-weight: bold;">
                                                ชำระแล้ว
                                            </td>
                                            <td style="text-align: center">
                                                <a href="${pageContext.request.contextPath}/member/${his.invoice.register.member.username}/receipt/${his.invoice.invoice_id}">
                                                    <button style="text-align: center;" class="btn btn-outline-success">
                                                        ใบเสร็จ
                                                    </button>
                                                </a>
                                            </td>
                                        </c:when>
                                    </c:choose>
                                </c:when>
                            </c:choose>
                        </c:when>
                    </c:choose>
                </tr>
            </c:forEach>
        </table>
    </div>
    <br><br><br>

</center>
</body>

<script>
    window.addEventListener('DOMContentLoaded', (event) => {
        // var button = document.getElementById('FClick');
        // button.click()
        if (`${fromPage}` === ''){
            document.getElementById('FClick').click();
        } else if (`${fromPage}` === 'paymentPage'){
            document.getElementById('SClick').click();
        }else if (`${fromPage}` === 'paymentReceipt'){
            document.getElementById('TClick').click()
        }

        console.log("fromPage : " + `${fromPage}`)
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

    /******** Format Date to dd/mm/yyyy **************/

    function formatDateElement(elementId) {
        var text = document.getElementById(elementId).textContent;
        var date = new Date(text);

        var day = date.getDate();
        var month = date.getMonth() + 1; // เพิ่ม 1 เนื่องจากเดือนเริ่มต้นจาก 0
        var year = date.getFullYear();

        return day + '/' + month + '/' + year;
    }

    var formattedStartPayment = formatDateElement("formattedStartPayment");
    document.getElementById("formattedStartPayment").textContent = formattedStartPayment;

    var formattedEndPayment = formatDateElement("formattedEndPayment");
    document.getElementById("formattedEndPayment").textContent = formattedEndPayment;

    var formattedStartStudy = formatDateElement("formattedStartStudy");
    document.getElementById("formattedStartStudy").textContent = formattedStartStudy;

    var formattedEndStudy = formatDateElement("formattedEndStudy");
    document.getElementById("formattedEndStudy").textContent = formattedEndStudy;


</script>
</html>
