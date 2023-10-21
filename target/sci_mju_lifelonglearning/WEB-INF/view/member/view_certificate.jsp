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
    <title>Certificate</title>
<%--    <script src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/0.5.0-beta4/html2canvas.min.js"></script>--%>

    <script src="https://cdn.jsdelivr.net/npm/html2canvas@1.4.1/dist/html2canvas.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/jspdf-html2canvas@latest/dist/jspdf-html2canvas.min.js"></script>

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
            font-size: 35px;
            color: black;
            top: 45%;
            left: 50%;
            transform: translate(-50%, -50%);
        }
        .course_name{
            position: absolute;
            font-weight: bold;
            font-size: 25px;
            color: black;
            top: 58%;
            left: 50%;
            transform: translate(-50%, -50%);
        }

        .lec-name{
            position: absolute;
            font-size: 21px;
            color: black;
            top: 74%;
            left: 40%;
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
            height: 65px;
            position: absolute;
            top: 67%;
            left: 40%;
            transform: translate(-50%, -50%);
        }
        .name-assistant{
            position: absolute;
            font-size: 21px;
            color: black;
            top: 74%;
            left: 60.5%;
            transform: translate(-50%, -50%);
        }
        .sig-assistant{
            position: absolute;
            font-size: 26px;
            color: black;
            top: 69.5%;
            left: 60.5%;
            transform: translate(-50%, -50%);
        }
    </style>
</head>
<!-- Navbar Start -->
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

<c:set var="flag" value="<%= flag %>"/>
<c:choose>
    <c:when test="${flag.equals('member')}">
        <!-- Navbar Start -->
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
<%--                    <a href="#" class="nav-item nav-link" style="font-size: 17px">เกี่ยวกับคณะ</a>--%>
                        <%--            <div class="nav-item dropdown">--%>
                        <%--                <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">หลักสูตรการอบรม</a>--%>
                    <a href="${pageContext.request.contextPath}/search_course" class="nav-item nav-link " style="font-size: 17px">หลักสูตรการอบรม</a>
                        <%--                <div class="dropdown-menu m-0">--%>
                        <%--                    <a href="#" class="dropdown-item">Reskill/Upskill</a>--%>
                        <%--                    <a href="#" class="dropdown-item">อบรมระยะสั้น</a>--%>
                        <%--                </div>--%>
                        <%--            </div>--%>
                    <a href="${pageContext.request.contextPath}/member/<%=member.getUsername()%>/listcourse" class="nav-item nav-link active" style="font-size: 17px">หลักสูตรของฉัน</a>
                    <a href="${pageContext.request.contextPath}/view_activity" class="nav-item nav-link" style="font-size: 17px">ข่าวสารและกิจกรรม</a>
<%--                    <a href="#" class="nav-item nav-link" style="font-size: 17px">เกี่ยวกับเรา</a>--%>
                    <a href="${pageContext.request.contextPath}/member/<%=member.getUsername()%>/edit_profile" class="nav-item nav-link" style="font-size: 17px">ข้อมูลส่วนตัว</a>
                    <a href="${pageContext.request.contextPath}/doLogout" class="nav-item nav-link" style="font-size: 17px">ออกจากระบบ</a>
                </div>
            </div>
        </nav>
        <!-- Navbar End -->
    </c:when>
</c:choose>
<body>
<center>
    <br>

    <div id="content">
        <!-- นี่คือเนื้อหาที่คุณต้องการแปลงเป็น PDF -->
        <img src="${pageContext.request.contextPath}/assets/img/Certificate_Model.png" style="height: 520px" alt="certificate">
        <p class="mem-name">${register.member.firstName} &nbsp; ${register.member.lastName}</p>
        <p class="course_name">${register.requestOpenCourse.course.certificateName}</p>
        <img class="signature" src="${pageContext.request.contextPath}/uploads/request_open_course/signature/${register.requestOpenCourse.signature}"  alt="signature"/>
        <p class="lec-name">${register.requestOpenCourse.lecturer.position} &nbsp; ${register.requestOpenCourse.lecturer.firstName} &nbsp; ${register.requestOpenCourse.lecturer.lastName}</p>
        <p class="sig-assistant">ผศ.ดร.ฐปน ชื่นบาล</p>
        <p class="name-assistant">ผู้ช่วยศาสตราจารย์ ดร.ฐปน ชื่นบาล</p>
    </div>

    <br>
    <button id="downloadButton" class="btn-download-cer">ดาวน์โหลดเกียรติบัตร</button>

    <script>
        document.getElementById('downloadButton').addEventListener('click', function () {
            // แปลงรูปภาพเป็น Canvas
            html2canvas(document.getElementById('content')).then(function (canvas) {
                // นี่คือความกว้างและความสูงของ Canvas
                var canvasWidth = canvas.width - 1230; //บีบ width ให้แคบ
                var canvasHeight = canvas.height - 158//

                // สร้าง PDF โดยให้หน้ากระดาษ PDF มีขนาดแนวนอน (landscape)
                var pdf = new jsPDF({
                    encoding: 'UTF-8',
                    orientation: 'landscape',
                    unit: 'px',
                    format: [canvasWidth, canvasHeight] // ขนาด PDF ที่เท่ากับ Canvas
                });

                // เพิ่มรูปภาพเข้าใน PDF โดยใช้ขนาดเดียวกับ Canvas
                                                                     //(X และ Y ของรูปภาพใน PDF  , ขนาดของรูปภาพใน PDF)
                pdf.addImage(canvas.toDataURL('image/PNG',1), 'PNG', -281, 0, 1080 , 370);

                // บันทึก PDF หรือเปิดในหน้าต่างใหม่
                pdf.save('Certificate.pdf');
            });
        });
    </script>
</center>
</body>
</html>
