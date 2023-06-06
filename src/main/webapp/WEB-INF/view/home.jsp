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
<%--<input type="button" value="ร้องขอ"onclick="window.location.href='${pageContext.request.contextPath}/request/request_open_course'; return false;"class="add-button"/>--%>
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


<!-- About Start -->
<div class="container-fluid py-5 wow fadeInUp" data-wow-delay="0.1s">
  <div class="container">
    <div class="row gx-5">
      <div class="col-lg-5 mb-5 mb-lg-0" style="min-height: 500px;">
        <div class="position-relative h-100">
          <img class="position-absolute w-100 h-100 rounded wow zoomIn" data-wow-delay="0.3s" src="${pageContext.request.contextPath}/assets/img/img1.jpg" style="object-fit: cover;">
        </div>
      </div>
      <div class="col-lg-7">
        <div class="mb-4">
          <h5 class="text-primary text-uppercase" style="letter-spacing: 5px;">เกี่ยวกับเรา</h5>
          <h1 class="display-5 mb-0">LIFELONG LEARNING</h1>
        </div>
        <h4 class="text-body fst-italic mb-4" style="font-size: 20px;"> </h4>

        <p class="mb-4 font-jus">คือ รูปแบบหนึ่งของการศึกษาที่เริ่มต้นเรียนรู้สิ่งใหม่ ๆ ด้วยตัวเอง (Self-initiated study) <br> ซึ่งเน้นการพัฒนาส่วนบุคคล โดยไม่เกี่ยงว่าจะอยู่ในวัยไหนก็สามารถเรื่องรู้ได้ต่อไปเรื่อย ๆ ไม่มีที่สิ้นสุด และถึงแม้ว่าจะไม่มีคำจำกัดความที่เป็นมาตรฐานของ Lifelong Learning แต่โดยทั่วไปมักถูกนำไปอ้างถึงการเรียนรู้ที่เกิดขึ้นนอกสถาบันการศึกษาในระบบ เช่น โรงเรียน มหาวิทยาลัย หรือการฝึกอบรมขององค์กร</p>


      </div>
    </div>
  </div>
</div>
<!-- About End -->

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


<!-- Services Start -->
<div class="container-fluid py-5 wow fadeInUp" data-wow-delay="0.1s">
  <div class="container">
    <div class="text-center mx-auto mb-5" style="max-width: 600px;">
      <h5 class="text-primary text-uppercase" style="letter-spacing: 5px;">หลักสูตร</h5>
      <h1 class="display-5 mb-0">แนะนำสำหรับคุณ</h1>
    </div>


    <!-------Search-------->
<%--    <form action="search.jsp" method="get">--%>
<%--      <input type="text" name="keyword" placeholder="Enter keyword">--%>
<%--      <button type="submit">Search</button>--%>
<%--    </form>--%>



    <div class="row g-5">
      <input type="text" id="searchInput" onkeyup="search()" placeholder="Search...">
      <!----------Course 1------------>
<c:forEach var="course" items="${courses}">
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


</c:forEach>
    </div>
  </div>
</div>
<!-- Services End -->


