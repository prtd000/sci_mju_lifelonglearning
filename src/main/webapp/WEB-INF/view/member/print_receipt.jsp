<%--
  Created by IntelliJ IDEA.
  User: asus
  Date: 9/17/2023
  Time: 3:09 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="lifelong.model.Admin" %>
<%@ page import="lifelong.model.Member" %>
<%@ page import="lifelong.model.Lecturer" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Receipt</title>
    <%--    <script src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/0.5.0-beta4/html2canvas.min.js"></script>--%>
    <%--    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.5.3/jspdf.debug.js"--%>
    <%--            integrity="sha384-NaWTHo/8YCBYJ59830LTz/P4aQZK1sS0SneOgAvhsIl3zBu8r9RevNg5lHCHAuQ/"--%>
    <%--            crossorigin="anonymous"></script>--%>
    <%--    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.12/jspdf.plugin.autotable.min.js"></script>--%>
    <%--    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>--%>

    <%--    bootstrap--%>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>

    <%--    jspdf--%>
    <%--    <script src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/0.5.0-beta4/html2canvas.min.js"></script>--%>

    <script src="https://cdn.jsdelivr.net/npm/html2canvas@1.4.1/dist/html2canvas.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/jspdf-html2canvas@latest/dist/jspdf-html2canvas.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.5.3/jspdf.debug.js"
            integrity="sha384-NaWTHo/8YCBYJ59830LTz/P4aQZK1sS0SneOgAvhsIl3zBu8r9RevNg5lHCHAuQ/"
            crossorigin="anonymous"></script>

    <!-- google font -->
    <link href="https://fonts.googleapis.com/css2?family=Mitr:wght@200&family=Prompt:wght@200&display=swap" rel="stylesheet">
    <jsp:include page="/WEB-INF/view/layouts/detail-all-style.jsp"/>

    <style>
        #pdfContent {
            width: fit-content;
            padding: 46px;
            border-radius: 15px;
            box-shadow: 0px 0px 5px 0px black;
            border: 0;
        }

        .blog-receipt {
            color: black;
            font-weight: bold;
            position: absolute;
            top: 57%;
            left: 50%;
            transform: translate(-50%, -50%);
        }

        .receipt_c_name{
            width: 440px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

    </style>
</head>
<body>
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
                    <a href="#" class="nav-item nav-link" style="font-size: 17px">เกี่ยวกับคณะ</a>
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
                    <a href="#" class="nav-item nav-link" style="font-size: 17px">เกี่ยวกับเรา</a>
                    <a href="${pageContext.request.contextPath}/member/<%=member.getUsername()%>/edit_profile" class="nav-item nav-link" style="font-size: 17px">ข้อมูลส่วนตัว</a>
                    <a href="${pageContext.request.contextPath}/doLogout" class="nav-item nav-link" style="font-size: 17px">ออกจากระบบ</a>
                </div>
            </div>
        </nav>
    </c:when>
</c:choose>
<!-- Navbar End -->

<center>
    <br>
    <button id="downloadButton" style="cursor: pointer;" class="btn btn-secondary">ดาวน์โหลด PDF</button>
    <br><br>

    <div id="pdfContent" style="width: 700px; height: 500px">
        <table class="blog-receipt">
            <tr>
                <td style="width: 500px;vertical-align: bottom;">
                    คณะวิทยาศาสตร์ มหาวิทยาลัยแม่โจ้ <br>
                    63 หมู่ 4 ต.หนองหาร อ.สันทราย จ.เชียงใหม่ 50290
                </td>
                <td>
                    <img src="${pageContext.request.contextPath}/assets/img/icon_mju_science.png"
                         style="height: 112px;">
                </td>
            </tr>
            <tr style="height: 30px;">
                <td colspan="2"><hr></td>
            </tr>
            <tr>
                <td colspan="2"><p>${receipt.invoice.register.member.firstName} &nbsp; ${receipt.invoice.register.member.lastName}</p></td>
            </tr>
            <tr>
                <td>ธนาคาร ${receipt.banking}</td>
                <td><p style="font-size: 29px;">ใบเสร็จ</p></td>
            </tr>
            <tr>
                <td colspan="2">
                    <fmt:formatDate value="${receipt.pay_date}" pattern="dd/MM/yyyy" var="pay_date"/>
                    ${pay_date}
                </td>
            </tr>
            <tr style="height: 30px">
                <td colspan="2"></td>
            </tr>
            <tr>
                <td>รายการ</td>
                <td>ราคา</td>
            </tr>
            <tr>
                <td><p class="receipt_c_name">${receipt.invoice.register.requestOpenCourse.course.name}</p></td>
                <td>${receipt.invoice.register.requestOpenCourse.course.fee}</td>
            </tr>
            <tr style="height: 30px">
                <td colspan="2"><hr></td>
            </tr>
            <tr>
                <td><p style="font-size: 22px;">รวมทั้งหมด</p></td>
                <td><p style="font-size: 22px">${receipt.invoice.register.requestOpenCourse.course.fee}</p></td>
            </tr>
        </table>
    </div>
    <br>
    <a href="${pageContext.request.contextPath}/" style="font-weight: bold;">กลับหน้าแรก</a>
</center>

<script>
    document.getElementById('downloadButton').addEventListener('click', function () {
        // สร้าง Canvas ที่มีขนาดเท่ากับเนื้อหา
        html2canvas(document.getElementById('pdfContent')).then(function (canvas) {
            // หาขนาดของ Canvas ที่สร้าง
            const canvasWidth = canvas.width - 260;
            const canvasHeight = canvas.height - 150;

            // สร้างเอกสาร PDF ด้วยขนาด Canvas
            var doc = new jsPDF({
                encoding: 'UTF-8',
                orientation: 'landscape',
                unit: 'px', // ใช้หน่วยเป็นพิกเซล
                format: [canvasWidth, canvasHeight] // ใช้ขนาดเท่ากับ Canvas
            });

            // เพิ่มรูปภาพจาก Canvas ลงใน PDF
            doc.addImage(canvas.toDataURL('image/PNG',1), 'PNG', 20, 25, 420, 310);

            // บันทึกเอกสาร PDF
            doc.save('Receipt.pdf');
        });
    });

    /******** Format Date to dd/mm/yyyy **************/

    function formatDateElement(elementId) {
        var text = document.getElementById(elementId).textContent;
        var date = new Date(text);

        var day = date.getDate();
        var month = date.getMonth() + 1; // เพิ่ม 1 เนื่องจากเดือนเริ่มต้นจาก 0
        var year = date.getFullYear();

        return day + '/' + month + '/' + year + '  ' + `${receipt.pay_time}`;
    }

    var formattedDatePayment = formatDateElement("formattedDatePayment");
    document.getElementById("formattedDatePayment").textContent = formattedDatePayment;
</script>


</body>
<jsp:include page="/WEB-INF/view/layouts/footer.jsp"/>
</html>

