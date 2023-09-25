<%@ page import="lifelong.model.Admin" %>
<%@ page import="lifelong.model.Member" %>
<%@ page import="lifelong.model.Lecturer" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%--
  Created by IntelliJ IDEA.
  User: asus
  Date: 9/8/2566
  Time: 11:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Update Payment</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <jsp:include page="/WEB-INF/view/layouts/detail-all-style.jsp"/>
    <script>
        function previewImage(input) {
            var preview = document.getElementById('preview');
            var fileInput = document.getElementById('fileInput');

            if (input.files && input.files[0]) {
                var reader = new FileReader();

                reader.onload = function (e) {
                    preview.src = e.target.result;
                    preview.style.display = 'block';
                };

                reader.readAsDataURL(input.files[0]);
            } else {
                preview.src = '';
                preview.style.display = 'none';
            }
        }
        /***** can't do not select date future ********/

        document.addEventListener("DOMContentLoaded", function() {
            const dateInput = document.getElementById("datePicker");

            // Get today's date
            const today = new Date().toISOString().split("T")[0];

            // Set the max attribute to today's date
            dateInput.setAttribute("max", today);
        });
    </script>
    <style>
        .file-input {
            opacity: 0;
            cursor: pointer;
        }

        .file-label {
            background-color: #f38644;
            color: #fff;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .file-label:hover {
            background-color: #d0692e;
        }
        td{
            font-weight: bold;
            color: black;
            font-size: 19px;
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
    }else if (lecturer != null) {
        flag = "lecturer";
    } else if (member != null) {
        flag = "member";
    }else {
        flag = "null";
    }
%>

<c:set var="flag" value="<%= flag %>" />
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
    <h1>แก้ไขการชำระเงิน</h1>
    <br>
    <h4>${payment.register.requestOpenCourse.course.name}</h4>
    <p>${payment.register.requestOpenCourse.course.major.name}</p>
    <hr>
    <h4>โอนไปยัง</h4>
    <table>
        <tr>
            <td style="width: 255px;">ธนาคารปลายทาง</td>
            <td style="width: 150px;">กรุงไทย</td>
        </tr>
        <tr>
            <td>เลขที่บัญชี</td>
            <td>679-5-60403-1</td>
        </tr>
    </table>
    <hr>
    <table>
        <tr>
            <td style="width: 255px;">ยอดรวมชำระเงินทั้งหมด</td>
            <td style="width: 150px;">${payment.register.requestOpenCourse.course.fee} บาท</td>
        </tr>
    </table>
    <br>
    <form action="${pageContext.request.contextPath}/member/${payment.register.member.username}/update_payment_fill_detail/${payment.invoice_id}/update" method="post" onsubmit="return confirm('ยืนยันข้อมูลการชำระเงิน')" enctype="multipart/form-data">

        <table style="box-shadow: 0px 0px 9px 0px #636363; border-radius: 28px; height: 430px;">
            <tr style="height: 350px;">
                <td style="width: 315px">
                    <label for="fileInput" class="file-label" style="margin-left: 120px;">Choose a file</label>
                    <input type="file" id="fileInput" accept="image/*" name="slip" class="file-input" value="${receipt.slip}" onchange="previewImage(this)">
                </td>
                <td style="width: 315px">
                    <p style="color: red; margin-top: 26px; margin-left: 12px; font-weight: bold; text-align: center;">*กรุณาอัพโหลด* <br> *รูปหลักฐานการชำระเงินอีกครั้ง*</p> <br>
                    <img id="preview" src="" alt="Image Preview" style="display: none; height: 270px; margin-left: 28px; margin-top: -24px;">
                </td>
            </tr>
        </table>
        <br>
        <table>
            <tr>
                <td style="width: 450px;">วันที่โอนตามหลักฐานการชำระเงิน</td>
                <td><input type="date" name="receipt_paydate" value="${receipt.pay_date}" id="datePicker" class="form-control" style="color: black; font-weight: bold;"></td>
            </tr>
            <tr>
                <td>เวลาที่โอนตามหลักฐานการชำระเงิน</td>
                <td><input type="time" name="receipt_paytime" value="${receipt.pay_time}" class="form-control" style="color: black; font-weight: bold;"></td>
            </tr>
            <tr>
                <td>โอนจากธนาคาร</td>
                <td>
                    <select id="receipt_banking" name="receipt_banking" class="form-select" aria-label="Default select example" style="color: black; font-weight: bold;">
                        <option value="กรุงไทย">กรุงไทย</option>
                        <option value="ไทยพาณิชย์">ไทยพาณิชย์ (SCB)</option>
                        <option value="กสิกรไทย">กสิกรไทย (KBank)</option>
                        <option value="ออมสิน">ออมสิน</option>
                        <option value="กรุงศรี">กรุงศรี</option>
                        <option value="กรุงเทพ">กรุงเทพ</option>
                        <option value="ทีทีบี">ทีทีบี</option>
                        <option value="ธ.ก.ส">ธ.ก.ส</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td>เงินโอนจากบัญชีธนาคารเลขที่ (4 หลักสุดท้าย)</td>
                <td><input type="number" name="last_four_digits" value="${receipt.last_four_digits}" class="form-control" style="color: black; font-weight: bold;"></td>
            </tr>
            <tr>
                <td></td>
                <td><br></td>
            </tr>
            <tr>
                <td colspan="2">
                    <input type="submit" style="width: 100%;" value="ยืนยันข้อมูลการชำระเงิน" class="btn btn-outline-success">
                </td>
            </tr>
        </table>
    </form>
</center>

<jsp:include page="/WEB-INF/view/layouts/footer.jsp"/>

<script>
    let index = 0;
    const banking = "${receipt.banking}";
    if (banking === "กรุงไทย") {
        index = 0;
    } else if (banking === "ไทยพาณิชย์") {
        index = 1;
    } else if (banking === "กสิกรไทย") {
        index = 2;
    } else if (banking === "ออมสิน") {
        index = 3;
    } else if (banking === "กรุงศรี") {
        index = 4;
    } else if (banking === "กรุงเทพ") {
        index = 5;
    } else if (banking === "ทีทีบี") {
        index = 6;
    } else if (banking === "ธ.ก.ส") {
        index = 7;
    }
    window.onload = function () {
        document.getElementById("receipt_banking").selectedIndex = index;
    };
</script>
</body>
</html>
