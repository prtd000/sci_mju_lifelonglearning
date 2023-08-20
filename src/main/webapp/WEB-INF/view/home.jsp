<%@ page import="java.text.DecimalFormat" %>
<%@ page import="org.hibernate.Session" %>
<%@ page import="lifelong.model.Admin" %>
<%@ page import="lifelong.model.Member" %>
<%@ page import="lifelong.model.Lecturer" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%! Session session; %>
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

        .btn_readmore {
            background-color: #0d6efd;
            color: white;
        }

        .btn_readmore:hover {
            color: white;
        }

        .btn_contactus {
            background-color: #F14D5D;
            color: white;
        }

        .btn_contactus:hover {
            color: white;
        }

        .block {
            display: inline-block;
            float: left;

        }

        .search_bar {
            border-radius: 18px;
            height: 50px;
            width: 1300px;
            margin-left: 21px;
            border: 1px solid;
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

        .btn_all_course_home {
            width: 175px;
            height: 47px;
            margin-top: -7px;
            border-radius: 16px;
            border: 1px solid black;
            font-weight: bold;
            background-color: #ffffff;
            color: black;
            transition: 0.5s;
        }

        .btn_all_course_home:hover {
            background-color: #005f00;
            color: white;
            border: 0;
            transition: 0.5s;
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

<%--<input type="button" value="ร้องขอ"onclick="window.location.href='${pageContext.request.contextPath}/course/add_course'; return false;"class="add-button"/>--%>
<%--<input type="button" value="ข่าวสาร"onclick="window.location.href='${pageContext.request.contextPath}/activity/public/add_activity'; return false;"class="add-button"/>--%>
<%--<input type="button" value="list ข่าวสาร"onclick="window.location.href='${pageContext.request.contextPath}/activity/public/list_activity'; return false;"class="add-button"/>--%>
<!-- Carousel Start -->
<div class="container-fluid p-0 mb-5">
    <div id="header-carousel" class="carousel slide carousel-fade" data-bs-ride="carousel">
        <div class="carousel-indicators">
            <button type="button" data-bs-target="#header-carousel" data-bs-slide-to="0" class="active"
                    aria-current="true" aria-label="Slide 1"></button>
            <button type="button" data-bs-target="#header-carousel" data-bs-slide-to="1" aria-label="Slide 2"></button>
            <button type="button" data-bs-target="#header-carousel" data-bs-slide-to="2" aria-label="Slide 3"></button>
        </div>
        <div class="carousel-inner">
            <div class="carousel-item active">
                <img class="w-100" src="${pageContext.request.contextPath}/assets/img/banner3.png" alt="Image">
                <div class="carousel-caption d-flex flex-column align-items-center justify-content-center">
                    <div class="p-3" style="max-width: 900px;">
                        <h1 class="display-1 text-white mb-md-4 animated zoomIn">LIFELONG LEARNING</h1>
                        <a href="" class="btn btn_readmore py-md-3 px-md-5 me-3 animated slideInLeft">เพิ่มเติม</a>
                        <a href="" class="btn btn_contactus py-md-3 px-md-5 animated slideInRight">ติดต่อเรา</a>
                    </div>
                </div>
            </div>
            <div class="carousel-item">
                <img class="w-100" src="${pageContext.request.contextPath}/assets/img/banner1.jpg" alt="Image"
                     style="height: 886px;">
                <div class="carousel-caption d-flex flex-column align-items-center justify-content-center">
                    <div class="p-3" style="max-width: 900px;">
                        <h1 class="display-1 text-white mb-md-4 animated zoomIn">SCIENCE MAEJO UNIVERSITY</h1>
                        <a href="" class="btn btn_readmore py-md-3 px-md-5 me-3 animated slideInLeft">เพิ่มเติม</a>
                        <a href="" class="btn btn_contactus py-md-3 px-md-5 animated slideInRight">ติดต่อเรา</a>
                    </div>
                </div>
            </div>
        </div>
        <button class="carousel-control-prev" type="button" data-bs-target="#header-carousel"
                data-bs-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Previous</span>
        </button>
        <button class="carousel-control-next" type="button" data-bs-target="#header-carousel"
                data-bs-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Next</span>
        </button>
    </div>
</div>
<!-- Carousel End -->


<!-------------------- Non-Degree ----------------------->
<div class="container-fluid py-5 wow fadeInUp" data-wow-delay="0.1s">
    <div class="container">
        <div class="text-center mx-auto mb-5" style="max-width: 600px;">
            <h5 class="text-primary text-uppercase" style="letter-spacing: 5px;">คอร์สแนะนำ</h5>
            <h1 class="display-5 mb-0">หลักสูตร Non-Degree</h1>
        </div>
        <!-------Search-------->
        <%--    <form action="search.jsp" method="get">--%>
        <%--      <input type="text" name="keyword" placeholder="Enter keyword">--%>
        <%--      <button type="submit">Search</button>--%>
        <%--    </form>--%>


        <div class="row g-5">
            <!----------Course 1------------>
            <c:set var="non_num" value="0"></c:set>
            <c:forEach var="course" items="${courses}">
                <% DecimalFormat f = new DecimalFormat("#,###"); %>
                <%-- <c:set var="majorName" value="<%= type%>"/> --%>
                <fmt:parseNumber var="courseFee" type="number" value="${course.fee}"/>
                <c:if test="${course.course_type == 'Non-Degree'}">
                    <c:if test="${non_num < 6}">
                            <div class="block col-lg-4 col-md-6 wow zoomIn" style="transition: 0.5s" data-name=${course.name}>
                                <div class="col-lg-4 col-md-6 wow zoomIn" style="cursor: pointer" data-wow-delay="0.3s">
                                    <div class="bg-light border-bottom border-5 border-primary rounded"
                                         style="width: 400px; height: 590px; box-shadow: 2px -2px 6px 1px #9c9c9c;">
                                        <a href="${pageContext.request.contextPath}/${course.course_id}">
                                        <div class="p-5">
                                            <img src="${pageContext.request.contextPath}/assets/img/course_img/${course.img}"
                                                 style="width: 400px;height: 350px;margin-top: -48px;margin-left: -48px;">
                                            <div>
                                                <br>

                                                <b><h4 class="item text_ellipsis">${course.name}</h4></b>

                                            </div>
                                            <p>${course.major.name}</p>
                                            <b><p style="color: #0c7800; font-size: 22px">
                                                ราคา <fmt:formatNumber value="${courseFee}"/>.00 บาท
                                            </p></b>
                                            <a href="${pageContext.request.contextPath}/${course.course_id}">อ่านเพิ่มเติม<i
                                                    class="bi bi-arrow-right ms-2"></i></a></td>
                                        </div>
                                        </a>
                                    </div>
                                </div>
                            </div>

                        <c:set var="non_num" value="${non_num+1}"></c:set>
                    </c:if>

                </c:if>
            </c:forEach>
        </div>

    </div>
</div>
<!--------------------End Non-Degree ----------------------->

<!-------------------- หลักสูตรอบรมระยะสั้น ----------------------->
<div class="container-fluid py-5 wow fadeInUp" data-wow-delay="0.1s">
    <div class="container">
        <div class="text-center mx-auto mb-5" style="max-width: 600px;">
            <h5 class="text-primary text-uppercase" style="letter-spacing: 5px;">คอร์สแนะนำ</h5>
            <h1 class="display-5 mb-0">หลักสูตรอบรมระยะสั้น</h1>
        </div>
        <!-------Search-------->
        <%--    <form action="search.jsp" method="get">--%>
        <%--      <input type="text" name="keyword" placeholder="Enter keyword">--%>
        <%--      <button type="submit">Search</button>--%>
        <%--    </form>--%>


        <div class="row g-5">
            <!----------Course 1------------>
            <c:set var="non_num" value="0"></c:set>
            <c:forEach var="course" items="${courses}">
                <% DecimalFormat f = new DecimalFormat("#,###"); %>
                <%-- <c:set var="majorName" value="<%= type%>"/> --%>
                <fmt:parseNumber var="courseFee" type="number" value="${course.fee}"/>
                <c:if test="${course.course_type == 'หลักสูตรอบรมระยะสั้น'}">
                    <c:if test="${non_num < 6}">
                            <div class="block col-lg-4 col-md-6 wow zoomIn" style="transition: 0.5s"
                                 data-name=${course.name}>
                                <div class="col-lg-4 col-md-6 wow zoomIn" style="cursor: pointer" data-wow-delay="0.3s">
                                    <div class="bg-light border-bottom border-5 border-primary rounded"
                                         style="width: 400px; height: 590px; box-shadow: 2px -2px 6px 1px #9c9c9c;">
                                        <a href="${pageContext.request.contextPath}/${course.course_id}">
                                        <div class="p-5">
                                            <img src="${pageContext.request.contextPath}/assets/img/course_img/${course.img}"
                                                 style="width: 400px;height: 350px;margin-top: -48px;margin-left: -48px;">
                                            <div>
                                                <br>
                                                <b><h4 class="item text_ellipsis">${course.name}</h4></b>
                                            </div>
                                            <p>${course.major.name}</p>
                                            <b><p style="color: #0c7800; font-size: 22px">
                                                ราคา <fmt:formatNumber value="${courseFee}"/>.00 บาท
                                            </p></b>
                                            <a href="${pageContext.request.contextPath}/course/${course.course_id}">อ่านเพิ่มเติม<i
                                                    class="bi bi-arrow-right ms-2"></i></a>
                                        </div>
                                        </a>
                                    </div>
                                </div>
                            </div>
                        <c:set var="non_num" value="${non_num+1}"></c:set>
                    </c:if>
                </c:if>
            </c:forEach>
        </div>
    </div>
</div>
<!--------------------End หลักสูตรอบรมระยะสั้น ----------------------->
<div align="center">
    <a href="${pageContext.request.contextPath}/search_course">
        <button class="btn_all_course_home">หลักสูตรทั้งหมด</button>
    </a>
</div>

<!-- Offer Start -->
<div class="container-fluid bg-offer my-5 py-5 wow zoomIn" data-wow-delay="0.1s">
    <div class="container py-5">
        <div class="row gx-5 justify-content-center">
            <div class="col-lg-7 text-center">
                <div class="text-center mx-auto mb-4" style="max-width: 600px;">
                    <h5 class="text-white text-uppercase" style="letter-spacing: 5px;">เริ่มต้นจากการรู้จัก</h5>
                    <h1 class="display-5 text-white">MJU Lifelong Education</h1>
                </div>
                <p class="text-white mb-4">ให้การเรียนรู้เป็นเรื่องใกล้ตัวคุณ</p>
                <a href="" class="btn btn-primary py-md-3 px-md-5 me-3">เรียนรู้เพิ่มเติม</a>
            </div>
        </div>
    </div>
</div>
<!-- Offer End -->

<!-- About Start -->
<div class="container-fluid py-5 wow fadeInUp" data-wow-delay="0.1s">
    <div class="container">
        <div class="row gx-5">
            <div class="col-lg-5 mb-5 mb-lg-0" style="min-height: 500px;">
                <div class="position-relative h-100">
                    <img class="position-absolute w-100 h-100 rounded wow zoomIn" data-wow-delay="0.3s"
                         src="${pageContext.request.contextPath}/assets/img/SURAWIWAT-01031.jpg"
                         style="object-fit: cover; box-shadow: -2px 2px 6px 2px #7c7c7c;">
                </div>
            </div>
            <div class="col-lg-7">
                <div class="mb-4">
                    <br><br><br>
                    <h5 class="text-primary text-uppercase" style="letter-spacing: 5px;">มาร่วมเป็นส่วนหนึ่งกับเรา</h5>
                    <br>
                    <p class="font-ab">เพิ่มโอกาศแห่งความสำเร็จ</p>
                    <p class="font-ab">ที่สร้างด้วยตัวคุณเอง</p>
                    <p class="font-ab">จากการเรียนรู้ที่ไม่มีสิ้นสุดกับพวกเรา</p>
                </div>
                <br><br><br><br>
                <button class="btn-register-ab">สมัครเลย !</button>
            </div>

        </div>
    </div>
</div>
<!-- Blog End -->
<jsp:include page="/WEB-INF/view/layouts/footer.jsp"/>
</body>

</html>
