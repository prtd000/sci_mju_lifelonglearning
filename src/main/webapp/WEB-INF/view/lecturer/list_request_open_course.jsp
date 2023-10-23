<%@ page import="lifelong.model.*" %>
<%@ page import="java.util.Date" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>หลักสูตรที่ร้องขอ</title>
    <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet">
<%--    <link href="${pageContext.request.contextPath}/assets/css/lecturer/list_request_open_course.css" rel="stylesheet">--%>
    <jsp:include page="/WEB-INF/view/layouts/detail-all-style.jsp"/>
    <link href="${pageContext.request.contextPath}/assets/css/lecturer/list_request_open_course.css" rel="stylesheet">
<%--    <link href="${pageContext.request.contextPath}/assets/css/list_open_course_style.css" rel="stylesheet">--%>
    <style>
        body{
            font-family: 'Prompt', sans-serif;
        }
        label{
            font-size: 12px;
        }
    </style>
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
    <c:when test="${flag.equals('admin')}">
        <jsp:include page="/WEB-INF/view/admin/nav_admin.jsp"/>
    </c:when>
    <c:when test="${flag.equals('member')}">
        <jsp:include page="/WEB-INF/view/member/nav_member.jsp"/>
    </c:when>
    <c:when test="${flag.equals('null')}">
        <jsp:include page="/WEB-INF/view/layouts/nav.jsp"/>
    </c:when>
</c:choose>
<c:choose>
    <c:when test="${flag.equals('lecturer')}">
        <% assert admin != null; %>
        <!-- Navbar Start -->
        <nav class="navbar navbar-expand-lg bg-white navbar-light shadow-sm py-3 py-lg-0 px-3 px-lg-0">
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
                    <a href="${pageContext.request.contextPath}/" class="nav-item nav-link" style="font-size: 18px">หน้าหลัก</a>
                    <a href="${pageContext.request.contextPath}/search_course" class="nav-item nav-link" style="font-size: 18px">หลักสูตรการอบรม</a>
                    <a href="${pageContext.request.contextPath}/lecturer/<%=lecturer.getUsername()%>/add_roc" class="nav-item nav-link" style="font-size: 18px">ร้องขอหลักสูตร</a>
                    <a href="${pageContext.request.contextPath}/lecturer/<%=lecturer.getUsername()%>/list_request_open_course" class="nav-item nav-link active" style="font-size: 18px">รายการร้องขอ</a>
                    <a href="${pageContext.request.contextPath}/lecturer/<%=lecturer.getUsername()%>/list_approve_request_open_course" class="nav-item nav-link" style="font-size: 18px">หลักสูตรที่เปิดสอน</a>
                    <a href="${pageContext.request.contextPath}/view_activity" class="nav-item nav-link" style="font-size: 18px">ข่าวสารและกิจกรรม</a>
                    <a href="#" class="nav-item nav-link" style="font-size: 17px">อาจารย์</a>
                    <a href="${pageContext.request.contextPath}/doLogout" class="nav-item nav-link" style="font-size: 18px">ออกจากระบบ</a>
                </div>
            </div>
        </nav>
        <!-- Navbar End -->

