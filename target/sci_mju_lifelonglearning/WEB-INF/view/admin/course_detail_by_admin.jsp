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

<jsp:include page="/WEB-INF/view/layouts/footer.jsp"/>
</body>
</html>
