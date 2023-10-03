<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="lifelong.model.Admin" %>
<%@ page import="lifelong.model.Member" %>
<%@ page import="lifelong.model.Lecturer" %>
<html>
<head>
    <title>${title}</title>
<%--    <link href="${pageContext.request.contextPath}/assets/css/list_open_course_style.css" rel="stylesheet">--%>
    <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/admin/listAllCourse.css" rel="stylesheet">

    <jsp:include page="/WEB-INF/view/layouts/detail-all-style.jsp"/>
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
    <c:when test="${flag.equals('lecturer')}">
        <jsp:include page="/WEB-INF/view/lecturer/nav_lecturer.jsp"/>
    </c:when>
    <c:when test="${flag.equals('member')}">
        <jsp:include page="/WEB-INF/view/member/nav_member.jsp"/>
    </c:when>
    <c:when test="${flag.equals('null')}">
        <jsp:include page="/WEB-INF/view/layouts/nav.jsp"/>
    </c:when>
</c:choose>
<c:choose>
    <c:when test="${flag.equals('admin')}">
<% assert admin != null; %>
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
                            <a href="#" class="nav-item nav-link" style="font-size: 18px">เกี่ยวกับคณะ</a>
                            <a href="${pageContext.request.contextPath}/course/<%=admin.getUsername()%>/add_course" class="nav-item nav-link" style="font-size: 17px">เพิ่มหลักสูตร</a>
                            <a href="${pageContext.request.contextPath}/course/<%=admin.getUsername()%>/list_all_course" class="nav-item nav-link" style="font-size: 17px">หลักสูตรทั้งหมด</a>
                            <a href="${pageContext.request.contextPath}/course/<%=admin.getUsername()%>/list_request_open_course" class="nav-item nav-link active" style="font-size: 17px">รายการร้องขอ</a>
                            <a href="${pageContext.request.contextPath}/course/public/add_activity" class="nav-item nav-link" style="font-size: 17px">เพิ่มข่าวสารทั่วไป</a>
                            <a href="${pageContext.request.contextPath}/course/public/list_activity" class="nav-item nav-link" style="font-size: 17px">ข่าวสารและกิจกรรม</a>
                            <a href="#" class="nav-item nav-link" style="font-size: 17px">ผู้ดูแลระบบ</a>
                            <a href="${pageContext.request.contextPath}/doLogout" class="nav-item nav-link" style="font-size: 17px">ออกจากระบบ</a>
                        </div>
                    </div>
        </nav>
<!-- Navbar End -->
        <div align="center" class="main_container">
            <br>
            <br>
            <h1>${title}</h1>
            <table class="container">
                <tr align="center">
                    <td class="list_course" align="center">
                            <%--DIV ที่ 2--%>
                        <div id="list_request" class="tabcontent" align="left">
                            <h3>รายการร้องขอ</h3>
                            <hr>
                            <br>
                            <table class="table table-striped table-hover">
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
                                                <a href="${pageContext.request.contextPath}/course/${admin_id}/view_request_open_course/${request_course.request_id}">
                                                    <button class="button-35" role="button">รายละเอียด</button>
                                                </a>
                                            </td>
                                        </tr>
                                    </c:if>
                                </c:forEach>
                            </table>
                        </div>
                            <%--DIV ที่ 3--%>

                    </td>
                </tr>

            </table>
            <br>
            <br>
            <br>
            <br>
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
<br>
<br>
<br>
<br>
</body>
</html>
