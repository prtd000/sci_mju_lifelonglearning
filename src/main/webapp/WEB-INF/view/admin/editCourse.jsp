<%@ page import="lifelong.model.Lecturer" %>
<%@ page import="lifelong.model.Member" %>
<%@ page import="lifelong.model.Admin" %><%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 5/30/2023
  Time: 1:26 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPEhtml>
<html>
<head>
    <title>${title}</title>
    <jsp:include page="/WEB-INF/view/layouts/detail-all-style.jsp"/>
</head>
<body>
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
<c:set var="flag" value="<%= flag %>"></c:set>
<c:choose>
    <c:when test="${flag.equals('lecturer')}">
        <jsp:include page="/WEB-INF/view/lecturer/nav_lecturer.jsp"/>
    </c:when>
    <c:when test="${flag.equals('member')}">
        <jsp:include page="/WEB-INF/view/member/nav_member.jsp"/>
    </c:when>
    <c:when test="${flag.equals('null')}">
        <jsp:include page="/WEB-INF/view/layouts/nav.jsp"/>
    </c:when>
</c:choose>
<c:choose>
    <c:when test="${flag.equals('admin')}">
        <% assert admin != null; %>
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
                    <a href="${pageContext.request.contextPath}/" class="nav-item nav-link">หน้าหลัก</a>
                    <a href="#" class="nav-item nav-link">เกี่ยวกับคณะ</a>
                        <%--            <div class="nav-item dropdown">--%>
                        <%--                <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">หลักสูตรการอบรม</a>--%>
                    <a href="${pageContext.request.contextPath}/course/<%=admin.getUsername()%>/list_all_course" class="nav-item nav-link active">หลักสูตรทั้งหมด</a>
                    <a href="#" class="nav-item nav-link">ข่าวสารและกิจกรรม</a>
                    <a href="#" class="nav-item nav-link">Admin</a>
                    <a href="${pageContext.request.contextPath}/doLogout" class="nav-item nav-link">ออกจากระบบ</a>

                        <%--            <a href="${pageContext.request.contextPath}/login" class="nav-item nav-link">เข้าสู่ระบบ</a>--%>
                </div>
            </div>
        </nav>
        <!-- Navbar End -->
        <div id="header">
            <h1>${title}</h1>
        </div>
        <div class="container">
            <div id="container">
                <i>กรอกข้อมูลในฟอร์ม. เครื.องหมายดอกจัน(*) หมายถึงห้ามว่าง</i>
                <br><br>
                <form action="${pageContext.request.contextPath}/course/<%=admin.getUsername()%>/${course.course_id}/update_edit_course" method="POST" enctype="multipart/form-data"onsubmit="return confirmAction();">
                    <table>
                        <colgroup>
                            <col style="width: 160px;">
                            <col style="width: auto;">
                        </colgroup>
                        <tbody>
                        <tr>
                            <td><label>ประเภท:</label></td>
                            <td>
                                <select name="course_type" id="course_type">
                                    <option value="" label="--กรุณาเลือกหลักสูตร--"></option>
                                    <option value="หลักสูตรอบรมระยะสั้น" label="หลักสูตรอบรมระยะสั้น" ${course.course_type == 'หลักสูตรอบรมระยะสั้น' ? 'selected' : ''}></option>
                                    <option value="Non-Degree" label="Non-Degree" ${course.course_type == 'Non-Degree' ? 'selected' : ''}></option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td><label>รหัสหลักสูตร:</label></td>
                            <td><input name="course_id" type="text" id="course_id" value="${course.course_id}"/></td>
                        </tr>
                        <tr>
                            <td><label>ชื่อหลักสูตร:</label></td>
                            <td><input name="course_name" type="text" id="course_name" value="${course.name}"/></td>
                        </tr>
                        <tr>
                            <td><label>ชื่อเกีตรติบัตร:</label></td>
                            <td><input name="certificateName" type="text" id="certificateName" value="${course.certificateName}"/></td>
                        </tr>
                        <tr>
                            <td><label>รูปหลักสูตร:</label></td>
                            <td>
                                <input name="course_img" type="file" id="course_img" />
                                <c:if test="${not empty course.file}">
                                    <input type="hidden" name="original_img" value="${course.img}" />
                                    <a href="${course.img}" target="_blank">${course.img}</a>
                                </c:if>
                            </td>
                        </tr>
                        <tr>
                            <td><label>หลักการและเหตุผล:</label></td>
                            <td><textarea name="course_principle" id="course_principle">${course.principle}</textarea></td>
                        </tr>
                        <tr>
                            <td><label>วัตถุประสงค์:</label></td>
                            <td><textarea name="course_object" id="course_object">${course.object}</textarea></td>
                        </tr>
                        <tr>
                            <td><label>ระยะเวลาในการเรียน:</label></td>
                            <td><input name="course_totalHours" type="number" id="course_totalHours" value="${course.totalHours}"/></td>
                        </tr>
                        <tr>
                            <td><label>เป้าหมายกลุ่มอาชีพ:</label></td>
                            <td><input name="course_targetOccupation" type="text" id="course_targetOccupation" value="${course.targetOccupation}"/></td>
                        </tr>
                        <tr>
                            <td><label>ค่าธรรมเนียม:</label></td>
                            <td><input name="course_fee" type="text" id="course_fee" value="${course.fee}"/></td>
                        </tr>
                        <tr>
                            <td><label>ไฟล์หลักสูตร:</label></td>
                            <td>
                                <input name="course_file" type="file" id="course_file" />
                                <c:if test="${not empty course.file}">
                                    <input type="hidden" name="original_file" value="${course.file}" />
                                    <a href="${course.file}" target="_blank">${course.file}</a>
                                </c:if>
                            </td>
                        </tr>
                        <tr>
                            <td><label>ลิ้งค์หลักสูตร:</label></td>
                            <td><input name="course_linkMooc" type="text" id="course_linkMooc" value="${course.linkMooc}"/></td>
                        </tr>
                        <tr>
                            <td><label>สาขา:</label></td>
                            <td>
                                <select name="major_id" id="major_id">
                                    <c:forEach items="${majors}" var="major">
                                        <c:choose>
                                            <c:when test="${major.major_id eq course.major.major_id}">
                                                <option value="${major.major_id}" selected>${major.name}</option>
                                            </c:when>
                                            <c:otherwise>
                                                <option value="${major.major_id}">${major.name}</option>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td><input type="button" value="ย้อนกลับ"
                                       onclick="window.location.href='${pageContext.request.contextPath}/course/<%=admin.getUsername()%>/list_all_course'; return false;"
                                       class="cancel-button"/></td>
                            <td><input type="submit" value="บันทึก" class="save"/>
                                    <%--                        <input type="button" value="ยกเลิก"onclick="window.location.href='list'; return false;"class="cancel-button"/>--%>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </form>
            </div>
        </div>
    </c:when>
    <c:when test="${flag.equals('null')}">
        <h1>กรุณา Log in ใหม่</h1>
        <a href="${pageContext.request.contextPath}/">กลับหน้าหลัก</a>
    </c:when>
    <c:otherwise>
        <h1>คุณไม่มีสิทธิในหน้านี้</h1>
    </c:otherwise>
</c:choose>
</body>
<script>
    function confirmAction() {
        var result = confirm("คุณแน่ใจหรือไม่ว่าต้องการแก้ไขหลักสูตรนี้?");
        if (result) {
            return true; // ถ้าผู้ใช้กด OK ให้ทำงานตามปกติ
        } else {
            return false; // ถ้าผู้ใช้กด Cancel ให้ยกเลิกการส่งฟอร์ม
        }
    }
</script>
</html>
