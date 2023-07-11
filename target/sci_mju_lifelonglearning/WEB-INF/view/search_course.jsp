<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
        .btn_register_course_detail{
            border-radius: 15px;
            background-color: #ff4900;
            color: white;
            font-weight: 600;
            width: 100%;
            height: 41px;
            border: 0;
        }
        .btn_readmore{
            background-color: #0d6efd;
            color: white;
        }
        .btn_readmore:hover{
            color: white;
        }

        .btn_contactus{
            background-color: #F14D5D;
            color: white;
        }
        .btn_contactus:hover{
            color: white;
        }
        .block {
            display: inline-block;
            float: left;

        }
    </style>

</head>

<body>
<!-- Navbar -->
<jsp:include page="/WEB-INF/view/layouts/nav.jsp"/>
<input type="button" value="ร้องขอ"onclick="window.location.href='${pageContext.request.contextPath}/request_open_course/request_open_course'; return false;"class="add-button"/>
<!-- Carousel Start -->

<div class="container-fluid p-0 mb-5">
    <div id="header-carousel" class="carousel slide carousel-fade" data-bs-ride="carousel">
        <div class="carousel-indicators">
            <button type="button" data-bs-target="#header-carousel" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
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
                <img class="w-100" src="${pageContext.request.contextPath}/assets/img/banner1.jpg" alt="Image" style="height: 886px;">
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
<!-- Services Start -->
<div class="container-fluid py-5 wow fadeInUp" data-wow-delay="0.1s">
    <div class="container">
        <div class="text-center mx-auto mb-5" style="max-width: 600px;">
            <h5 class="text-primary text-uppercase" style="letter-spacing: 5px;">หลักสูตร</h5>
            <h1 class="display-5 mb-0">แนะนำสำหรับคุณ</h1>
        </div>
        <div class="row g-5">
            <input type="text" id="searchInput" onkeyup="search()" placeholder="Search...">
            <!----------Course 1------------>
            <c:forEach var="course" items="${courses}">
                <c:if test="${course.course_type == 'Non-Degree'}">
                    <div class="block col-lg-4 col-md-6 wow zoomIn" data-name=${course.name}>
                        <div class="col-lg-4 col-md-6 wow zoomIn" data-wow-delay="0.3s">
                            <div class="service-item bg-light border-bottom border-5 border-primary rounded" style="width: 400px;box-shadow: 2px -2px 6px 1px #9c9c9c;">
                                <div class="position-relative p-5">
                                    <img src="${pageContext.request.contextPath}/assets/img/course_img/${course.img}" style="width: 300px; height: 300px">
                                        <%--            <h5 class="text-primary mb-0">${course.course_id}</h5>--%>
                                    <div>
                                        <br>
                                        <h3 class="item">${course.name}</h3>
                                            <%--              <h3 style="text-overflow: ellipsis;">${course.name}</h3>--%>
                                    </div>
                                    <p>${course.major.name}</p>
                                    <h5>ระยะเวลา ${course.totalHours} ชั่วโมง</h5>
                                    <h3 style="font-weight: bold;">ราคา ${course.fee}0 บาท</h3>
                                    <a href="${pageContext.request.contextPath}/course/${course.course_id}">อ่านเพิ่มเติม<i class="bi bi-arrow-right ms-2"></i></a></td>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:if>

            </c:forEach>
        </div>
    </div>
</div>
<!-- Blog End -->
<jsp:include page="/WEB-INF/view/layouts/footer.jsp"/>
</body>

</html>
