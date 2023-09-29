<%@ page import="lifelong.model.*" %>
<%@ page import="java.util.Date" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>${title}</title>
    <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet">
<%--    <link href="${pageContext.request.contextPath}/assets/css/lecturer/list_request_open_course.css" rel="stylesheet">--%>
    <jsp:include page="/WEB-INF/view/layouts/detail-all-style.jsp"/>
    <link href="${pageContext.request.contextPath}/assets/css/lecturer/list_request_open_course.css" rel="stylesheet">
<%--    <link href="${pageContext.request.contextPath}/assets/css/list_open_course_style.css" rel="stylesheet">--%>
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
                    <a href="#" class="nav-item nav-link" style="font-size: 18px">เกี่ยวกับคณะ</a>
                    <a href="${pageContext.request.contextPath}/search_course" class="nav-item nav-link" style="font-size: 18px">หลักสูตรการอบรม</a>
                    <a href="${pageContext.request.contextPath}/lecturer/<%=lecturer.getUsername()%>/list_request_open_course" class="nav-item nav-link active" style="font-size: 18px">รายการร้องขอ</a>
                    <a href="${pageContext.request.contextPath}/view_activity" class="nav-item nav-link" style="font-size: 18px">ข่าวสารและกิจกรรม</a>
                    <a href="#" class="nav-item nav-link" style="font-size: 18px">เกี่ยวกับเรา</a>
                    <a href="#" class="nav-item nav-link" style="font-size: 18px">อาจารย์ผู้รับผิดชอบหลักสูตร</a>
                    <a href="${pageContext.request.contextPath}/doLogout" class="nav-item nav-link" style="font-size: 18px">ออกจากระบบ</a>
                </div>
            </div>
        </nav>
        <!-- Navbar End -->

<div align="center" style="margin-top: 20px">
    <h1>${title}การร้องขอ</h1>
    <table class="container">
        <tr align="center">
            <td class="list_course" align="center">
                <div class="list_course_detail" align="center">

                        <div class="select_type" align="center">
                            <input type="radio" class="tablinks" name="options-base" onclick="openList(event, 'course')" id="FClick" autocomplete="off" checked>
                            <label class="btn" for="FClick">หลักสูตรของฉัน</label>

                            <input type="radio" class="tablinks" name="options-base" onclick="openList(event, 'list_request')" id="option6" autocomplete="off">
                            <label class="btn" for="option6">รายการร้องขอ</label>
                        </div>

