<%@ page import="java.text.SimpleDateFormat" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%--
  Created by IntelliJ IDEA.
  User: asus
  Date: 30/5/2566
  Time: 13:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>ApproveRequestOpenCourse</title>
    <jsp:include page="/WEB-INF/view/layouts/detail-all-style.jsp"/>

    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

</head>
<body>
    <jsp:include page="/WEB-INF/view/layouts/nav.jsp"/>
    <div id="header">
        <h1>${title}</h1>
    </div>

    <div class="block_position">
        <h1>
            ${RAOC_detail.course.name}
        </h1>
        <!--Detail-->
        <div>
            <br>
            <hr>
            <!---Sub_Detail-->
            <table>
                <tr>
                    <td class="t1">หลักสูตร</td>
                    <td class="t2">${RAOC_detail.course.name}</td>
                </tr>
                <tr>
                    <td class="t1">หมวดสาขาวิชา</td>
                    <td class="t2">${RAOC_detail.course.major.name}</td>
                </tr>
                <tr>
                    <td class="t1">เริ่มรับสมัคร</td>
                    <td class="t2">${RAOC_detail.startRegister}</td>
                </tr>
                <td class="t1">สิ้นสุดรับสมัคร</td>
                <td class="t2">${RAOC_detail.endRegister}</td>
                </tr>
                <tr>
                    <td class="t1">จำนวนรับสมัคร</td>
                    <td class="t2">${RAOC_detail.quantity}</td>
                </tr>
                <tr>
                    <td class="t1">วันประกาศผมการสมัคร</td>
                    <td class="t2">${RAOC_detail.applicationResult}</td>
                </tr>
                <tr>
                    <td class="t1">ค่าสมัครสมัคร</td>
                    <td class="t2">${RAOC_detail.course.fee}0 บาท</td>
                </tr>
                <tr>
                    <td class="t1">เริ่มเรียน</td>
                    <td class="t2">${RAOC_detail.startStudyDate}</td>
                </tr>
                <tr>
                    <td class="t1">ถึง</td>
                    <td class="t2">${RAOC_detail.endStudyDate}</td>
                </tr>
                <tr>
                    <td class="t1">รูปแบบการเรียน</td>
                    <td class="t2">${RAOC_detail.type_learn}</td>
                </tr>
                <tr>
                    <td class="t1">รูปแบบการสอน</td>
                    <td class="t2">${RAOC_detail.type_teach}</td>
                </tr>
                <tr>
                    <td class="t1">สถานที่เรียน</td>
                    <td class="t2">${RAOC_detail.location}</td>
                </tr>
            </table>
        </div>

    </div>
    <div class="block_position">
        <table>
            <tr>
                <td class="t1">จำนวนผู้สมัคร</td>
                <td class="t2">10 / ${RAOC_detail.quantity}</td>
            </tr>
            <tr>
                <td><label></label></td>
                <td>
                    <input type="button" value="ย้อนกลับ"
                           onclick="window.location.href='${pageContext.request.contextPath}/course/list_all_course'; return false;"
                           class="cancel-button"/>
                </td>
            </tr>
        </table>
    </div>

    <jsp:include page="/WEB-INF/view/layouts/footer.jsp"/>
</body>

<script>
    $(function() {
        $("#datepicker1, #datepicker2, #datepicker3, #datepicker4, #datepicker5").datepicker({
            dateFormat: "mm/dd/yy" // รูปแบบวันที่ที่ต้องการ
        });
    });
</script>
</html>