<!-- Pricing Plan Start -->
<!--
<div class="container-fluid py-5 wow fadeInUp" data-wow-delay="0.1s" style="margin-bottom: 75px;">
  <div class="container">
    <div class="text-center mx-auto mb-5" style="max-width: 600px;">
      <h5 class="text-primary text-uppercase" style="letter-spacing: 5px;">Pricing Plan</h5>
      <h1 class="display-5 mb-0">Pricing Plan For CCTV Security Services</h1>
    </div>
    <div class="row g-5">
      <div class="col-lg-4 wow slideInUp" data-wow-delay="0.3s">
        <div class="position-relative border border-primary rounded">
          <div class="bg-primary text-center pt-5 pb-4">
            <h3 class="text-white">Basic Plan</h3>
            <h1 class="display-4 text-white">
              <small class="align-top"
                     style="font-size: 22px; line-height: 45px;">$</small>49<small
                    class="align-bottom" style="font-size: 16px; line-height: 40px;">/
              Mo</small>
            </h1>
          </div>
          <div class="text-center py-5">
            <p class="border-bottom border-light mb-2 pb-2">HTML5 & CSS3</p>
            <p class="border-bottom border-light mb-2 pb-2">Bootstrap v5</p>
            <p class="border-bottom border-light mb-2 pb-2">Responsive Layout</p>
            <p class="border-bottom border-light mb-2 pb-2">Browsers Compatibility</p>
            <p class="mb-2 pb-2">Easy to Use</p>
          </div>
          <a href="" class="btn btn-primary py-2 px-4 position-absolute top-100 start-50 translate-middle">Order Now</a>
        </div>
      </div>
      <div class="col-lg-4 wow slideInUp" data-wow-delay="0.6s">
        <div class="position-relative border border-secondary rounded">
          <div class="bg-secondary text-center pt-5 pb-4">
            <h3 class="text-white">Standard Plan</h3>
            <h1 class="display-4 text-white">
              <small class="align-top"
                     style="font-size: 22px; line-height: 45px;">$</small>49<small
                    class="align-bottom" style="font-size: 16px; line-height: 40px;">/
              Mo</small>
            </h1>
          </div>
          <div class="text-center py-5">
            <p class="border-bottom border-light mb-2 pb-2">HTML5 & CSS3</p>
            <p class="border-bottom border-light mb-2 pb-2">Bootstrap v5</p>
            <p class="border-bottom border-light mb-2 pb-2">Responsive Layout</p>
            <p class="border-bottom border-light mb-2 pb-2">Browsers Compatibility</p>
            <p class="mb-2 pb-2">Easy to Use</p>
          </div>
          <a href="" class="btn btn-secondary py-2 px-4 position-absolute top-100 start-50 translate-middle">Order Now</a>
        </div>
      </div>
      <div class="col-lg-4 wow slideInUp" data-wow-delay="0.9s">
        <div class="position-relative border border-primary rounded">
          <div class="bg-primary text-center pt-5 pb-4">
            <h3 class="text-white">Extended Plan</h3>
            <h1 class="display-4 text-white">
              <small class="align-top"
                     style="font-size: 22px; line-height: 45px;">$</small>49<small
                    class="align-bottom" style="font-size: 16px; line-height: 40px;">/
              Mo</small>
            </h1>
          </div>
          <div class="text-center py-5">
            <p class="border-bottom border-light mb-2 pb-2">HTML5 & CSS3</p>
            <p class="border-bottom border-light mb-2 pb-2">Bootstrap v5</p>
            <p class="border-bottom border-light mb-2 pb-2">Responsive Layout</p>
            <p class="border-bottom border-light mb-2 pb-2">Browsers Compatibility</p>
            <p class="mb-2 pb-2">Easy to Use</p>
          </div>
          <a href="" class="btn btn-primary py-2 px-4 position-absolute top-100 start-50 translate-middle">Order Now</a>
        </div>
      </div>
    </div>
  </div>
</div>
-->

<!-- Pricing Plan End -->





