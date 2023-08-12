<%--
  Created by IntelliJ IDEA.
  User: asus
  Date: 9/8/2566
  Time: 11:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <jsp:include page="/WEB-INF/view/layouts/detail-all-style.jsp"/>
</head>
<body>
<jsp:include page="/WEB-INF/view/layouts/nav.jsp"/>
<center>
    <br><br>
    <h1>ยืนยันการชำระเงิน</h1>
    <hr>
    <table>
        <tr>
            <td style="width: 200px">ยอดการชำระเงินทั้งหมด</td>
            <td>${payment.register.requestOpenCourse.course.fee}</td>
            <td>บาท</td>
        </tr>
    </table>
    <hr>
    <h5>อัพโหลดหลักฐานการชำระเงิน</h5>
    <table border="1">
        <tr>
            <td style="width: 315px"><p style="color: red;">*ภาพตัวอย่าง*</p></td>
            <td><input type="file" name="slip"></td>
        </tr>
    </table>
    <hr>
    <form action="${pageContext.request.contextPath}/member/${payment.register.member.username}/payment_fill_detail/${payment.invoice_id}/save" method="post">
        <table>
            <tr>
                <td style="width: 450px;">วันที่โอนตามหลักฐานการชำระเงิน</td>
                <td><input type="date" name="receipt_paydate"></td>
            </tr>
            <tr>
                <td>เวลาที่โอนตามหลักฐานการชำระเงิน</td>
                <td><input type="text" name="receipt_paytime"></td>
            </tr>
            <tr>
                <td>โอนจากธนาคาร</td>
                <td><input type="text" name="receipt_banking"></td>
            </tr>
            <tr>
                <td>จำนวนเงินที่ถูกโอน (฿)</td>
                <td><input type="text" name="receipt_total"></td>
            </tr>
            <tr>
                <td>เงินโอนจากบัญชีธนาคารเลขที่ (4 หลักสุดท้าย)</td>
                <td><input type="text" name="last_four_digits"></td>
            </tr>
            <tr>
                <td colspan="2">
                    <input type="submit" style="width: 100%;" value="ยืนยันข้อมูลการชำระเงิน">
                </td>
            </tr>
        </table>
    </form>
</center>

<jsp:include page="/WEB-INF/view/layouts/footer.jsp"/>
</body>
</html>