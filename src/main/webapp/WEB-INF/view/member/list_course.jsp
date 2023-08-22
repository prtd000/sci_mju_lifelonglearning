<%@ page import="lifelong.model.Admin" %>
<%@ page import="lifelong.model.Member" %>
<%@ page import="lifelong.model.Lecturer" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
    <jsp:include page="/WEB-INF/view/layouts/detail-all-style.jsp"/>
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

<c:set var="flag" value="<%= flag %>"></c:set>
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

    <button id="FClick" class="tablinks" onclick="openList(event, 'listCourse')">หลักสูตร</button>
    <button class="tablinks" onclick="openList(event, 'listInvoice')">ที่ต้องชำระเงิน</button>

    <div class="tabcontent" id="listCourse">
        <table>
            <tr>
                <td>รายการ</td>
                <td style="width: 130px; text-align: center;">เริ่มเรียน</td>
                <td style="width: 130px; text-align: center;">สิ้นสุดการเรียน</td>
                <td style="width: 130px; text-align: center;">สถานะ</td>
                <td style="width: 130px; text-align: center;">เกียรติบัตร</td>
            </tr>
            <c:forEach var="invoice" items="${register}">
                <tr>
                    <c:choose>

                        <c:when test="${invoice.invoice.pay_status == true}">
                            <c:choose>
                                <c:when test="${invoice.invoice.approve_status.equals('ผ่าน')}">
                                    <td>${invoice.requestOpenCourse.course.name}</td>
                                    <td style="text-align: center;">${invoice.requestOpenCourse.startStudyDate}</td>
                                    <td style="text-align: center;">${invoice.requestOpenCourse.endStudyDate}</td>
                                    <c:set var="txtstt" value="${invoice.study_result}"></c:set>
                                    <c:if var="stt" test="${txtstt == false}">
                                        <c:set var="txtstt" value="อยู่ระหว่างเรียน"></c:set>
                                        <td style="width: 200px; text-align: center; color: #ee8e18; font-weight: bold;">${txtstt}</td>
                                    </c:if>

                                    <c:if var="stt" test="${txtstt == true}">
                                        <c:set var="txtstt" value="ผ่านหลักสูตร"></c:set>
                                        <td style="width: 200px; text-align: center; color: green; font-weight: bold;">${txtstt}</td>
                                        <td>
                                            <a href="${pageContext.request.contextPath}/member/${invoice.member.username}/certificate">
                                                <button style="text-align: center;">ดูเกียรติบัตร</button>
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
        <table>
            <tr>
                <td>รายการ</td>
                <td style="width: 130px; text-align: center;">เริ่มชำระเงิน</td>
                <td style="width: 130px; text-align: center;">สิ้นสุดชำระเงิน</td>
                <td style="width: 130px; text-align: center;">สถานะ</td>
                <td style="width: 130px; text-align: center;">ยกเลิก</td>
            </tr>
            <c:forEach var="invoices" items="${register}">
                <tr>
                    <c:choose>
                        <c:when test="${invoices.invoice.pay_status == true}">
                            <c:if test="${invoices.invoice.approve_status.equals('รอดำเนินการ')}">
                                <td style="width: 550px;">${invoices.requestOpenCourse.course.name}</td>
                                <td style="text-align: center;"></td>
                                <td style="text-align: center;"></td>
                                <td style="text-align: center;">
                                    <p style="color: #F4B133">${invoices.invoice.approve_status}</p>
                                </td>
                                <td style="text-align: center;"></td>
                            </c:if>
                        </c:when>
                        <c:otherwise>
                            <td style="width: 550px;">${invoices.requestOpenCourse.course.name}</td>
                            <td style="text-align: center;">${invoices.invoice.startPayment}</td>
                            <td style="text-align: center;">${invoices.invoice.endPayment}</td>
                            <td style="width: 100px; text-align: center;">
                                <a href="${pageContext.request.contextPath}/member/${invoices.member.username}/payment_detail/${invoices.invoice.invoice_id}">
                                    <button>ชำระเงิน</button>
                                </a>
                            </td>
                            <td style="text-align: center;">
                                <input type="button" value="ยกเลิก"
                                       onclick="if((confirm('คุณแน่ใจหรือว่าต้องการลบ?'))){ window.location.href='${pageContext.request.contextPath}/member/${invoices.member.username}/${invoices.register_id}/delete';return false; }"/>
                            </td>
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
</script>
</html>
