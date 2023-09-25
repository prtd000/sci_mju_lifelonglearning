<%@ page import="lifelong.model.Admin" %>
<%@ page import="lifelong.model.Member" %>
<%@ page import="lifelong.model.Lecturer" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%--
  Created by IntelliJ IDEA.
  User: asus
  Date: 2/8/2566
  Time: 14:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/0.5.0-beta4/html2canvas.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.5.3/jspdf.debug.js" integrity="sha384-NaWTHo/8YCBYJ59830LTz/P4aQZK1sS0SneOgAvhsIl3zBu8r9RevNg5lHCHAuQ/" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css2?family=TH+Sarabun+New&display=swap">
    <jsp:include page="/WEB-INF/view/layouts/detail-all-style.jsp"/>

    <style>
        p{
            font-family: "TH Sarabun New", sans-serif;
        }
        .mem-name{
            position: absolute;
            font-weight: bold;
            font-size: 46px;
            color: black;
            top: 42%;
            left: 50%;
            transform: translate(-50%, -50%);
        }
        .course_name{
            position: absolute;
            font-weight: bold;
            font-size: 33px;
            color: black;
            top: 53%;
            left: 50%;
            transform: translate(-50%, -50%);
        }

        .lec-name{
            position: absolute;
            font-size: 21px;
            color: black;
            top: 67.5%;
            left: 41%;
            transform: translate(-50%, -50%);
        }

        .btn-download-cer {
            width: 175px;
            height: 47px;
            border-radius: 16px;
            border: 0;
            font-size: 16px;
            font-weight: bold;
            background-color: #005f00;
            color: white;
            transition: 0.5s;
        }

        .btn-download-cer:hover {
            background-color: #0ca90c;
            transition: 0.5s;
        }
        .signature{
            height: 74px;
            position: absolute;
            top: 61%;
            left: 41.5%;
            transform: translate(-50%, -50%);
        }
        .name-assistant{
            position: absolute;
            font-size: 21px;
            color: black;
            top: 67.5%;
            left: 59.5%;
            transform: translate(-50%, -50%);
        }
        .sig-assistant{
            position: absolute;
            font-size: 26px;
            color: black;
            top: 63.5%;
            left: 59.5%;
            transform: translate(-50%, -50%);
        }
    </style>
</head>
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

<c:set var="flag" value="<%= flag %>"/>
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
<body>
<center>
    <br>
    <div id="content">
        <!-- นี่คือเนื้อหาที่คุณต้องการแปลงเป็น PDF -->
        <img src="${pageContext.request.contextPath}/assets/img/course_img/Certificate_Model.png" style="height: 520px" alt="certificate">
        <p class="mem-name">${register.member.firstName} &nbsp; ${register.member.lastName}</p>
        <p class="course_name">${register.requestOpenCourse.course.name}</p>
        <img class="signature" src="${pageContext.request.contextPath}/assets/img/request_open_course/signature/${register.requestOpenCourse.signature}"  alt="signature"/>
        <p class="lec-name">${register.requestOpenCourse.lecturer.position} &nbsp; ${register.requestOpenCourse.lecturer.firstName} &nbsp; ${register.requestOpenCourse.lecturer.lastName}</p>
        <p class="sig-assistant">ผศ.ดร.ฐปน ชื่นบาล</p>
        <p class="name-assistant">ผู้ช่วยศาสตราจารย์ ดร.ฐปน ชื่นบาล</p>

    </div>
    <br>
    <button id="downloadButton" class="btn-download-cer">ดาวน์โหลดเกียรติบัตร</button>

    <script>
        document.getElementById('downloadButton').addEventListener('click', function () {
            // แปลงรูปภาพเป็น Canvas
            var contentElement = document.getElementById('content');
            contentElement.style.marginTop = '-20px';

            html2canvas(document.getElementById('content')).then(function (canvas) {
                // นี่คือความกว้างและความสูงของ Canvas
                var canvasWidth = canvas.width - 1020; //บีบ width ให้แคบ
                var canvasHeight = canvas.height - 28;

                // สร้าง PDF โดยให้หน้ากระดาษ PDF มีขนาดแนวนอน (landscape)
                var pdf = new jsPDF({
                    encoding: 'UTF-8',
                    orientation: 'landscape',
                    unit: 'px',
                    format: [canvasWidth, canvasHeight] // ขนาด PDF ที่เท่ากับ Canvas
                });

                // เพิ่มรูปภาพเข้าใน PDF โดยใช้ขนาดเดียวกับ Canvas
                pdf.addImage(canvas.toDataURL('image/jpeg',1), 'JPEG', -342, 0, 1200 , 370);

                // บันทึก PDF หรือเปิดในหน้าต่างใหม่
                pdf.save('Certificate.pdf');

                contentElement.style.marginTop = '0';

            });
        });
    </script>
</center>
</body>
</html>
