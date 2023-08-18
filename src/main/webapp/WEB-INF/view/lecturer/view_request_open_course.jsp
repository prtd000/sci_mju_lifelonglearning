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
    <title>RequestOpenCourse</title>
    <jsp:include page="/WEB-INF/view/layouts/detail-all-style.jsp"/>

    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

</head>
<body>
    <jsp:include page="/WEB-INF/view/layouts/nav.jsp"/>
    <div id="header">
        <h1>ดูรายละเอียดคำร้องขอ</h1>
    </div>
    <div class="container">
        <div id="container">
            <i>Detail</i>
            <br><br>
            <table>
                    <colgroup>
                        <col style="width: 160px;">
                        <col style="width: auto;">
                    </colgroup>
                    <tbody>
                    <tr>
                        <td>
                            <label>รหัสการร้องขอ:</label>
                        </td>
                        <td>
                            <label>${ROC_detail.request_id}</label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label>หลักสูตร:</label>
                        </td>
                        <td>
                            <label>${ROC_detail.course.name}</label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label>สาขาวิชา:</label>
                        </td>
                        <td>
                            <label>${ROC_detail.course.major.name}</label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label>วันที่ร้องขอ:</label>
                        </td>
<%--                        <%date = dateFormat.parse("12/12/2002");%>--%>
                        <td>
                            <label>${ROC_detail.requestDate}</label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label>วันเปิดรับสมัคร:</label>
                        </td>
                        <td>
                            <label>${ROC_detail.startRegister}</label>
                        </td>
                    </tr>
                    <tr>
                        <td><label>วันปิดรับสมัคร:</label></td>
                        <td>
                            <label>${ROC_detail.endRegister}</label>
                        </td>
                    </tr>
                    <tr>
                        <td><label>จำนวนรับสมัคร:</label></td>
                        <td>
                            <label>${ROC_detail.quantity}</label>
                        </td>
                    </tr>
                    <tr>
                        <td><label>วันที่เริ่มเรียน:</label></td>
                        <td>
                            <label>${ROC_detail.startStudyDate}</label>
                        </td>
                    </tr>
                    <tr>
                        <td><label>วันที่สิ้นสุดการเรียน:</label></td>
                        <td>
                            <label>${ROC_detail.endStudyDate}</label>
                        </td>
                    </tr>
                    <tr>
                        <td><label>เวลาในการเรียนเรียน:</label></td>
                        <td>
                            <label>${ROC_detail.studyTime}</label>
                        </td>
                    </tr>
                    <tr>
                        <td><label>วันประกาศผลการสมัคร:</label></td>
                        <td>
                            <label>${ROC_detail.applicationResult}</label>
                        </td>
                    </tr>
                    <tr>
                        <td><label>ประเภทการเรียน:</label></td>
                        <td>
                            <label>${ROC_detail.type_learn}</label>
                        </td>
                    </tr>
                    <tr>
                        <td><label>รูปแบบการสอน:</label></td>
                        <td>
                            <label>${ROC_detail.type_teach}</label>
                        </td>
                    </tr>
                    <tr>
                        <td><label>สถานที่:</label></td>
                        <td>
                            <label>${ROC_detail.location}</label>
                        </td>
                    </tr>
                    <tr>
                        <td><label>สถานะการร้องขอ:</label></td>
                        <td>
                            <label>${ROC_detail.requestStatus}</label>
                        </td>
                    </tr>
                    <tr>
                        <td><label>ลายเซ็น:</label></td>
                        <td>
                            <label>${ROC_detail.signature}</label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label>อาจารย์ผู้สอน:</label>
                        </td>
                        <td>
                            <label>${ROC_detail.lecturer.firstName} ${ROC_detail.lecturer.lastName}</label>
                        </td>
                    </tr>
                    <tr>
                        <td><label></label></td>
                        <td><input type="button" value="ลบ"
                                   onclick="if((confirm('คุณแน่ใจหรือว่าต้องการลบการร้องขอนี้?'))) { window.location.href='${pageContext.request.contextPath}/lecturer/${lec_id}/${ROC_detail.request_id}/delete'; return false; }"
                                   class="cancel-button"/>
<%--                            <input type="button" value="แก้ไข"/>--%>
                            <a href="${pageContext.request.contextPath}/lecturer/${lec_id}/${ROC_detail.request_id}/update_page">แก้ไข</a>
<%--                            <input type="button" value="ยกเลิก"onclick="window.location.href='list'; return false;"class="cancel-button"/>--%>
                            <input type="button" value="ย้อนกลับ"
                                   onclick="window.location.href='${pageContext.request.contextPath}/lecturer/${lec_id}/list_request_open_course'; return false;"
                                   class="cancel-button"/>
                        </td>
                    </tr>
                    </tbody>
                </table>
        </div>
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