<!-- Team Start -->
<!--
<div class="container-fluid py-5 wow fadeInUp" data-wow-delay="0.1s">
  <div class="container">
    <div class="text-center mx-auto mb-5" style="max-width: 600px;">
      <h5 class="text-primary text-uppercase" style="letter-spacing: 5px;">Team Members</h5>
      <h1 class="display-5 mb-0">Our Professional Team Members</h1>
    </div>
    <div class="row g-5">
      <div class="col-lg-4 wow slideInUp" data-wow-delay="0.3s">
        <div class="position-relative rounded-top">
          <img class="img-fluid rounded-top w-100" src="${pageContext.request.contextPath}/assets/img/team-1.jpg" alt="">
          <div class="position-absolute bottom-0 end-0 d-flex flex-column bg-white p-1" style="margin-right: -25px;">
            <a class="btn btn-outline-secondary btn-square m-1" href="#"><i class="fab fa-twitter fw-normal"></i></a>
            <a class="btn btn-outline-secondary btn-square m-1" href="#"><i class="fab fa-facebook-f fw-normal"></i></a>
            <a class="btn btn-outline-secondary btn-square m-1" href="#"><i class="fab fa-linkedin-in fw-normal"></i></a>
            <a class="btn btn-outline-secondary btn-square m-1" href="#"><i class="fab fa-instagram fw-normal"></i></a>
          </div>
        </div>
        <div class="bg-primary text-center rounded-bottom p-4">
          <h3 class="text-white">Full Name</h3>
          <p class="text-white m-0">Designation</p>
        </div>
      </div>
      <div class="col-lg-4 wow slideInUp" data-wow-delay="0.6s">
        <div class="position-relative rounded-top">
          <img class="img-fluid rounded-top w-100" src="${pageContext.request.contextPath}/assets/img/team-2.jpg" alt="">
          <div class="position-absolute bottom-0 end-0 d-flex flex-column bg-white p-1" style="margin-right: -25px;">
            <a class="btn btn-outline-secondary btn-square m-1" href="#"><i class="fab fa-twitter fw-normal"></i></a>
            <a class="btn btn-outline-secondary btn-square m-1" href="#"><i class="fab fa-facebook-f fw-normal"></i></a>
            <a class="btn btn-outline-secondary btn-square m-1" href="#"><i class="fab fa-linkedin-in fw-normal"></i></a>
            <a class="btn btn-outline-secondary btn-square m-1" href="#"><i class="fab fa-instagram fw-normal"></i></a>
          </div>
        </div>
        <div class="bg-primary text-center rounded-bottom p-4">
          <h3 class="text-white">Full Name</h3>
          <p class="text-white m-0">Designation</p>
        </div>
      </div>
      <div class="col-lg-4 wow slideInUp" data-wow-delay="0.9s">
        <div class="position-relative rounded-top">
          <img class="img-fluid rounded-top w-100" src="${pageContext.request.contextPath}/assets/img/team-3.jpg" alt="">
          <div class="position-absolute bottom-0 end-0 d-flex flex-column bg-white p-1" style="margin-right: -25px;">
            <a class="btn btn-outline-secondary btn-square m-1" href="#"><i class="fab fa-twitter fw-normal"></i></a>
            <a class="btn btn-outline-secondary btn-square m-1" href="#"><i class="fab fa-facebook-f fw-normal"></i></a>
            <a class="btn btn-outline-secondary btn-square m-1" href="#"><i class="fab fa-linkedin-in fw-normal"></i></a>
            <a class="btn btn-outline-secondary btn-square m-1" href="#"><i class="fab fa-instagram fw-normal"></i></a>
          </div>
        </div>
        <div class="bg-primary text-center rounded-bottom p-4">
          <h3 class="text-white">Full Name</h3>
          <p class="text-white m-0">Designation</p>
        </div>
      </div>
    </div>
  </div>
</div>
-->
<!-- Team End -->


<!-- Testimonial Start --->

