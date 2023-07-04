<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>
<head>
    <title>${title}</title>
    <jsp:include page="/WEB-INF/view/layouts/detail-all-style.jsp"/>
    <%--    <link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet">--%>
    <%--    <link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet">--%>
    <link href="${pageContext.request.contextPath}/assets/css/best.css" rel="stylesheet">

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
<jsp:include page="/WEB-INF/view/layouts/nav.jsp"/>

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
            </tr>
        </table>
    </div>
    <br>
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
    <form:form action="${pageContext.request.contextPath}/member/${member_id}/register_course/${course_id}/${request_op_course.request_id}/register" modelAttribute="register" method="GET">
        <div>
            <%
                Date currentDate = new Date();
                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd");
                String date = dateFormat.format(currentDate);

                int std_result = 0;
                int registerID = 0;
            %>

            <p>RegisterID (PK) : <%=registerID%></p><br>
            <p>Current Date : <%=date%></p><br>
            <p>Study_result : <%=std_result%></p><br>
            <p>RequestID (FK) : ${request_op_course.request_id}</p><br>
            <p>MemberID (FK) : ${member_id}</p>
            <br>
            <input type="submit" value="register"/>
        </div>
        <%

        %>
    </form:form>
</div>


<jsp:include page="/WEB-INF/view/layouts/footer.jsp"/>
</body>
</html>
