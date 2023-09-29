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
    <title>Make Payment</title>
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

        document.addEventListener("DOMContentLoaded", function () {
            const dateInput = document.getElementById("datePicker");

            // Get today's date
            const today = new Date().toISOString().split("T")[0];

            // Set the max attribute to today's date
            dateInput.setAttribute("max", today);
        });

        /****************** Script *****************************/
        function checkScript(frm) {
            //------------File---------------
            var extall = "jpg,jpeg,png";
            file = frm.slip.value;
            ext = file.split('.').pop().toLowerCase();

            if (parseInt(extall.indexOf(ext)) < 0) {
                alert('แนบเป็นไฟล์ : ' + extall + ' เท่านั้น !!');
                frm.slip.value = "";
                return false;
            } else if (frm.slip.value === "") {
                alert("กรุณาแนบหลักฐานการชำระเงินด้วย");
                return false
            }

            //-----------------Payment Date----------------
            if (frm.datePicker.value === "" || frm.datePicker.value === null || frm.datePicker.value === undefined  ) {
                alert("กรุณากรอกวันที่ชำระเงิน");
                frm.datePicker.value = "";
                return false;
            }

            //------------receipt_paytime--------------
            if (frm.receipt_paytime.value === "") {
                alert("กรุณาเลือกเวลาที่ชำระเงิน");
                return false;
            }

            //------------receipt_banking--------------
            if (frm.receipt_banking.value === "กรุณาเลือกธนาคาร") {
                alert("กรุณาเลือกธนาคาร");
                return false;
            }

            //------------last_four_digits--------------
            var digits = /^[0-9]{4}$/;
            if (!frm.last_four_digits.value.match(digits)) {
                alert("กรอกเลขบัญชีธนาคารเลขที่ (4 หลักสุดท้าย)");
                frm.last_four_digits.value = "";
                return false;
            }
        }
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
        <!-- Navbar End -->
    </c:when>
</c:choose>
<center>
    <br>
    <h1>ข้อมูลการชำระเงิน</h1>
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
    <form action="${pageContext.request.contextPath}/member/${payment.register.member.username}/payment_fill_detail/${payment.invoice_id}/save"
          method="post" name="frm" onsubmit="return confirm('ยืนยันข้อมูลการชำระเงิน')" enctype="multipart/form-data">
        <table style="box-shadow: 0px 0px 9px 0px #636363; border-radius: 28px; height: 430px;">
            <tr style="height: 350px;">
                <td style="width: 315px">
                    <label for="fileInput" class="file-label" style="margin-left: 120px;">Choose a file</label>
                    <input type="file" id="fileInput" accept="image/*" name="slip" class="file-input"
                           onchange="previewImage(this)">
                </td>
                <td style="width: 315px; text-align: -webkit-center;">
                    <p style="color: red; margin-top: 26px; font-weight: bold;">*อัพโหลดหลักฐานการชำระเงิน*</p> <br>
                    <img id="preview" src="" alt="Image Preview" style="display: none; height: 270px; margin-left: 28px; margin-top: -24px;">
                </td>
            </tr>
        </table>
        <br>
        <table>
            <tr>
                <td style="width: 450px;">วันที่โอนตามหลักฐานการชำระเงิน</td>
                <td><input type="date" name="receipt_paydate" id="datePicker" class="form-control" style="color: black; font-weight: bold;"></td>
            </tr>
            <tr>
                <td>เวลาที่โอนตามหลักฐานการชำระเงิน</td>
                <td><input type="time" name="receipt_paytime" class="form-control" style="color: black; font-weight: bold;"></td>
            </tr>
            <tr>
                <td>โอนจากธนาคาร</td>
                <td>
                    <select id="receipt_banking" name="receipt_banking" class="form-select" aria-label="Default select example" style="color: black; font-weight: bold;">
                        <option value="กรุณาเลือกธนาคาร" selected>กรุณาเลือกธนาคาร</option>
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
                <td><input type="number" name="last_four_digits" class="form-control" style="color: black; font-weight: bold;"></td>
            </tr>
            <tr>
                <td></td>
                <td><br></td>
            </tr>
            <tr>
                <td colspan="2">
                    <input type="submit" style="width: 100%;" value="ยืนยันข้อมูลการชำระเงิน" class="btn btn-outline-success" onclick="return checkScript(frm)">
                </td>
            </tr>
        </table>
    </form>
</center>

<jsp:include page="/WEB-INF/view/layouts/footer.jsp"/>
</body>

</html>
