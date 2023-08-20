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
    <table class="container">
        <tr align="center">
            <td class="lec_detail" align="left">
                <div class="list_course_detail">
                    <h1>รายการการร้องขอ</h1>
                </div>
            </td>
            <td class="list_course" align="left">
                <div class="list_course_detail" align="center">
                    <h1 align="left">รายการการร้องขอ</h1>
                    <div class="hr_line"></div>
                    <button id="FClick" class="tablinks" onclick="openList(event, 'course')">หลักสูตร</button>
                    <button class="tablinks" onclick="window.location.href='${pageContext.request.contextPath}/lecturer/${lecturer_id}/add_roc'; return false;"class="add-button">ร้องขอ</button>
                    <button class="tablinks" onclick="openList(event, 'list_request')">รายการร้องขอ</button>

                </div>

                <div id="course" class="tabcontent">
                    <table class="table table-striped table-hover">
                        <tr style="color: black">
                            <td class="td_request">รายละเอียดหลักสูตร</td>
                            <td class="td_certificate" align="center">ตัวอย่างเกียรติบัตร</td>
                            <td class="td_edit" align="center">รายละเอียดคำร้อง</td>
                            <td class="td_cancel" align="center">ยกเลิกการร้องขอ</td>
                        </tr>

                        <c:forEach var="request_course" items="${requests_open_course}">
                            <c:if test="${request_course.requestStatus == 'ผ่าน'}">
                                <tr style="color: black">
                                    <td><p>${request_course.course.name}</p></td>
                                    <td><p>ดูตัวอย่าง</p></td>
                                    <td align="center"><a href="${pageContext.request.contextPath}/lecturer/${lecturer_id}/view_approve_request_open_course/${request_course.request_id}">ดูรายละเอียด</a></td>
                                    <td align="center">
                                        <input type="button" value="ผู้สมัคร"
                                               onclick="window.location.href='${pageContext.request.contextPath}/lecturer/${lecturer_id}/${request_course.request_id}/list_member_to_approve'; return false;"
                                        />
                                    </td>
                                </tr>
                            </c:if>
                        </c:forEach>
                    </table>
                </div>

                <div id="request" class="tabcontent">
                    <h3>Paris</h3>
                    <p>Paris is the capital of France.</p>
                </div>

                <div id="list_request" class="tabcontent">
                    <table class="table table-striped table-hover">
                        <tr style="color: black">
                            <td class="td_request">รายละเอียดการร้องขอ</td>
                            <td class="td_edit" align="center">รายละเอียดคำร้อง</td>
                            <td class="td_cancel" align="center">ยกเลิกการร้องขอ</td>
                        </tr>

                        <c:forEach var="request_course" items="${requests_open_course}">
                            <c:if test="${request_course.requestStatus == 'รอดำเนินการ'}">
                                <tr style="color: black">
                                    <td><p>${request_course.course.name}</p></td>
                                    <td align="center"><a href="${pageContext.request.contextPath}/lecturer/${lecturer_id}/view_request_open_course/${request_course.request_id}">ดูรายละเอียด</a></td>
                                    <td align="center">
                                        <input type="button" value="ยกเลิก"
                                               onclick="if((confirm('คุณแน่ใจหรือว่าต้องการลบการร้องขอนี้?'))) { window.location.href='${pageContext.request.contextPath}/lecturer/${lecturer_id}/${request_course.request_id}/delete_request_open_course'; return false; }"
                                               class="cancel-button"/>
                                    </td>
                                </tr>
                            </c:if>
                        </c:forEach>
                    </table>
                </div>

            </td>
        </tr>

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
