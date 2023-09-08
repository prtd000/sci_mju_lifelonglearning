<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="lifelong.model.Admin" %>
<%@ page import="lifelong.model.Member" %>
<%@ page import="lifelong.model.Lecturer" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<html>
<head>
    <title>${title}</title>
    <jsp:include page="/WEB-INF/view/layouts/detail-all-style.jsp"/>
    <%--    <link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet">--%>

    <%--    <style>--%>
    <%--        .block_position{--%>
    <%--            margin-left: 350px;--%>
    <%--            margin-top: 54px;--%>
    <%--            width: 900px;--%>
    <%--            display: inline-block;--%>
    <%--        }--%>

    <%--        .c_img{--%>
    <%--            width: 850px;--%>
    <%--        }--%>
    <%--        .t1{--%>
    <%--            width: 200px;--%>
    <%--            font-weight: bold;--%>
    <%--            margin-top: 0px;--%>
    <%--            vertical-align: top;--%>
    <%--        }--%>
    <%--        .t2{--%>
    <%--            width: 650px;--%>
    <%--            vertical-align: top;--%>
    <%--        }--%>

    <%--    </style>--%>
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
    }else if (lecturer != null) {
        flag = "lecturer";
    } else if (member != null) {
        flag = "member";
    }else {
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

<div class="block_position">
    <h1>${course_detail.name}</h1>
    <!--Major name--->
    <div>
        <p>${course_detail.major.name}</p>
    </div>

    <!--Image--->
    <div>
        <img src="${pageContext.request.contextPath}/assets/img/course_img/${course_detail.img}" alt="course_image"
             class="c_img">
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
                <td class="t1">ชื่อเกีตรติบัตร</td>
                <td class="t2">${course_detail.certificateName}</td>
            </tr>
            <tr>
                <td class="t1">วัตถุประสงค์</td>

                <td class="t2">${course_detail.object}</td>
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
                <td class="t2"><a href="${pageContext.request.contextPath}/assets/file/${course_detail.file}" download>เอกสารประกอบการเรียน.pdf</a>
                </td>
            </tr>
        </table>
    </div>
    <br>
<%--    <form:form action="${pageContext.request.contextPath}/member/${member_id}/register_course/${course_id}/${request_op_course.request_id}/register" modelAttribute="register" method="GET">--%>
<%--        <div>--%>
<%--            <%--%>
<%--                Date currentDate = new Date();--%>
<%--                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd");--%>
<%--                String date = dateFormat.format(currentDate);--%>

<%--                int std_result = 0;--%>
<%--                int registerID = 0;--%>
<%--            %>--%>

<%--            <p>RegisterID (PK) : <%=registerID%></p><br>--%>
<%--            <p>Current Date : <%=date%></p><br>--%>
<%--            <p>Study_result : <%=std_result%></p><br>--%>
<%--            <p>RequestID (FK) : ${request_op_course.request_id}</p><br>--%>
<%--            <p>MemberID (FK) : ${member_id}</p>--%>
<%--            <br>--%>
<%--            <input type="submit" value="register"/>--%>
<%--        </div>--%>
<%--    </form:form>--%>

    <button onclick="if((confirm('ยืนยันการลงทะเบียน'))){ window.location.href='${pageContext.request.contextPath}/member/<%=member.getUsername()%>/register_course/${request_op_course.course.course_id}/${request_op_course.request_id}/register';return false; }">สมัคร</button>
    <br>
<%--    Course News--%>
    <c:forEach var="list" items="${activity}">
        <div class="block_news_big" style="float: left">
            <h1>ข่าวสารเกี่ยวกับหลักสูตร</h1>
            <div class="block_news">
<%--                <c:set var="imgNames" value="${list.img}"/>--%>
<%--                <c:forEach var="listImg" items="${fn:split(imgNames, ',')}">--%>
<%--                    <c:set var="listImg" value="${fn:replace(fn:replace(fn:replace(listImg, '\"', ''), '[', ''), ']', '')}"/>--%>
<%--                    <td><img src="${pageContext.request.contextPath}/assets/img/activity/public/${list.ac_id}/${listImg}" alt="News_img" class="news_img"></td>--%>
<%--                </c:forEach>--%>
<%--                <div><img src="img/banner1.jpeg" alt="News_img" class="news_img"></div>--%>
                <div class="news_content">
                    <h1>${list.name}</h1>
                    <h4>${list.type}</h4>
                    <p>${list.detail}</p>
                    <p>${list.date}</p>
                </div>
            </div>
        </div>
    </c:forEach>
</div>


<jsp:include page="/WEB-INF/view/layouts/footer.jsp"/>
</body>
</html>
