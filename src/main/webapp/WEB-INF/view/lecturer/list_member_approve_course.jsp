<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>${title}</title>
    <link href="${pageContext.request.contextPath}/assets/css/list_open_course_style.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet">
    <style>
        h1{
            font-family: 'Prompt', sans-serif;
            font-weight: 700 !important;
        }
    </style>
</head>
<body>
<div align="center">
    <h1>${title}</h1>
    <h3>รายชื่อผู้ที่ผ่านการสมัคร</h3>
        <table class="table table-striped table-hover">
        <tr style="color: black">
            <td class="td_request">รหัสบัตรประชาชน</td>
            <td class="td_edit">ชื่อ - นามสกุล</td>
            <td class="td_cancel" align="center">สถานะการอบรม</td>
            <td class="td_cancel" align="center"></td>
            <td class="td_cancel" align="center"></td>
        </tr>
        <c:forEach var="list" items="${registers}">
            <form action="${pageContext.request.contextPath}/lecturer/${request_id}/update_Status_Member_Result/${list.register_id}" method="POST">            <tr>
                <td>${list.member.idcard}</td>
                <td>${list.member.firstName} ${list.member.lastName}</td>
                <td align="center">
                    <c:set var="color" value="red"></c:set>
                    <c:set var="study_result" value="ไม่ผ่านหลักสูตร"></c:set>
                    <c:if test="${list.study_result == true}">
                        <c:set var="color" value="green"></c:set>
                        <c:set var="study_result" value="ผ่านหลักสูตร"></c:set>
                    </c:if>
                    <p style="color: ${color}">${study_result}</p>
                </td align="center">
<%--                <td>--%>
<%--                    ${list.invoice.pay_status}--%>
<%--                </td>--%>
                <td align="center">
                    <input type="submit" name="studyResult" value="ผ่านหลักสูตร"/>
                </td>
                <td align="center">
                    <input type="submit" name="studyResult" value="ไม่ผ่านหลักสูตร"/>
                </td>
            </tr>
            </form>
        </c:forEach>
    </table>
    <input type="button" value="ย้อนกลับ"
           onclick="window.location.href='${pageContext.request.contextPath}/lecturer/${lecturer_id}/list_request_open_course'; return false;"
           class="cancel-button"/>
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
