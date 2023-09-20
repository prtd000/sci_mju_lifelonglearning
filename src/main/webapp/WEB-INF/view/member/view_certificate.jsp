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
    <link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css2?family=TH+Sarabun+New&display=swap">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <jsp:include page="/WEB-INF/view/layouts/detail-all-style.jsp"/>

    <style>
        body, p{
            font-family: "TH Sarabun New", sans-serif;
        }
        .mem-name{
            position: absolute;
            font-weight: bold;
            font-size: 46px;
            color: black;
            margin-top: -342px;
            margin-left: 645px;
        }
        .course_name{
            position: absolute;
            font-weight: bold;
            font-size: 39px;
            color: black;
            margin-top: -245px;
            margin-left: 533px;
        }

        .lec-name{
            position: absolute;
            font-size: 21px;
            color: black;
            margin-top: -114px;
            margin-left: 534px;
        }

        .btn-download-cer {
            width: 175px;
            height: 47px;
            border-radius: 16px;
            border: 0;
            font-size: 24px;
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
            margin-top: 331px;
            margin-left: -570px;
        }
        .name-assistant{
            position: absolute;
            font-size: 21px;
            color: black;
            margin-top: -112px;
            margin-left: 824px;
        }
        .sig-assistant{
            position: absolute;
            font-size: 26px;
            color: black;
            font-weight: bold;
            margin-top: -150px;
            margin-left: 861px;
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
<body>
<center>
    <br>
    <div id="content">
        <!-- นี่คือเนื้อหาที่คุณต้องการแปลงเป็น PDF -->
        <img src="${pageContext.request.contextPath}/assets/img/course_img/Certificate_Model.png" style="height: 520px">
        <p class="mem-name">${register.member.firstName} &nbsp; ${register.member.lastName}</p>
        <p class="course_name">${register.requestOpenCourse.course.name}</p>
        <img class="signature" src="${pageContext.request.contextPath}/assets/img/request_open_course/signature/${register.requestOpenCourse.signature}" />
        <p class="lec-name">${register.requestOpenCourse.lecturer.position} &nbsp; ${register.requestOpenCourse.lecturer.firstName} &nbsp; ${register.requestOpenCourse.lecturer.lastName}</p>
        <p class="sig-assistant">ดร.ฐปน ชื่นบาล</p>
        <p class="name-assistant">ผู้ช่วยศาสตราจารย์ ดร.ฐปน ชื่นบาล</p>

    </div>
    <br>
    <button id="downloadButton" class="btn-download-cer">ดาวน์โหลดเกียรติบัตร</button>

    <script>
        document.getElementById('downloadButton').addEventListener('click', function () {
            // แปลงรูปภาพเป็น Canvas
            html2canvas(document.getElementById('content')).then(function (canvas) {
                // นี่คือความกว้างและความสูงของ Canvas
                var canvasWidth = canvas.width - 772;
                var canvasHeight = canvas.height;
                console.log('canvasWidth' + canvas.width)
                console.log('canvasHeight' + canvas.height)

                // สร้าง PDF โดยให้หน้ากระดาษ PDF มีขนาดแนวนอน (landscape)
                var pdf = new jsPDF({
                    encoding: 'UTF-8',
                    orientation: 'landscape',
                    unit: 'px',
                    format: [canvasWidth, canvasHeight] // ขนาด PDF ที่เท่ากับ Canvas
                });

                // เพิ่มรูปภาพเข้าใน PDF โดยใช้ขนาดเดียวกับ Canvas
                pdf.addImage(canvas.toDataURL('image/jpg',2), 'JPG', -313, 0, 1200 , 390);

                // บันทึก PDF หรือเปิดในหน้าต่างใหม่
                pdf.save('Certificate.pdf');
            });
        });
        // เมื่อคลิกที่ปุ่ม "ดาวน์โหลด PDF"
        // document.getElementById('downloadButton').addEventListener('click', function () {
        //     // แปลงรูปภาพเป็น Canvas
        //     html2canvas(document.getElementById('content')).then(function (canvas) {
        //         // นี่คือความกว้างและความสูงของ Canvas
        //         var canvasWidth = canvas.width - 772;
        //         var canvasHeight = canvas.height;
        //         console.log('canvasWidth' + canvas.width)
        //         console.log('canvasHeight' + canvas.height)
        //
        //         // สร้าง PDF โดยให้หน้ากระดาษ PDF มีขนาดแนวนอน (landscape)
        //         var pdf = new jsPDF({
        //             orientation: 'landscape',
        //             unit: 'px', // หน่วยเป็นมิลลิเมตร
        //             format: [canvasWidth, canvasHeight] // ขนาด PDF ที่เท่ากับ Canvas
        //         });
        //
        //         // เพิ่มรูปภาพเข้าใน PDF โดยใช้ขนาดเดียวกับ Canvas
        //         pdf.addImage(canvas.toDataURL('image/jpg'), 'JPG', -313, 0, 1200 , 390);
        //
        //         // บันทึก PDF หรือเปิดในหน้าต่างใหม่
        //         pdf.save('Certificate.pdf');
        //     });
        // });

    </script>
</center>

<%--pdf.addImage(canvas.toDataURL('image/png'), 'PNG', 0, 0, 529.166667 , 374.120833);--%>
</body>
</html>
