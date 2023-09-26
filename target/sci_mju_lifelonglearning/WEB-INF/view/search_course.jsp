<%@ page import="java.text.DecimalFormat" %>
<%@ page import="lifelong.model.Admin" %>
<%@ page import="lifelong.model.Member" %>
<%@ page import="lifelong.model.Lecturer" %>
<%@ page import="lifelong.controller.MemberController" %>
<%@ page import="lifelong.dao.RegisterDaoImpl" %>
<%@ page import="java.util.List" %>
<%@ page import="lifelong.model.Register" %>
<%@ page import="org.springframework.beans.factory.annotation.Autowired" %>
<%@ page import="lifelong.service.RequestOpCourseService" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html lang="en">

<head>
    <meta charset="utf-8">
    <title>Science MJU Life Long Learning</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="Free HTML Templates" name="keywords">
    <meta content="Free HTML Templates" name="description">
    <%--  <link href="${pageContext.request.contextPath}/assets/css/home_style.css" rel="stylesheet"/>--%>
    <link href="https://fonts.googleapis.com/css2?family=Mitr:wght@500&display=swap" rel="stylesheet">
    <jsp:include page="/WEB-INF/view/layouts/detail-all-style.jsp"/>

    <style>
        .btn_register_course_detail {
            border-radius: 15px;
            background-color: #ff4900;
            color: white;
            font-weight: 600;
            width: 100%;
            height: 41px;
            border: 0;
        }

        .search_bar{
            width: 97%;
            height: 50px;
            border-radius: 7px;
            color: black;
            margin-left: 21px;
            font-size: 19px;
            border: 1px solid black;
            text-align: center;
        }

        .block {
            display: inline-block;
            float: left;
        }

        div [class="block col-lg-4 col-md-6 wow zoomIn"]:hover {
            margin-top: 15px;
            transition: 0.5s;
        }

        .font-ab {
            font-size: 40px;
            color: black;
            font-weight: bold;
            font-family: Kanit SemiBold;
        }

        .btn-register-ab {
            width: 175px;
            height: 47px;
            margin-top: -7px;
            border-radius: 16px;
            border: 0;
            font-weight: bold;
            background-color: #005f00;
            color: white;
            transition: 0.5s;
        }

        .btn-register-ab:hover {
            background-color: #0ca90c;
            transition: 0.5s;
        }

        #courseSelect option {
            white-space: pre-wrap;
        }

        .text_ellipsis {
            display: -webkit-box;
            max-width: 500px;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .course_name{
            font-family: 'Mitr', sans-serif;
            color: #e24c07;
            font-size: 20px;
            font-weight: 500;
            height: 63px;
        }

        /****User****/
        table[class='icon'] tr td:first-child{
            width: 44px;
            vertical-align: top;
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
<!-- Navbar End -->
<!-- Services Start -->
<div class="container-fluid py-5 wow fadeInUp" data-wow-delay="0.1s">
    <div class="container">
        <div class="text-center mx-auto mb-5" style="max-width: 600px;">
            <h5 class="text-primary text-uppercase" style="letter-spacing: 5px;">หลักสูตร</h5>
            <h1 class="display-5 mb-0">แนะนำสำหรับคุณ</h1>
        </div>

        <div class="row g-5">
            <!----------Search------------>
            <input type="text" class="form-control me-2 search_bar" id="searchInput" onkeyup="search()" placeholder="ค้นหาหลักสูตรที่คุณสนใจ...">
<%--            <select class="form-select" name="majorId" id="majorSelect" style="width: 40%"--%>
<%--                    onchange="document.location.href = '${pageContext.request.contextPath}/search_course/' + this.value">--%>
<%--                &lt;%&ndash;                    <select name="majorId" id="majorSelect" style="width: 40%">&ndash;%&gt;--%>
<%--                &lt;%&ndash;                    <select class="form-select" name="majorId" id="majorSelect" style="width: 40%" onchange="document.location.href = 'https://itsci.mju.ac.th/sci_mju_lifelonglearning/search_course/' + this.value">&ndash;%&gt;--%>
<%--                <option value="หลักสูตรทั้งหมด">--กรุณาเลือกรายการ--</option>--%>

<%--                <c:forEach items="${majors}" var="major">--%>
<%--                    <option value="${major.name}">${major.name}</option>--%>
<%--                </c:forEach>--%>
<%--            </select>--%>
<%--            <%! String majorName = "";%>--%>

<%--            <h3 id="showlist">${majorName}</h3>--%>

            <!----------End Search------------>

            <!----------Show List Course------------>

            <c:forEach var="course" items="${courses}">
                <%
                    DecimalFormat f = new DecimalFormat("#,###");
                %>
                <fmt:parseNumber var="courseFee" type="number" value="${course.fee}"/>

                <div class="block col-lg-4 col-md-6 wow zoomIn" style="transition: 0.5s" data-name=${course.name}>
                    <div class="col-lg-4 col-md-6 wow zoomIn" style="cursor: pointer" data-wow-delay="0.3s">
                        <div class="bg-light border-bottom border-5 border-primary rounded"
                             style="width: 400px; height: 670px; box-shadow: 2px -2px 6px 1px #9c9c9c;">

                            <c:choose>
                                <c:when test="${flag.equals('member')}">
                                    <div class="p-5">
                                        <img src="${pageContext.request.contextPath}/assets/img/course_img/${course.img}"
                                             style="width: 400px;height: 350px;margin-top: -48px;margin-left: -48px;">
                                        <br><br>
                                        <b><p class="item text_ellipsis course_name">${course.name}</p></b>
                                        <p style="font-weight: bold; color: dodgerblue">${course.course_type}</p>
                                        <table class="icon">
                                            <c:forEach var="list" items="${list_req}">
                                                <c:if test="${list.course.course_id eq course.course_id && list.type_learn.equals('เรียนในสถานศึกษา')}">
                                                    <tr>
                                                        <td><img src="${pageContext.request.contextPath}/assets/img/onsite.png" style="height: 25px;"></td>
                                                        <td><p style="color: #5b5b5b; font-weight: bold">${list.type_learn}</p></td>
                                                    </tr>
                                                </c:if>
                                                <c:if test="${list.course.course_id eq course.course_id && list.type_learn.equals('เรียนออนไลน์')}">
                                                    <tr>
                                                        <td><img src="${pageContext.request.contextPath}/assets/img/online.png" style="height: 25px;"></td>
                                                        <td><p style="color: #5b5b5b; font-weight: bold">${list.type_learn}</p></td>
                                                    </tr>
                                                </c:if>
                                                <c:if test="${list.course.course_id eq course.course_id && list.type_learn.equals('เรียนทั้งออนไลน์และในสถานศึกษา')}">
                                                    <tr>
                                                        <td><img src="${pageContext.request.contextPath}/assets/img/onsite.png" style="height: 25px;"></td>
                                                        <td><p style="color: #5b5b5b; font-weight: bold">${list.type_learn}</p></td>
                                                    </tr>
                                                </c:if>
                                            </c:forEach>
                                            <tr>
                                                <td><img src="${pageContext.request.contextPath}/assets/img/money.png" style="height: 25px;"></td>
                                                <td><b><p style="color: #12b100;">ราคา <fmt:formatNumber value="${courseFee}"/>.00 บาท</p></b></td>
                                            </tr>
                                        </table>
                                        <hr style="background-color: black">

                                        <c:set var="username" value="<%= member.getUsername() %>"/>
                                        <table>
                                            <tr>
                                                <td>
                                                    <c:forEach var="listReq" items="${listRequest}">
                                                        <c:choose>
                                                            <c:when test="${listReq.course.course_id.equals(course.course_id) && listReq.requestStatus.equals('ผ่าน')}">
                                                                <c:set var="status" value="true" />
                                                                <c:forEach var="invoices" items="${list_invoice}">
                                                                    <c:choose>
                                                                        <c:when test="${invoices.register.member.username.equals(username) && invoices.register.requestOpenCourse.request_id == listReq.request_id}">
                                                                            <c:if test="${invoices.pay_status == true && invoices.approve_status.equals('ผ่าน')}">
                                                                                <td style="width: 250px;">
                                                                                    <p style="color: red; font-family: 'Mitr', sans-serif; font-size: 20px; font-weight: 100;">ลงทะเบียนแล้ว</p>
                                                                                </td>
                                                                                <c:set var="status" value="false"/>
                                                                            </c:if>

                                                                            <c:if test="${invoices.pay_status == true && invoices.approve_status.equals('ไม่ผ่าน')}">
                                                                                <td style="width: 250px;">
                                                                                    <p style="color: #e8b904; font-family: 'Mitr', sans-serif; font-size: 20px; font-weight: 100;">รอดำเนินการ</p>
                                                                                </td>
                                                                                <c:set var="status" value="false"/>
                                                                            </c:if>

                                                                            <c:if test="${invoices.pay_status == false || (invoices.pay_status == true && invoices.approve_status.equals('รอดำเนินการ'))}">
                                                                                <td style="width: 250px;">
                                                                                    <p style="color: #e8b904; font-family: 'Mitr', sans-serif; font-size: 20px; font-weight: 100;">รอดำเนินการ</p>
                                                                                </td>
                                                                                <c:set var="status" value="false"/>
                                                                            </c:if>

                                                                            <td style="width: 129px; vertical-align: baseline;">
                                                                                <a href="${pageContext.request.contextPath}/member/${username}/register_course/${course.course_id}/${listReq.request_id}" style="font-family: 'Mitr', sans-serif; font-size: 20px; font-weight: 100;">
                                                                                    <b>อ่านเพิ่มเติม</b>
                                                                                </a>
                                                                            </td>
                                                                        </c:when>
                                                                    </c:choose>
                                                                </c:forEach>

                                                                <c:if test="${empty list_invoice || status == true}">
                                                                    <td style="width: 250px; vertical-align: baseline;">
                                                                        <a href="${pageContext.request.contextPath}/member/${username}/register_course/${course.course_id}/${listReq.request_id}" style="font-family: 'Mitr', sans-serif; font-size: 20px; font-weight: 500;">ลงทะเบียน<i class="bi bi-arrow-right ms-2"></i></a>
                                                                    </td>
                                                                    <td>
                                                                        <a href="${pageContext.request.contextPath}/member/${username}/register_course/${course.course_id}/${listReq.request_id}">
                                                                            <p style="color: green; font-family: 'Mitr', sans-serif; font-size: 20px; font-weight: 500;">เปิด</p>
                                                                        </a>
                                                                    </td>
                                                                </c:if>
                                                            </c:when>
                                                        </c:choose>
                                                    </c:forEach>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </c:when>

                                <%-------- User ---------%>
                                <c:otherwise>
                                    <a href="${pageContext.request.contextPath}/${course.course_id}">
                                        <div class="p-5">
                                            <img src="${pageContext.request.contextPath}/assets/img/course_img/${course.img}"
                                                 style="width: 400px;height: 350px;margin-top: -48px;margin-left: -48px;">
                                            <div>
                                                <br>
                                                <b><p class="item text_ellipsis course_name">${course.name}</p></b>
                                            </div>
                                            <p style="font-weight: bold; color: dodgerblue">${course.course_type}</p>
                                            <table class="icon">
                                                <c:forEach var="list" items="${list_req}">
                                                    <c:if test="${list.course.course_id eq course.course_id && list.type_learn.equals('เรียนในสถานศึกษา')}">
                                                        <tr>
                                                            <td><img src="${pageContext.request.contextPath}/assets/img/onsite.png" style="height: 25px;"></td>
                                                            <td><p style="color: #5b5b5b; font-weight: bold">${list.type_learn}</p></td>
                                                        </tr>
                                                    </c:if>
                                                    <c:if test="${list.course.course_id eq course.course_id && list.type_learn.equals('เรียนออนไลน์')}">
                                                        <tr>
                                                            <td><img src="${pageContext.request.contextPath}/assets/img/online.png" style="height: 25px;"></td>
                                                            <td><p style="color: #5b5b5b; font-weight: bold">${list.type_learn}</p></td>
                                                        </tr>
                                                    </c:if>
                                                    <c:if test="${list.course.course_id eq course.course_id && list.type_learn.equals('เรียนทั้งออนไลน์และในสถานศึกษา')}">
                                                        <tr>
                                                            <td><img src="${pageContext.request.contextPath}/assets/img/onsite.png" style="height: 25px;"></td>
                                                            <td><p style="color: #5b5b5b; font-weight: bold">${list.type_learn}</p></td>
                                                        </tr>
                                                    </c:if>
                                                </c:forEach>
                                                <tr>
                                                    <td><img src="${pageContext.request.contextPath}/assets/img/money.png" style="height: 25px;"></td>
                                                    <td><b><p style="color: #12b100;">ราคา <fmt:formatNumber value="${courseFee}"/>.00 บาท</p></b></td>
                                                </tr>
                                            </table>

                                            <hr style="background-color: black">

                                            <table>
                                                <tr>
                                                    <td style="width: 250px; vertical-align: top;">
                                                        <a href="${pageContext.request.contextPath}/${course.course_id}" style="font-family: 'Mitr', sans-serif; font-size: 20px; font-weight: 500;">อ่านเพิ่มเติม<i class="bi bi-arrow-right ms-2"></i></a>
                                                    </td>
                                                    <td style="width: 95px;">
                                                        <c:forEach var="listReq" items="${listRequest}">
                                                            <c:choose>
                                                                <c:when test="${listReq.course.course_id.equals(course.course_id) && listReq.requestStatus.equals('ผ่าน')}">
                                                                    <p style="color: green; font-weight: 500; font-family: 'Mitr', sans-serif; font-size: 22px;text-align: right;">เปิด</p>
                                                                </c:when>
                                                                <c:when test="${listReq.course.course_id.equals(course.course_id) && listReq.requestStatus.equals('รอดำเนินการ')}">
                                                                    <p style="color: #e24c07; font-weight: 100; font-family: 'Mitr', sans-serif; font-size: 22px; text-align: right;">เร็วๆนี้</p>
                                                                </c:when>
                                                            </c:choose>
                                                        </c:forEach>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </a>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</div>
<!-- Blog End -->
<jsp:include page="/WEB-INF/view/layouts/footer.jsp"/>
</body>
<script>
    $(document).ready(function () {
        $("#majorSelect").change(function () {
            $("#majorSelect").val();
            var list = $("#majorSelect").val();
            $("#showlist").html(list);
        });
    });

    function search() {
        var input = document.getElementById("searchInput").value.toLowerCase();
        var blocks = document.getElementsByClassName("block");

        for (var i = 0; i < blocks.length; i++) {
            var block = blocks[i];
            var text = block.getAttribute("data-name").toLowerCase();

            if (text.includes(input)) {
                block.style.display = "block";
            } else {
                block.style.display = "none";
            }
        }
    }
</script>


</html>