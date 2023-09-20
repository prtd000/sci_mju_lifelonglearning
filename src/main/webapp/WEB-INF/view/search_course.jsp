<%@ page import="java.text.DecimalFormat" %>
<%@ page import="lifelong.model.Admin" %>
<%@ page import="lifelong.model.Member" %>
<%@ page import="lifelong.model.Lecturer" %>
<%@ page import="lifelong.controller.MemberController" %>
<%@ page import="lifelong.dao.RegisterDaoImpl" %>
<%@ page import="java.util.List" %>
<%@ page import="lifelong.model.Register" %>
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

<c:set var="flag" value="<%= flag %>"></c:set>
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
            <input type="text" class="form-control me-2" id="searchInput" onkeyup="search()"
                   placeholder="ค้นหาหลักสูตรที่คุณสนใจ..." style="width: 55%; margin-right: 2%">
            <select class="form-select" name="majorId" id="majorSelect" style="width: 40%"
                    onchange="document.location.href = '${pageContext.request.contextPath}/search_course/' + this.value">
                <%--                    <select name="majorId" id="majorSelect" style="width: 40%">--%>
                <%--                    <select class="form-select" name="majorId" id="majorSelect" style="width: 40%" onchange="document.location.href = 'https://itsci.mju.ac.th/sci_mju_lifelonglearning/search_course/' + this.value">--%>
                <option value="หลักสูตรทั้งหมด">--กรุณาเลือกรายการ--</option>

                <c:forEach items="${majors}" var="major">
                    <option value="${major.name}">${major.name}</option>
                </c:forEach>
            </select>
            <%! String majorName = "";%>

            <h3 id="showlist">${majorName}</h3>

            <!----------End Search------------>

            <!----------Course 1------------>

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
                                        <h4 class="item text_ellipsis">${course.name}</h4></b>
                                        <p>${course.major.name}</p>
                                        <p style="font-weight: bold; color: dodgerblue">${course.course_type}</p>
                                        <c:forEach var="list" items="${list_req}">
                                            <c:if test="${list.course.course_id eq course.course_id}">
                                                <p style="color: red; font-weight: bold">${list.type_learn}</p>
                                            </c:if>
                                        </c:forEach>
                                        <b><p style="color: #0c7800; font-size: 22px">ราคา <fmt:formatNumber value="${courseFee}"/>.00 บาท</p></b>

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
                                                                                    <p style="color: red; font-weight: bold;">ลงทะเบียนแล้ว</p>
                                                                                </td>
                                                                                <c:set var="status" value="false"/>
                                                                            </c:if>

                                                                            <c:if test="${invoices.pay_status == false || (invoices.pay_status == true && invoices.approve_status.equals('รอดำเนินการ'))}">
                                                                                <td style="width: 250px;">
                                                                                    <p style="color: #c9c92f; font-weight: bold">รอดำเนินการ</p>
                                                                                </td>
                                                                                <c:set var="status" value="false"/>
                                                                            </c:if>
                                                                            <td style="width: 129px; vertical-align: baseline;">
                                                                                <a href="${pageContext.request.contextPath}/member/${username}/register_course/${course.course_id}/${listReq.request_id}">
                                                                                    <b>อ่านเพิ่มเติม</b>
                                                                                </a>
                                                                            </td>
                                                                        </c:when>
                                                                    </c:choose>
                                                                </c:forEach>

                                                                <c:if test="${empty list_invoice || status == true}">
                                                                    <td style="width: 250px; vertical-align: baseline;">
                                                                        <a href="${pageContext.request.contextPath}/member/${username}/register_course/${course.course_id}/${listReq.request_id}"><b>ลงทะเบียน</b><i class="bi bi-arrow-right ms-2"></i></a>
                                                                    </td>
                                                                    <td>
                                                                        <a href="${pageContext.request.contextPath}/member/${username}/register_course/${course.course_id}/${listReq.request_id}">
                                                                            <p style="color: green; font-weight: bold">เปิด</p>
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
                                                <b><h4 class="item text_ellipsis">${course.name}</h4></b>
                                            </div>
                                            <p>${course.major.name}</p>
                                            <p style="font-weight: bold; color: dodgerblue">${course.course_type}</p>
                                            <c:forEach var="list" items="${list_req}">
                                                <c:if test="${list.course.course_id eq course.course_id}">
                                                    <p style="color: red; font-weight: bold">${list.type_learn}</p>
                                                </c:if>
                                            </c:forEach>
                                            <b><p style="color: #0c7800; font-size: 22px">ราคา <fmt:formatNumber
                                                    value="${courseFee}"/>.00 บาท</p></b>

                                            <table>
                                                <tr>
                                                    <td style="width: 250px;">
                                                        <a href="${pageContext.request.contextPath}/${course.course_id}">อ่านเพิ่มเติม<i
                                                                class="bi bi-arrow-right ms-2"></i></a>
                                                    </td>
                                                    <td>
                                                        <c:forEach var="listReq" items="${listRequest}">
                                                            <c:choose>
                                                                <c:when test="${listReq.course.course_id.equals(course.course_id)}">
                                                                    <p style="color: green; font-weight: bold">เปิด</p>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <p style="color: green"></p>
                                                                </c:otherwise>
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
</script>
</html>