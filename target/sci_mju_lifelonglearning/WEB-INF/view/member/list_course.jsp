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
<jsp:include page="/WEB-INF/view/layouts/nav.jsp"/>

<button id="FClick" class="tablinks" onclick="openList(event, 'listCourse')">หลักสูตร</button>
<button class="tablinks" onclick="openList(event, 'listInvoice')">ที่ต้องชำระเงิน</button>

<div class="tabcontent" id="listCourse">
    <h1>My list Course</h1>
    <h1>Username : ${mem_username.firstName} &nbsp; ${mem_username.lastName}</h1>
    <table>
        <c:forEach var="invoice" items="${list_invoice}">
            <c:if test="${invoice.pay_status == true}">
            <tr>
                <td>${invoice.register.requestOpenCourse.course.name}</td>
                <c:set var="txtstt" value="${invoice.register.study_result}"></c:set>
                <c:if var="stt" test="${txtstt == false}">
                    <c:set var="txtstt" value="อยู่ระหว่างเรียน"></c:set>
                </c:if>
                <c:if var="stt" test="${txtstt == true}">
                    <c:set var="txtstt" value="ผ่านหลักสูตร"></c:set>
                </c:if>
                <td style="width: 200px;">${txtstt}</td>
                <td>
                    <a href="${pageContext.request.contextPath}/member/${invoice.register.member.username}/certificate">
                        <button>ดูเกียรติบัตร</button>
                    </a>
                </td>
            </tr>
            </c:if>
        </c:forEach>
    </table>
</div>

<div class="tabcontent" id="listInvoice">
    <h1>Invoice</h1>
    <table>
        <c:forEach var="invoices" items="${list_invoice}">
            <c:if test="${invoices.pay_status == false}">
                <tr>
                    <td style="width: 350px;">${invoices.register.requestOpenCourse.course.name}</td>
                    <td style="width: 100px">
                        <a href="${pageContext.request.contextPath}/member/${invoices.register.member.username}/payment_detail/${invoices.invoice_id}"><button>ชำระเงิน</button></a>
                    </td>
                    <td>
                        <input type="button" value="ยกเลิก"
                               onclick="if((confirm('คุณแน่ใจหรือว่าต้องการลบ?')))
                                       { window.location.href='${pageContext.request.contextPath}/member/${invoices.register.member.username}/${invoices.register.register_id}/delete';
                                       return false; }"/>
                    </td>
                </tr>
            </c:if>
        </c:forEach>
    </table>
</div>
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
