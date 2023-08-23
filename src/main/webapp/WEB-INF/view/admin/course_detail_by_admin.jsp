<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="lifelong.model.*" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>${course_detail.name}</title>
    <jsp:include page="/WEB-INF/view/layouts/detail-all-style.jsp"/>
<%--    <link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet">--%>
<%--    <link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet">--%>
    <link href="${pageContext.request.contextPath}/assets/css/course_detail.css" rel="stylesheet">
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
                    <a href="${pageContext.request.contextPath}/" class="nav-item nav-link">หน้าหลัก</a>
                    <a href="#" class="nav-item nav-link">เกี่ยวกับคณะ</a>
                        <%--            <div class="nav-item dropdown">--%>
                        <%--                <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">หลักสูตรการอบรม</a>--%>
                    <a href="${pageContext.request.contextPath}/course/<%=admin.getUsername()%>/list_all_course" class="nav-item nav-link active">หลักสูตรทั้งหมด</a>
                    <a href="#" class="nav-item nav-link">ข่าวสารและกิจกรรม</a>
                    <a href="#" class="nav-item nav-link">Admin</a>
                    <a href="${pageContext.request.contextPath}/doLogout" class="nav-item nav-link">ออกจากระบบ</a>

                        <%--            <a href="${pageContext.request.contextPath}/login" class="nav-item nav-link">เข้าสู่ระบบ</a>--%>
                </div>
            </div>
        </nav>
        <!-- Navbar End -->
        <c:set var="object" value="${course_detail.object}"></c:set>
        <c:set var="parts" value="${fn:split(object, '$%')}" />
        <div class="block_position">
            <h1>
                    ${course_detail.name}
            </h1>

            <!--Major name--->
            <div>
                <p>${course_detail.major.name}</p>
            </div>

            <!--Image--->
            <div>
                <img src="${pageContext.request.contextPath}/assets/img/course_img/${course_detail.img}" alt="course_image" class="c_img">
            </div>
            <br>
            <!--Detail-->
            <div>
                <h1>คำอธิบายหลักสูตร</h1>
                <div>
            <span>
                    ${course_detail.principle}
            </span>
                </div>
                <br>
                <hr>
                <!---Sub_Detail-->
                <table>
                    <tr>
                        <td class="t1">หมวดสาขาวิชา</td>
                        <td class="t2">${course_detail.major.name}</td>
                    </tr>
                    <tr>
                        <td class="t1">ชื่อเกียรติบัตร</td>
                        <td class="t2">${course_detail.certificateName}</td>
                    </tr>
                    <tr>
                        <c:set var="count" value="0"></c:set>
                        <td class="t1">วัตถุประสงค์</td>
                        <td class="t2">
                            <c:forEach items="${parts}" var="part">
                                <c:set var="count" value="${count+1}"></c:set>
                                ${count} )  <c:out value="${part}"/><br/>
                            </c:forEach>
                        </td>
                    </tr>
                    <td class="t1">ระยะเวลาเรียน</td>
                    <td class="t2">${course_detail.totalHours} ชั่วโมง</td>
                    </tr>
                    <tr>
                        <td class="t1">เป้าหมายกลุ่มอาชีพ</td>
                        <td class="t2">${course_detail.targetOccupation}</td>
                    </tr>
                    <tr>
                        <td class="t1">ค่าธรรมเนียม</td>
                        <td class="t2">${course_detail.fee}0 บาท</td>
                    </tr>
                    <tr>
                        <td class="t1">ลิ้งค์หลักสูตร</td>
                        <td class="t2">${course_detail.linkMooc}</td>
                    </tr>
                    <tr>
                        <td class="t1">เนื้อหาของหลักสูตร</td>
                        <td class="t2"><a href="${pageContext.request.contextPath}/assets/file/${course_detail.file}" download>เอกสารประกอบการเรียน.pdf</a></td>
                    </tr>
                    <tr style="color: black">
                        <td align="center"><a href="${pageContext.request.contextPath}/course/list_all_course"><button>ย้อนกลับ</button></a></td>
                        <td align="center"><a href="${pageContext.request.contextPath}/course/${course_detail.course_id}/edit_course"><button>แก้ไข</button></a></td>
                    </tr>
                </table>
            </div>
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
</html>
