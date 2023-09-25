<%@ page import="lifelong.model.Admin" %>
<%@ page import="lifelong.model.Member" %>
<%@ page import="lifelong.model.Lecturer" %>
<%@ page import="java.time.LocalDate" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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
    <title>Title</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
    <jsp:include page="/WEB-INF/view/layouts/detail-all-style.jsp"/>
    <style>
        table tr th {
            font-size: 19px;
            color: black;
            text-align: center;
        }
    </style>
</head>
<body>
<!-- Navbar -->
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

<c:set var="flag" value="<%= flag %>" />
<c:choose>
    <c:when test="${flag.equals('admin')}">
        <jsp:include page="/WEB-INF/view/admin/nav_admin.jsp"/>
    </c:when>
    <c:when test="${flag.equals('lecturer')}">
        <jsp:include page="/WEB-INF/view/lecturer/nav_lecturer.jsp"/>
    </c:when>
    <c:when test="${flag.equals('member')}">
        <jsp:include page="/WEB-INF/view/member/nav_member.jsp"/>
    </c:when>
    <c:otherwise>
        <jsp:include page="/WEB-INF/view/layouts/nav.jsp"/>
    </c:otherwise>
</c:choose>
<center>
    <c:set var="username" value="<%= member.getUsername() %>" />
    <br>

    <button id="FClick" class="tablinks btn btn-success" onclick="openList(event, 'listCourse')">หลักสูตร</button>
    <button class="tablinks btn btn-danger" onclick="openList(event, 'listInvoice')">ที่ต้องชำระเงิน</button>
    <br><br>

    <div class="tabcontent" id="listCourse">
        <table class="table table-hover" style="width: 1200px;">
            <tr>
                <th style="text-align: left;">รายการ</th>
                <th style="width: 130px;">เริ่มเรียน</th>
                <th style="width: 130px;">สิ้นสุดการเรียน</th>
                <th style="width: 130px;">สถานะ</th>
                <th style="width: 130px;">เกียรติบัตร</th>
            </tr>
            <c:forEach var="invoice" items="${register}">
                <tr>
                    <c:choose>

                        <c:when test="${invoice.invoice.pay_status == true}">
                            <c:choose>
                                <c:when test="${invoice.invoice.approve_status.equals('ผ่าน')}">
                                    <td>${invoice.requestOpenCourse.course.name}</td>
                                    <td style="text-align: center;"><p id="formattedStartStudy">${invoice.requestOpenCourse.startStudyDate}</p></td>
                                    <td style="text-align: center;"><p id="formattedEndStudy">${invoice.requestOpenCourse.endStudyDate}</p></td>

                                    <c:set var="txtstt" value="${invoice.study_result}"></c:set>
                                    <c:if var="stt" test="${txtstt == false}">
                                        <c:set var="txtstt" value="อยู่ระหว่างเรียน"></c:set>
                                        <td style="width: 200px; text-align: center; color: #ee8e18; font-weight: bold;">${txtstt}</td>
                                        <td></td>
                                    </c:if>

                                    <c:if var="stt" test="${txtstt == true}">
                                        <c:set var="txtstt" value="ผ่านหลักสูตร"></c:set>
                                        <td style="width: 200px; text-align: center; color: green; font-weight: bold;">${txtstt}</td>
                                        <td>
                                            <a href="${pageContext.request.contextPath}/member/${invoice.member.username}/certificate/${invoice.register_id}">
                                                <button style="text-align: center;" class="btn btn-outline-success">ดูเกียรติบัตร</button>
                                            </a>
                                        </td>
                                    </c:if>
                                </c:when>
                            </c:choose>
                        </c:when>
                        <c:otherwise>

                        </c:otherwise>
                    </c:choose>
                </tr>
            </c:forEach>
        </table>
    </div>

    <div class="tabcontent" id="listInvoice">
        <table class="table table-hover" style="width: 1200px;">
            <tr>
                <th style="text-align: left;">รายการ</th>
                <th style="width: 130px;">เริ่มชำระเงิน</th>
                <th style="width: 130px;">สิ้นสุดชำระเงิน</th>
                <th style="width: 160px;">สถานะ</th>
                <th style="width: 130px;">หมายเหตุ</th>
            </tr>
            <c:forEach var="invoices" items="${register}">
                <tr>
                    <c:if test="${invoices.invoice.approve_status ne 'ผ่าน'}">
                        <td style="width: 550px;">${invoices.requestOpenCourse.course.name}</td>
                        <td style="text-align: center;"><p id="formattedStartPayment">${invoices.invoice.startPayment}</p></td>
                        <td style="text-align: center;"><p id="formattedEndPayment">${invoices.invoice.endPayment}</p></td>
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
                                <c:set var="status_update" value="<%= stt_update %>" />
                                <c:choose>
                                    <c:when test="${status_update.equals('success')}">
                                        <td style="text-align: center;">
                                            <p style="color: green; font-weight: bold;">แก้ไขการชำระเงินแล้ว</p>
                                        </td>
                                        <td style="text-align: center;"><p style="font-weight: bold; color: #ee8e18;">รอดำเนินการ</p></td>
                                    </c:when>
                                    <c:otherwise>
                                        <td style="text-align: center;">
                                            <a href="${pageContext.request.contextPath}/member/${invoices.member.username}/update_payment_fill_detail/${invoices.invoice.invoice_id}"><button class="btn btn-outline-danger">แก้ไขการชำระเงิน</button></a>
                                        </td>
                                        <td style="text-align: center;"><p style="color: red; font-weight: bold;">กรุณาอัพโหลดหลักฐานการชำระเงินใหม่</p></td>
                                    </c:otherwise>
                                </c:choose>
                            </c:if>

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
                                <c:set var="startDate" value="${LocalDate.of(s_year, s_month, s_day)}"/>
                                <c:set var="endDate" value="${LocalDate.of(e_year, e_month, e_day)}"/>


                                <c:if test="${currentDate.isBefore(startDate)}">
                                    <p style="color: black; font-weight: bold;">เร็วๆนี้</p>
                                </c:if>

                                <c:if test="${currentDate.isAfter(endDate)}">
                                    <p style="color: red; font-weight: bold">การลงทะเบียนถูกยกเลิก</p>
                                </c:if>

                                <c:if test="${currentDate.equals(startDate) || currentDate.equals(endDate)}">
                                    <a href="${pageContext.request.contextPath}/member/${username}/payment_fill_detail/${invoices.invoice.invoice_id}"><button class="btn btn-outline-dark">ชำระเงิน</button></a>
                                </c:if>

                                <c:if test="${currentDate.isAfter(startDate) && currentDate.isBefore(endDate)}">
                                    <a href="${pageContext.request.contextPath}/member/${username}/payment_fill_detail/${invoices.invoice.invoice_id}"><button class="btn btn-outline-dark">ชำระเงิน</button></a>
                                </c:if>
                                <!---End check date--->
                            </td>
                            <td>
                                <c:if test="${currentDate.isAfter(endDate)}">
                                    <p style="color: black; font-weight: bold">เลยกำหนดชำระเงิน</p>
                                </c:if>
                            </td>

<%--                            <c:if test="${currentDate.isAfter(endDate)}">--%>
<%--                                <td style="text-align: center;">--%>
<%--                                    <input type="button" value="ลงทะเบียนใหม่" onclick="if((confirm('ยืนยันการลงทะเบียนใหม่อีกครั้ง?'))){ window.location.href='${pageContext.request.contextPath}/member/${invoices.member.username}/${invoices.register_id}/delete';return false; }"/>--%>
<%--                                </td>--%>
<%--                            </c:if>--%>
                        </c:otherwise>
                    </c:choose>
                </tr>
            </c:forEach>
        </table>
    </div>
</center>
</body>

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