<div align="center" style="margin-top: 20px">
    <h3>รายการหลักสูตรที่ร้องขอ</h3><br>
    <table class="container" style="font-size: 12px">
        <tr align="center">
            <td class="list_course" align="center">
                <div id="list_request" class="tabcontent">
                    <table style="width: 100%;">
                        <tr>
                            <td align="left" style="width: 50%">
                                <h4><b id="tag_line">หลักสูตรที่ร้องขอ</b></h4>
                            </td>
                            <td align="right" style="width: 30%">
                                <select id="select_type" style="font-size: 12px" class="form-select" aria-label="Default select example" onchange="checkSelection()">
                                    <option value="หลักสูตรที่ร้องขอ" selected>หลักสูตรที่ร้องขอ</option>
                                    <option value="หลักสูตรที่ไม่ผ่านการร้องขอ">หลักสูตรที่ไม่ผ่านการร้องขอ</option>
                                </select>
                            </td>
                        </tr>
                    </table>
                    <hr>
                    <div id="pass_approve">
                        <table class="table table-striped table-hover" style="font-size: 12px">
                            <tr style="color: black">
                                <td style="width: 25%">รายละเอียดการร้องขอ</td>
                                <td style="width: 14%" align="center">ระยะเวลาลงทะเบียน</td>
                                <td style="width: 14%" align="center">ระยะเวลาชำระเงิน</td>
                                <td style="width: 7%" align="center">วันประกาศผล</td>
                                <td style="width: 14%" align="center">ระยะเวลาเรียน</td>
                                <td style="width: 8%" align="center">ประเภท</td>
                                <td style="width: 12%" align="center"></td>
                            </tr>
                            <c:forEach var="request_course" items="${requests_open_course}">
                                <c:if test="${request_course.requestStatus == 'รอดำเนินการ'}">
                                    <fmt:formatDate value="${request_course.requestDate}" pattern="dd/MM/yyyy" var="formattedDate" />
                                    <fmt:formatDate value="${request_course.startRegister}" pattern="dd/MM/yyyy" var="startRegister" />
                                    <fmt:formatDate value="${request_course.endRegister}" pattern="dd/MM/yyyy" var="endRegister" />
                                    <fmt:formatDate value="${request_course.startPayment}" pattern="dd/MM/yyyy" var="startPayment" />
                                    <fmt:formatDate value="${request_course.endPayment}" pattern="dd/MM/yyyy" var="endPayment" />
                                    <fmt:formatDate value="${request_course.applicationResult}" pattern="dd/MM/yyyy" var="applicationResult" />
                                    <fmt:formatDate value="${request_course.startStudyDate}" pattern="dd/MM/yyyy" var="startStudyDate" />
                                    <fmt:formatDate value="${request_course.endStudyDate}" pattern="dd/MM/yyyy" var="endStudyDate" />
                                    <tr style="color: black">
                                        <td><p>${request_course.course.name}</p></td>
                                        <td align="center"><p>${startRegister} - ${endRegister}</p></td>
                                        <c:choose>
                                            <c:when test="${request_course.course.fee == 0}">
                                                <td align="center"><p>ไม่มีค่าธรรมเนียม(ฟรี)</p></td>
                                            </c:when>
                                            <c:otherwise>
                                                <td align="center"><p>${startPayment} - ${endPayment}</p></td>
                                            </c:otherwise>
                                        </c:choose>
                                        <td align="center"><p>${applicationResult}</p></td>
                                        <td align="center"><p>${startStudyDate} - ${endStudyDate}</p></td>
                                        <td align="center">${request_course.course.course_type}</td>
                                        <td align="center">
                                            <a href="${pageContext.request.contextPath}/lecturer/<%=lecturer.getUsername()%>/${request_course.request_id}/update_page">
                                                <button type="button" class="btn btn-outline-warning" style="font-size: 12px">
                                                    <i style="color: #ff8d4e;" class="fa fa-edit" aria-hidden="true"></i> แก้ไข
                                                </button>
                                            </a>
                                                <%--                                        <input type="button" style="font-size: 12px"--%>
                                                <%--                                               onclick="if((confirm('คุณแน่ใจหรือว่าต้องการลบการร้องขอนี้?'))) { window.location.href='${pageContext.request.contextPath}/lecturer/${lecturer_id}/${request_course.request_id}/delete_request_open_course'; return false; }"--%>
                                                <%--                                               class="btn btn-outline-danger"/>--%>
                                            <button type="button" style="font-size: 12px"
                                                    onclick="if((confirm('คุณแน่ใจหรือว่าต้องการลบการร้องขอนี้?'))) { window.location.href='${pageContext.request.contextPath}/lecturer/${lecturer_id}/${request_course.request_id}/delete_request_open_course'; return false; }"
                                                    class="btn btn-outline-danger">
                                                <i class='fas fa-trash' style='color: red'></i> ยกเลิก
                                            </button>
                                        </td>
                                    </tr>
                                </c:if>
                            </c:forEach>
                        </table>
                    </div>

                    <div id="false_approve">
                        <table class="table table-striped table-hover" style="font-size: 12px">
                            <tr style="color: black">
                                <td class="td_request">รายละเอียดการร้องขอ</td>
                                <td class="td_roc" align="center">วันที่ร้องขอ</td>
                                <td class="td_learn" align="center">ระยะเวลาเรียน</td>
                                <td class="td_qty" align="center">จำนวน</td>
                                <td class="td_type" align="center">ประเภท</td>
                                <td class="td_lec" align="center">สถานะ</td>
                                <td class="td_cancel" align="center"></td>
                            </tr>

                            <c:forEach var="request_course" items="${requests_open_course}">
                                <c:if test="${request_course.requestStatus == 'ไม่ผ่าน'}">
                                    <tr style="color: black">
                                        <td><p>${request_course.course.name}</p></td>
                                        <td align="center">${formattedDate}</td>
                                        <td align="center"><p>${startStudyDate} ถึง ${endStudyDate}</p></td>
                                        <td align="center"><p>${request_course.quantity}</p></td>
                                        <td align="center"><p>${request_course.type_learn}</p></td>
                                        <td align="center"><p style="color: red">ไม่ผ่าน</p></td>
                                        <td align="center">
                                            <a href="${pageContext.request.contextPath}/lecturer/<%=lecturer.getUsername()%>/${request_course.request_id}/update_page">
                                                <button type="button" class="btn btn-outline-warning" style="font-size: 12px">
                                                    <i style="color: #ff8d4e;" class="fa fa-edit" aria-hidden="true"></i> แก้ไข
                                                </button>
                                            </a>
                                            <button type="button" style="font-size: 12px"
                                                    onclick="if((confirm('คุณแน่ใจหรือว่าต้องการลบการร้องขอนี้?'))) { window.location.href='${pageContext.request.contextPath}/lecturer/${lecturer_id}/${request_course.request_id}/delete_request_open_course'; return false; }"
                                                    class="btn btn-outline-danger">
                                                <i class='fas fa-trash' style='color: red'></i> ยกเลิก
                                            </button>
                                        </td>
                                    </tr>
                                </c:if>
                            </c:forEach>
                        </table>
                    </div>
                </div>

            </td>
        </tr>

    </table>

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
    // ดึงค่าพารามิเตอร์ success จาก URL
    const urlParams = new URLSearchParams(window.location.search);
    const cancelParam = urlParams.get('cancelStatus');
    const addParam = urlParams.get('addStatus');
    const editParam = urlParams.get('editStatus');

    // ถ้ามีค่าเป็น 'true', แสดง Alert
    if (cancelParam === 'true') {
        alert("ยกเลิกข้อมูลการร้องขอสำเร็จ");
    }else if (addParam === 'true') {
        alert("เพิ่มข้อมูลการร้องขอสำเร็จ");
    }else if (editParam === 'true') {
        alert("แก้ไขข้อมูลการร้องขอสำเร็จ");
    }
</script>
<script>
    function checkSelection() {
        var selectElement = document.getElementById("select_type");
        var selectedValue = selectElement.value;

        if (selectedValue === "หลักสูตรที่ร้องขอ") {
            document.getElementById("tag_line").textContent = "หลักสูตรที่ร้องขอ"
            document.getElementById("pass_approve").style.display = "block";
            document.getElementById("false_approve").style.display = "none";
        } else if (selectedValue === "หลักสูตรที่ไม่ผ่านการร้องขอ") {
            document.getElementById("tag_line").textContent = "หลักสูตรที่ไม่ผ่านการร้องขอ"
            document.getElementById("pass_approve").style.display = "none";
            document.getElementById("false_approve").style.display = "block";
        }
    }
    window.addEventListener('load',checkSelection);
</script>
</html>
