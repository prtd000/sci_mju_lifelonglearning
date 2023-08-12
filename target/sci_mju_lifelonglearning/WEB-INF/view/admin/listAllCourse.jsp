<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.text.SimpleDateFormat" %>
<html>
<head>
    <title>${title}</title>
<%--    <link href="${pageContext.request.contextPath}/assets/css/list_open_course_style.css" rel="stylesheet">--%>
    <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/list_all_course.css" rel="stylesheet">
    <style>
        h1{
            font-family: 'Prompt', sans-serif;
            font-weight: 700 !important;
        }
    </style>
    <jsp:include page="/WEB-INF/view/layouts/detail-all-style.jsp"/>
</head>
<body>
<jsp:include page="/WEB-INF/view/layouts/nav.jsp"/>
<div align="center">
    <h1>${title}</h1>
    <table class="container">
        <tr align="center">
<%--            <td class="lec_detail" align="left">--%>
<%--                <div class="list_course_detail">--%>
<%--                    <h1>รายการการร้องขอ</h1>--%>
<%--                </div>--%>
<%--            </td>--%>
            <td class="list_course" align="left">
                <div class="list_course_detail" align="center">
<%--                    <h1 align="left">รายการการร้องขอ</h1>--%>
                    <div class="hr_line"></div>
                    <button id="FClick" class="tablinks" onclick="openList(event, 'course')">หลักสูตร</button>
                    <button class="tablinks" onclick="openList(event, 'request_course_Active')">หลักสูตรที่กำลังเปิดสอน</button>
                    <button class="tablinks" onclick="openList(event, 'list_request')">รายการร้องขอ</button>
                    <button class="tablinks" onclick="openList(event, 'Activity_News')">ข่าวสารและกิจกรรม</button>

                </div>
                <%--DIV แรก--%>
                <div id="course" class="tabcontent">
                    <h3>หลักสูตรทั้งหมด</h3>
                    <a href="${pageContext.request.contextPath}/course/add_course"><button>เพิ่มหลักสูตร</button></a>
                    <table class="table table-striped table-hover">
                        <tr style="color: black">
                            <td class="td_course_name">ชื่อหลักสูตร</td>
                            <td class="td_status"></td>
                            <td class="td_list_member"></td>
                            <td class="td_detail"></td>
                        </tr>

                        <c:forEach var="course" items="${courses}">
                            <tr style="color: black">
                                <td><p>${course.name}</p></td>
                                <td><p>${course.status}</p></td>
                                <td align="center"><a><button>ดูรายชื่อ</button></a></td>
                                <td align="center"><a href="${pageContext.request.contextPath}/course/${course.course_id}/course_detail"><button>ดูรายละเอียด</button></a></td>
                            </tr>
                        </c:forEach>
                    </table>
                </div>
                <%--DIV ที่ 2--%>
                <div id="request_course_Active" class="tabcontent">
                    <h3>หลักสูตรที่กำลังเปิดสอน</h3>
                    <table class="table table-striped table-hover">
                        <tr style="color: black">
                            <td class="td_request">ชื่อหลักสูตร</td>
                            <td class="td_edit" align="center"></td>
                            <td class="td_cancel" align="center"></td>
                        </tr>

                        <c:forEach var="request_course" items="${requests_open_course}">
                            <c:if test="${request_course.requestStatus == true}">
                                <tr style="color: black">
                                    <td><p>${request_course.course.name}</p></td>
                                    <td align="center">
                                        <input type="button" value="ผู้เข้าร่วม" onclick="window.location.href='${pageContext.request.contextPath}/course/${request_course.request_id}/list_member_to_course'; return false;"/>
                                    </td>
                                    <td align="center">
                                        <input type="button" value="ดูรายละเอียด"
                                               onclick="window.location.href='${pageContext.request.contextPath}/course/view_approve_request_open_course/${request_course.request_id}'; return false;"/>
                                    </td>
                                </tr>
                            </c:if>
                        </c:forEach>
                    </table>
                </div>
                <%--DIV ที่ 3--%>
                <div id="list_request" class="tabcontent">
                    <h3>รายการร้องขอ</h3>
                    <table class="table table-striped table-hover">
                        <tr style="color: black">
                            <td class="td_request">รายละเอียดการร้องขอ</td>
                            <td class="td_edit" align="center">วันที่ร้องขอ</td>
                            <td class="td_cancel" align="center"></td>
                        </tr>

                        <c:forEach var="request_course" items="${requests_open_course}">
                            <c:if test="${request_course.requestStatus == false}">
                                <tr style="color: black">
                                    <td><p>${request_course.course.name}</p></td>
                                    <td align="center">${request_course.requestDate}</td>
                                    <td align="center">
                                        <input type="button" value="ดูรายละเอียด"
                                               onclick="window.location.href='${pageContext.request.contextPath}/course/view_request_open_course/${request_course.request_id}'; return false;"/>
                                    </td>
                                </tr>
                            </c:if>
                        </c:forEach>
                    </table>
                </div>
                <%--DIV ที่ 4--%>
                <div id="Activity_News" class="tabcontent">
                    <h3>ข่าวสารและกิจกรรม</h3>
                    <input type="button" value="ข่าวสาร"onclick="window.location.href='${pageContext.request.contextPath}/activity/public/add_activity'; return false;"class="add-button"/>
                    <table class="table table-striped table-hover">
                        <tr style="color: black">
                            <td class="td_request">รายการข่าว</td>
                            <td class="td_edit" align="center">วันที่ออกข่าว</td>
                            <td class="td_cancel" align="center"></td>
                            <td class="td_cancel" align="center"></td>
                        </tr>
                        <c:forEach var="list" items="${list_activities}">
                            <tr>
                                <td>${list.name}</td>
                                <td>${list.date}</td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/activity/public/${list.ac_id}/view_page"><button>ดูรายละเอียด</button></a>
                                </td>
                                <td>
                                    <input type="button" value="ยกเลิก"
                                           onclick="if((confirm('คุณแน่ใจหรือว่าต้องการลบข่าวสารนี้?'))) { window.location.href='${pageContext.request.contextPath}/activity/${list.ac_id}/delete'; return false; }"
                                           class="cancel-button"/>
                                </td>
                            </tr>
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
