<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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
<jsp:include page="/WEB-INF/view/layouts/nav.jsp"/>
<%--${course_detail.name}--%>
<%--${course_detail.major.name}--%>
<%--${course_detail.course_id}--%>
<%--${course_detail.totalHours}--%>
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
        </table>
    </div>
    <!--Course News--->
<%--    <div class="block_news_big">--%>
<%--        <h1>ข่าวสารเกี่ยวกับหลักสูตร</h1>--%>
<%--        <div class="block_news">--%>
<%--            <div><img src="${pageContext.request.contextPath}/assets/img/banner1.jpeg" alt="News_img" class="news_img"></div>--%>
<%--            <div class="news_content">--%>
<%--                <h1>Title</h1>--%>
<%--                <p>1 มีนาคม 2566</p>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--        <div class="block_news">--%>
<%--            <div><img src="${pageContext.request.contextPath}/assets/img/banner1.jpeg" alt="News_img" class="news_img"></div>--%>
<%--            <div  class="news_content">--%>
<%--                <h1>Title</h1>--%>
<%--                <p>1 มีนาคม 2566</p>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--        <div class="block_news">--%>
<%--            <div><img src="${pageContext.request.contextPath}/assets/img/banner1.jpeg" alt="News_img" class="news_img"></div>--%>
<%--            <div  class="news_content">--%>
<%--                <h1>Title</h1>--%>
<%--                <p>1 มีนาคม 2566</p>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--        <div class="block_news">--%>
<%--            <div><img src="${pageContext.request.contextPath}/assets/img/banner1.jpeg" alt="News_img" class="news_img"></div>--%>
<%--            <div  class="news_content">--%>
<%--                <h1>Title</h1>--%>
<%--                <p>1 มีนาคม 2566</p>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--    </div>--%>

    <!---Lecturer Data---->
<%--    <div class="block_lecturer">--%>
<%--        <h4>อาจารย์ผู้รับผิดชอบหลักสูตร</h4>--%>
<%--        <div>--%>
<%--            <table>--%>
<%--                <tr>--%>
<%--                    <td>icon</td>--%>
<%--                    <td>อ.ดร.ฐาปนพงษ์ รักกาญจนันท์</td>--%>
<%--                </tr>--%>
<%--                <tr>--%>
<%--                    <td>icon</td>--%>
<%--                    <td>คณะวิทยาศาสตร์</td>--%>
<%--                </tr>--%>
<%--                <tr>--%>
<%--                    <td>icon</td>--%>
<%--                    <td>การเรียนรูปแบบ Online</td>--%>
<%--                </tr>--%>
<%--            </table>--%>
<%--            <a href="" class="btn btn-primary py-md-3 px-md-5 me-3">ลงทะเบียน</a>--%>
<%--&lt;%&ndash;            <button class="btn_register_course_detail">ลงทะเบียน</button>&ndash;%&gt;--%>
<%--        </div>--%>
<%--    </div>--%>
</div>

<jsp:include page="/WEB-INF/view/layouts/footer.jsp"/>
</body>
</html>
