<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 5/29/2023
  Time: 3:30 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>${course_detail.name}</title>
    <jsp:include page="/WEB-INF/view/layouts/detail-all-style.jsp"/>
<%--    <link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet">--%>

    <style>
        .block_position{
            margin-left: 350px;
            margin-top: 54px;
            width: 900px;
            display: inline-block;
        }

        .c_img{
            width: 850px;
        }

        .news_img{
            height: 180px;
            border-radius: 20px 10px 0px 0px;
        }

        .block_news{
            display: inline-block;
            background-color: burlywood;
            margin-bottom: 40px;
            border-radius: 20px;
            margin-left: 10px;
        }

        .news_content{
            padding: 15px;
        }

        .block_news_big{
            margin-top: 50px;
        }

        .block_lecturer{
            display: inline-block;
            position: absolute;
            margin-left: 940px;
            margin-top: -1565px;
        }

        .btn_register_course_detail{
            border-radius: 15px;
            background-color: #ff4900;
            color: white;
            font-weight: 600;
            width: 100%;
            height: 41px;
            border: 0;
        }
        .t1{
            width: 200px;
            font-weight: bold;
            margin-top: 0px;
            vertical-align: top;
        }
        .t2{
            width: 650px;
            vertical-align: top;
        }
        .div_title_name{
            width: 100px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis; /* แสดงเครื่องหมาย ... ตัดข้อความที่เกิน */
        }
        .title_name{
            display: inline-block;
            max-width: 100%; /* กำหนดความกว้างสูงสุดของข้อความ */
            overflow: hidden;
            text-overflow: ellipsis; /* แสดงเครื่องหมาย ... ตัดข้อความที่เกิน */
        }

    </style>
</head>
<body>
<jsp:include page="/WEB-INF/view/layouts/nav.jsp"/>
<%--${course_detail.name}--%>
<%--${course_detail.major.name}--%>
<%--${course_detail.course_id}--%>
<%--${course_detail.totalHours}--%>
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
                <td class="t2"><a href="${pageContext.request.contextPath}/assets/file/${course_detail.file}" download>เอกสารประกอบการเรียน.pdf</a></td>
            </tr>
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
