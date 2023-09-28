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

        table {
            color: black;
        }

        td {
            vertical-align: center;
        }

        .txt_address{
            position: absolute;
            font-size: 17px;
            font-weight: bold;
            color: black;
            top: 43%;
            left: 42%;
            transform: translate(-50%, -50%);
        }
        .name_txt {
            position: absolute;
            font-size: 25px;
            font-weight: bold;
            color: black;
            top: 54%;
            left: 34.5%;
            transform: translate(-50%, -50%);
        }
        .txt_banking{
            position: absolute;
            font-size: 19px;
            font-weight: bold;
            color: black;
            top: 60%;
            left: 34.4%;
            transform: translate(-50%, -50%);
        }
        .txt_date{
            position: absolute;
            font-size: 19px;
            font-weight: bold;
            color: black;
            top: 66%;
            left: 34.5%;
            transform: translate(-50%, -50%);
        }
        .txt_header{
            font-family: 'Mitr', sans-serif;
            position: absolute;
            font-size: 31px;
            font-weight: bold;
            color: black;
            top: 60%;
            left: 62.2%;
            transform: translate(-50%, -50%);
        }
        .txt_header_name{
            position: absolute;
            font-size: 19px;
            font-weight: bold;
            color: black;
            top: 74%;
            left: 32%;
            transform: translate(-50%, -50%);
        }
        .txt_header_price{
            position: absolute;
            font-size: 19px;
            font-weight: bold;
            color: black;
            top: 74%;
            left: 61%;
            transform: translate(-50%, -50%);
        }
        .txt_list_name{
            position: absolute;
            font-size: 18px;
            font-weight: bold;
            color: black;
            top: 79%;
            left: 40.8%;
            transform: translate(-50%, -50%);
            overflow: hidden;
            white-space: nowrap;
            text-overflow: ellipsis;
            width: 328px;
        }
        .txt_price{
            position: absolute;
            font-size: 18px;
            font-weight: bold;
            color: black;
            top: 79%;
            left: 63%;
            transform: translate(-50%, -50%);
        }
        .total_txt {
            position: absolute;
            font-size: 26px;
            font-weight: bold;
            color: black;
            top: 89%;
            left: 34.5%;
            transform: translate(-50%, -50%);
        }
        .total_txt_price {
            position: absolute;
            font-size: 26px;
            font-weight: bold;
            color: black;
            top: 89%;
            left: 64.5%;
            transform: translate(-50%, -50%);
        }
    </style>
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
<center>
    <br>
    <button id="downloadButton" style="cursor: pointer;" class="btn btn-secondary">ดาวน์โหลด PDF</button>
    <br><br>

    <div id="pdfContent" style="width: 700px">
        <table style="width: 605px;">
            <tr style="vertical-align: bottom;">
                <td style="width: 500px;">
                    <p class="txt_address">
                        คณะวิทยาศาสตร์ มหาวิทยาลัยแม่โจ้ <br>
                        63 หมู่ 4 ต.หนองหาร อ.สันทราย จ.เชียงใหม่ 50290
                    </p>
                </td>
                <td>
                    <img src="${pageContext.request.contextPath}/assets/img/icon_mju_science.png"
                         style="height: 112px; margin-left: -76px;">
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <hr style="">
                </td>
            </tr>
            <tr>
                <td>
                    <p class="name_txt">${receipt.invoice.register.member.firstName}
                        &nbsp; ${receipt.invoice.register.member.lastName}</p>
                    <p class="txt_banking">ธนาคาร ${receipt.banking}</p>
                    <p id="formattedDatePayment" class="txt_date">${receipt.pay_date}</p>
                </td>
                <td><p class="txt_header">ใบเสร็จ</p></td>
            </tr>
            <tr style="height: 150px;">
                <td colspan="2"></td>
            </tr>
            <tr>
                <th><p class="txt_header_name">รายการ</p></th>
                <th><p class="txt_header_price">ราคา</p></th>
            </tr>
            <tr>
                <td><p class="txt_list_name">${receipt.invoice.register.requestOpenCourse.course.name}</p></td>
                <td><p class="txt_price">${receipt.invoice.register.requestOpenCourse.course.fee} บาท</p></td>
            </tr>
            <tr style="height: 164px;">
                <td colspan="2">
                    <hr style="">
                </td>
            </tr>
            <tr>
                <td><p class="total_txt">รวมทั้งหมด</p></td>
                <td><p class="total_txt_price">${receipt.invoice.register.requestOpenCourse.course.fee} บาท</p></td>
            </tr>
        </table>
    </div>
    <br>
    <a href="${pageContext.request.contextPath}/" style="font-weight: bold;">กลับหน้าแรก</a>
</center>

<script>
    document.getElementById('downloadButton').addEventListener('click', function () {
        // สร้าง Canvas ที่มีขนาดเท่ากับเนื้อหา
        html2canvas(pdfContent).then(function (canvas) {
            // หาขนาดของ Canvas ที่สร้าง
            const canvasWidth = canvas.width - 260;
            const canvasHeight = canvas.height - 210;

            // สร้างเอกสาร PDF ด้วยขนาด Canvas
            var doc = new jsPDF({
                encoding: 'UTF-8',
                orientation: 'landscape',
                unit: 'px', // ใช้หน่วยเป็นพิกเซล
                format: [canvasWidth, canvasHeight] // ใช้ขนาดเท่ากับ Canvas
            });

            // เพิ่มรูปภาพจาก Canvas ลงใน PDF
            doc.addImage(canvas.toDataURL('image/PNG',1), 'PNG', 20, 0, 430, 370);

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

