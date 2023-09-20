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

    <script src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/0.5.0-beta4/html2canvas.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.5.3/jspdf.debug.js"
            integrity="sha384-NaWTHo/8YCBYJ59830LTz/P4aQZK1sS0SneOgAvhsIl3zBu8r9RevNg5lHCHAuQ/"
            crossorigin="anonymous"></script>
    <link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css2?family=TH+Sarabun+New&display=swap">
    <jsp:include page="/WEB-INF/view/layouts/detail-all-style.jsp"/>

    <style>
        #pdfContent {
            width: fit-content;
            padding: 18px;
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

        .name_txt {
            font-size: 25px;
            font-weight: bold;
        }

        .total_txt {
            font-weight: bold;
            font-size: 24px;
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
    <button id="downloadButton" style="cursor: pointer;">ดาวน์โหลด PDF</button>
    <br><br>

    <div id="pdfContent">
        <table>
            <tr style="vertical-align: bottom;">
                <td style="width: 500px;">
                    คณะวิทยาศาสตร์ มหาวิทยาลัยแม่โจ้ <br>
                    63 หมู่ 4 ตำบลหนองหาร อำเภอสันทราย จังหวัดเชียงใหม่ 50290
                </td>
                <td>
                    <img src="${pageContext.request.contextPath}/assets/img/icon_mju_science.png"
                         style="height: 112px;">
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
                    <p>${receipt.banking}</p>
                    <p id="formattedDatePayment">${receipt.pay_date}</p>
                </td>
                <td><h1>RECEIPT</h1></td>
            </tr>
            <tr style="height: 22px;">
                <td colspan="2"></td>
            </tr>
            <tr>
                <th>Item Descriptions</th>
                <th>Price</th>
            </tr>
            <tr>
                <td><p>${receipt.invoice.register.requestOpenCourse.course.name}</p></td>
                <td><p>${receipt.invoice.register.requestOpenCourse.course.fee} Baht</p></td>
            </tr>
            <tr>
                <td colspan="2">
                    <hr style="">
                </td>
            </tr>
            <tr>
                <td><p class="total_txt">Total</p></td>
                <td><p class="total_txt">${receipt.invoice.register.requestOpenCourse.course.fee} Baht</p></td>
            </tr>
        </table>
    </div>
    <br>
    <a href="${pageContext.request.contextPath}/" style="font-weight: bold;">กลับหน้าแรก</a>
</center>

<script>
    document.getElementById('downloadButton').addEventListener('click', function () {
        const pdfContent = document.getElementById("pdfContent");

        // สร้าง Canvas ที่มีขนาดเท่ากับเนื้อหา
        html2canvas(pdfContent).then(function (canvas) {
            // หาขนาดของ Canvas ที่สร้าง
            const canvasWidth = canvas.width - 100;
            const canvasHeight = canvas.height - 20;
            console.log('canvasWidth : ' + canvas.width)
            console.log('canvasHeight : ' + canvas.height)

            // สร้างเอกสาร PDF ด้วยขนาด Canvas
            var doc = new jsPDF({
                encoding: 'UTF-8',
                orientation: 'landscape',
                unit: 'px', // ใช้หน่วยเป็นพิกเซล
                format: [canvasWidth, canvasHeight] // ใช้ขนาดเท่ากับ Canvas
            });

            // เพิ่มรูปภาพจาก Canvas ลงใน PDF
            doc.addImage(canvas.toDataURL('image/jpg',1), 'JPG', 30, 30);

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