<%--                    <button id="FClick" class="tablinks" onclick="openList(event, 'course')">หลักสูตร</button>--%>
<%--                    <button class="tablinks" onclick="window.location.href='${pageContext.request.contextPath}/lecturer/${lecturer_id}/add_roc'; return false;">ร้องขอ</button>--%>
<%--                    <button class="tablinks" onclick="openList(event, 'list_request')">รายการร้องขอ</button>--%>

                </div>

                <div id="course" class="tabcontent">
                    <table style="width: 100%; margin-top: 15px; margin-bottom: -10px">
                        <tr>
                            <td align="left" style="width: 50%"><h4><b>หลักสูตรของฉัน</b></h4></td>
                            <td align="right" style="width: 50%">
                                <button class="btn btn-outline-success" onclick="window.location.href='${pageContext.request.contextPath}/lecturer/${lecturer_id}/add_roc'; return false;">ร้องขอเปิดหลักสูตร</button>
                            </td>
                        </tr>
                    </table>
                    <hr>
                    <table class="table table-striped table-hover" style="font-size: 15px">
                        <tr style="color: black">
                            <td class="td_request">รายละเอียดหลักสูตร</td>
                            <td class="td_learn" align="center">ระยะเวลาเรียน</td>
                            <td class="td_certificate" align="center">ตัวอย่างเกียรติบัตร</td>
                            <td class="td_cancel" align="center">ผู้สมัคร</td>
                            <td class="td_edit" align="center">ข่าวสาร</td>
                            <td class="td_edit" align="center"></td>
                        </tr>

                        <c:forEach var="request_course" items="${requests_open_course}">
                            <c:if test="${request_course.requestStatus == 'ผ่าน'}">
                                <fmt:formatDate value="${request_course.startStudyDate}" pattern="dd/MM/yyyy" var="startStudyDate" />
                                <fmt:formatDate value="${request_course.endStudyDate}" pattern="dd/MM/yyyy" var="endStudyDate" />
                                <tr style="color: black">
                                    <td><p>${request_course.course.name}</p></td>
                                    <td align="center"><p>${startStudyDate} ถึง ${endStudyDate}</p></td>
                                    <td align="center">
                                        <a href="${pageContext.request.contextPath}/lecturer/${lecturer_id}/${request_course.request_id}/view_sample_certificate">ดูตัวอย่าง</a>
                                    </td>
                                    <td align="center">
                                        <a href="${pageContext.request.contextPath}/lecturer/${lecturer_id}/${request_course.request_id}/list_member_to_approve">
                                            <button class="button-5" role="button">${request_course.numberOfApprovedRegistrations}/${request_course.quantity}</button>
                                        </a>
                                    </td>
                                    <td align="center">
                                        <input type="button" value="เพิ่มข่าวสาร" class="activity-btn"
                                               onclick="window.location.href='${pageContext.request.contextPath}/lecturer/${request_course.request_id}/add_course_activity'; return false;"
                                        />
                                        <input type="button" value="รายการข่าวสาร" class="list-activity-btn"
                                               onclick="window.location.href='${pageContext.request.contextPath}/lecturer/${request_course.request_id}/list_course_activity_news'; return false;"
                                        />
                                    </td>
                                    <td align="center">
                                        <!-- เช็คว่าวันที่ applicationResult เลยหรือไม่ -->
                                        <%
                                            Date currentDate = new Date(); // วันปัจจุบัน
                                        %>
                                        <c:set var="currentDate1" value="<%=currentDate%>"/>
                                        <c:if test="${currentDate1 < request_course.applicationResult && request_course.numberOfAllRegistrations == 0}">
                                            <input type="button" value="ยกเลิก"
                                                   onclick="if((confirm('คุณแน่ใจหรือว่าต้องการลบหลักสูตรนี้?'))) { window.location.href='${pageContext.request.contextPath}/lecturer/<%=lecturer.getUsername()%>/${request_course.request_id}/cancel_request_open_course'; return false; }"
                                                   class="btn btn-outline-danger"/>
                                        </c:if>
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
                    <div align="left" style="width: 100%; margin-top: 15px;">
                        <h4><b>หลักสูตรที่ร้องขอ</b></h4>
                    </div>
                    <hr>
                    <table class="table table-striped table-hover" style="font-size: 15px">
                        <tr style="color: black">
                            <td class="td_request">รายละเอียดการร้องขอ</td>
                            <td class="td_roc" align="center">วันที่ร้องขอ</td>
                            <td class="td_learn" align="center">ระยะเวลาเรียน</td>
                            <td class="td_qty" align="center">จำนวน</td>
                            <td class="td_type" align="center">ประเภท</td>
                            <td class="td_lec" align="center">อาจารย์</td>
                            <td class="td_cancel" align="center"></td>
                        </tr>

                        <c:forEach var="request_course" items="${requests_open_course}">
                            <c:if test="${request_course.requestStatus == 'รอดำเนินการ'}">
                                <fmt:formatDate value="${request_course.requestDate}" pattern="dd/MM/yyyy" var="formattedDate" />
                                <fmt:formatDate value="${request_course.startStudyDate}" pattern="dd/MM/yyyy" var="startStudyDate" />
                                <fmt:formatDate value="${request_course.endStudyDate}" pattern="dd/MM/yyyy" var="endStudyDate" />
                                <tr style="color: black">
                                    <td><p>${request_course.course.name}</p></td>
                                    <td align="center">${formattedDate}</td>
                                    <td align="center"><p>${startStudyDate} ถึง ${endStudyDate}</p></td>
                                    <td align="center"><p>${request_course.quantity}</p></td>
                                    <td align="center"><p>${request_course.type_learn}</p></td>
                                    <td align="center"><p>${request_course.lecturer.firstName} ${request_course.lecturer.lastName}</p></td>
                                    <td align="center">
                                        <a href="${pageContext.request.contextPath}/lecturer/<%=lecturer.getUsername()%>/${request_course.request_id}/update_page">
                                            <button type="button" class="btn btn-outline-warning" style="font-size: 12px">
                                                <i style="color: #ff8d4e;" class="fa fa-edit" aria-hidden="true"></i> แก้ไข
                                            </button>
                                        </a>
                                        <input type="button" value="ยกเลิก" style="font-size: 12px"
                                               onclick="if((confirm('คุณแน่ใจหรือว่าต้องการลบการร้องขอนี้?'))) { window.location.href='${pageContext.request.contextPath}/lecturer/${lecturer_id}/${request_course.request_id}/delete_request_open_course'; return false; }"
                                               class="btn btn-outline-danger"/>
                                    </td>
                                </tr>
                            </c:if>
                        </c:forEach>
                    </table>

                    <br>
                    <br>
                    <div align="left" style="width: 100%; margin-top: 15px;">
                        <h4><b>หลักสูตรที่ไม่ผ่านการร้องขอ</b></h4>
                    </div>
                    <hr>
                    <table class="table table-striped table-hover" style="font-size: 15px">
                        <tr style="color: black">
                            <td class="td_request">รายละเอียดการร้องขอ</td>
                            <td class="td_roc" align="center">วันที่ร้องขอ</td>
                            <td class="td_learn" align="center">ระยะเวลาเรียน</td>
                            <td class="td_qty" align="center">จำนวน</td>
                            <td class="td_type" align="center">ประเภท</td>
                            <td class="td_lec" align="center">สถานะ</td>
                            <td class="td_cancel" align="center"></td>
                        </tr>

                        <c:forEach var="request_course" items="${requests_open_course}">
                            <c:if test="${request_course.requestStatus == 'ไม่ผ่าน'}">
                                <tr style="color: black">
                                    <td><p>${request_course.course.name}</p></td>
                                    <td align="center">${formattedDate}</td>
                                    <td align="center"><p>${startStudyDate} ถึง ${endStudyDate}</p></td>
                                    <td align="center"><p>${request_course.quantity}</p></td>
                                    <td align="center"><p>${request_course.type_learn}</p></td>
                                    <td align="center"><p style="color: red">ไม่ผ่าน</p></td>
                                    <td align="center">
                                        <a href="${pageContext.request.contextPath}/lecturer/<%=lecturer.getUsername()%>/${request_course.request_id}/update_page">
                                            <button type="button" class="btn btn-outline-warning" style="font-size: 12px">
                                                <i style="color: #ff8d4e;" class="fa fa-edit" aria-hidden="true"></i> แก้ไข
                                            </button>
                                        </a>
                                        <input type="button" value="ยกเลิก" style="font-size: 12px"
                                               onclick="if((confirm('คุณแน่ใจหรือว่าต้องการลบการร้องขอนี้?'))) { window.location.href='${pageContext.request.contextPath}/lecturer/${lecturer_id}/${request_course.request_id}/delete_request_open_course'; return false; }"
                                               class="btn btn-outline-danger"/>
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
<%-- เรียกใช้คำสั่ง Java เพื่อตรวจสอบว่ามีพารามิเตอร์ "error" หรือไม่ --%>
<% String errorParam = request.getParameter("error"); %>

<%-- ตรวจสอบว่ามีพารามิเตอร์ "error" และมีค่าเป็น "true" หรือไม่ --%>
<% if (errorParam != null && errorParam.equals("true")) { %>
<script>
    // แสดง alert ใน JavaScript
    alert("ไม่สามารถลบข้อมูลได้ เพราะมีผู้ที่สมัครหลักสูตรนี้อยู่");
</script>
<% } %>
</html>