<%--<div class="container-fluid py-5 wow fadeInUp" data-wow-delay="0.1s">--%>
<%--  <div class="container">--%>
<%--    <div class="text-center mx-auto mb-5" style="max-width: 600px;">--%>
<%--      <h5 class="text-primary text-uppercase" style="letter-spacing: 5px;">Testimonial</h5>--%>
<%--      <h1 class="display-5 mb-0">What People Say About Our Services</h1>--%>
<%--    </div>--%>
<%--    <div class="owl-carousel testimonial-carousel">--%>
<%--      <div class="text-center pb-4">--%>
<%--        <img class="img-fluid mx-auto rounded-circle" src="${pageContext.request.contextPath}/assets/img/testimonial-1.jpg" style="width: 100px; height: 100px;" >--%>
<%--        <div class="testimonial-text bg-light rounded p-4 mt-n5">--%>
<%--          <p class="mt-5">Dolor et eos labore, stet justo sed est sed. Diam sed sed dolor stet amet eirmod eos labore diam--%>
<%--          </p>--%>
<%--          <h4 class="text-truncate">Client Name</h4>--%>
<%--          <i>Profession</i>--%>
<%--        </div>--%>
<%--      </div>--%>
<%--      <div class="text-center">--%>
<%--        <img class="img-fluid mx-auto rounded-circle" src="${pageContext.request.contextPath}/assets/img/testimonial-2.jpg" style="width: 100px; height: 100px;" >--%>
<%--        <div class="testimonial-text bg-light rounded p-4 mt-n5">--%>
<%--          <p class="mt-5">Dolor et eos labore, stet justo sed est sed. Diam sed sed dolor stet amet eirmod eos labore diam--%>
<%--          </p>--%>
<%--          <h4 class="text-truncate">Client Name</h4>--%>
<%--          <i>Profession</i>--%>
<%--        </div>--%>
<%--      </div>--%>
<%--      <div class="text-center">--%>
<%--        <img class="img-fluid mx-auto rounded-circle" src="${pageContext.request.contextPath}/assets/img/testimonial-3.jpg" style="width: 100px; height: 100px;" >--%>
<%--        <div class="testimonial-text bg-light rounded p-4 mt-n5">--%>
<%--          <p class="mt-5">Dolor et eos labore, stet justo sed est sed. Diam sed sed dolor stet amet eirmod eos labore diam--%>
<%--          </p>--%>
<%--          <h4 class="text-truncate">Client Name</h4>--%>
<%--          <i>Profession</i>--%>
<%--        </div>--%>
<%--      </div>--%>
<%--      <div class="text-center">--%>
<%--        <img class="img-fluid mx-auto rounded-circle" src="${pageContext.request.contextPath}/assets/img/testimonial-4.jpg" style="width: 100px; height: 100px;" >--%>
<%--        <div class="testimonial-text bg-light rounded p-4 mt-n5">--%>
<%--          <p class="mt-5">Dolor et eos labore, stet justo sed est sed. Diam sed sed dolor stet amet eirmod eos labore diam--%>
<%--          </p>--%>
<%--          <h4 class="text-truncate">Client Name</h4>--%>
<%--          <i>Profession</i>--%>
<%--        </div>--%>
<%--      </div>--%>
<%--    </div>--%>
<%--  </div>--%>
<%--</div>--%>
<!-- Testimonial End -->


<!-- Blog Start -->
<!--
<div class="container-fluid py-5 wow fadeInUp" data-wow-delay="0.1s">
  <div class="container">
    <div class="text-center mx-auto mb-5" style="max-width: 600px;">
      <h5 class="text-primary text-uppercase" style="letter-spacing: 5px;">Blog Post</h5>
      <h1 class="display-5 mb-0">Latest Articles From Our Blog Post</h1>
    </div>
    <div class="row g-5">
      <div class="col-lg-6 wow slideInUp" data-wow-delay="0.3s">
        <div class="blog-item">
          <div class="position-relative">
            <img class="img-fluid w-100 rounded-top" src="${pageContext.request.contextPath}/assets/img/blog-1.jpg" alt="">
            <div class="blog-date">
              <h5 class="text-white fw-bold mb-0">01</h5>
              <h6 class="text-light mb-0">January</h6>
            </div>
          </div>
          <div class="bg-primary rounded-bottom p-5">
            <div class="d-flex mb-3">
              <span class="text-light text-uppercase">Admin</span>
              <span class="text-light px-2">|</span>
              <span class="text-light text-uppercase">Web Design</span>
            </div>
            <a class="h3 m-0 text-white" href="">Kasd dolor lorem sit justo rebum stet justo elitr dolor amet sit</a>
          </div>
        </div>
      </div>
      <div class="col-lg-6 wow slideInUp" data-wow-delay="0.6s">
        <div class="blog-item">
          <div class="position-relative">
            <img class="img-fluid w-100 rounded-top" src="${pageContext.request.contextPath}/assets/img/blog-2.jpg" alt="">
            <div class="blog-date">
              <h5 class="text-white fw-bold mb-0">01</h5>
              <h6 class="text-light mb-0">January</h6>
            </div>
          </div>
          <div class="bg-primary rounded-bottom p-5">
            <div class="d-flex mb-3">
              <span class="text-light text-uppercase">Admin</span>
              <span class="text-light px-2">|</span>
              <span class="text-light text-uppercase">Web Design</span>
            </div>
            <a class="h3 m-0 text-white" href="">Kasd dolor lorem sit justo rebum stet justo elitr dolor amet sit</a>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
-->


<!-- Blog End -->
<jsp:include page="/WEB-INF/view/layouts/footer.jsp"/>
</body>

</html>
