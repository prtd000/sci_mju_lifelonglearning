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

    <h1>${req.course.name}</h1>
    <!--Major name--->
    <div>
        <p>${req.course.major.name}</p>
    </div>

    <!--Image--->
    <div>
        <img src="${pageContext.request.contextPath}/assets/img/course_img/${req.course.img}" alt="course_image"
             class="c_img">
    </div>
    <br>
    <!--Detail-->
    <div>
        <h1>คำอธิบายหลักสูตร</h1>
        <div>
        <span>
            ${req.course.principle}
        </span>
        </div>
        <br>
        <hr>
        <!---Sub_Detail-->
        <table>
            <tr>
                <td class="t1" style="width: 178px;">หมวดสาขาวิชา</td>
                <td class="t2">${req.course.major.name}</td>
            </tr>
            <tr>
                <td class="t1">ชื่อเกีตรติบัตร</td>
                <td class="t2">${req.course.certificateName}</td>
            </tr>
            <tr>
                <td class="t1">วัตถุประสงค์</td>

                <td class="t2">${req.course.object}</td>
            </tr>
            <td class="t1">ระยะเวลาเรียน</td>
            <td class="t2">${req.course.totalHours} ชั่วโมง</td>
            </tr>
            <tr>
                <td class="t1">เป้าหมายกลุ่มอาชีพ</td>
                <td class="t2">${req.course.targetOccupation}</td>
            </tr>
            <tr>
                <td class="t1">ค่าธรรมเนียม</td>
                <td class="t2">${req.course.fee} บาท</td>
            </tr>

            <c:choose>
                <c:when test="${req.type_learn.equals('เรียนออนไลน์')}">
                    <tr>
                        <td>ลิ้ง Mooc</td>
                        <td><a href="${pageContext.request.contextPath}/${req.linkMooc}">${req.linkMooc}</a></td>
                    </tr>
                </c:when>
                <c:when test="${req.type_learn.equals('เรียนในสถานศึกษา')}">
                    <tr>
                        <td>สถานที่เรียน</td>
                        <td>${req.location}</td>
                    </tr>
                </c:when>
                <c:when test="${req.type_learn.equals('เรียนทั้งออนไลน์และในสถานศึกษา')}">
                    <tr>
                        <td>ลิ้ง Mooc</td>
                        <td><a href="${pageContext.request.contextPath}/${req.linkMooc}">${req.linkMooc}</a></td>
                    </tr>
                    <tr>
                        <td>สถานที่เรียน</td>
                        <td>${req.location}</td>
                    </tr>
                </c:when>
            </c:choose>

            <tr>
                <td class="t1">เนื้อหาของหลักสูตร</td>
                <td class="t2"><a href="${pageContext.request.contextPath}/assets/file/${req.course.file}" download>เอกสารประกอบการเรียน.pdf</a>
                </td>
            </tr>
        </table>
    </div>
    <br>
<%--    Now--%>
    <c:if test="${registered == true}">
        <button style="color: red;
                       font-weight: bold;
                       border-radius: 20px;
                       height: 50px;
                       width: 150px;
                       background-color: #dfdfdf;"
                       disabled>ลงทะเบียนแล้ว
        </button>
    </c:if>
    <c:if test="${registered == false}">
        <button onclick="if((confirm('ยืนยันการลงทะเบียน'))){ window.location.href='${pageContext.request.contextPath}/member/<%=member.getUsername()%>/register_course/${req.course.course_id}/${req.request_id}/register';return false; }">สมัคร</button>
    </c:if>

    <br><br>
<%--    Course News--%>
    <c:choose>
        <c:when test="${activity.size() == 0}">
            <h1 style="display: none">ข่าวสารเกี่ยวกับหลักสูตร</h1>
        </c:when>
        <c:otherwise>
            <h1 style="display: block">ข่าวสารเกี่ยวกับหลักสูตร</h1>
        </c:otherwise>
    </c:choose>

    <c:forEach var="list" items="${activity}">
        <div class="block_news_big" style="float: left">
            <div class="block_news">
                <c:set var="imgNames" value="${list.img}"/>
                <c:forEach var="listImg" items="${fn:split(imgNames, ',')}">
                    <c:set var="listImg" value="${fn:replace(fn:replace(fn:replace(listImg, '\"', ''), '[', ''), ']', '')}"/>
                    <td><img src="${pageContext.request.contextPath}/assets/img/activity/private/${list.ac_id}/${listImg}" alt="News_img" class="news_img"></td>
                </c:forEach>
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
