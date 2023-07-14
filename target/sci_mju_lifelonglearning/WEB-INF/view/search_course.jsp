<%@ page import="java.text.DecimalFormat" %>
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

        div [class="block col-lg-4 col-md-6 wow zoomIn"]:hover{
            margin-top: 15px;
            transition: 0.5s;
        }

        .font-ab{
            font-size: 40px;
            color: black;
            font-weight: bold;
            font-family: Kanit SemiBold;
        }

        .btn-register-ab{
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
        .btn-register-ab:hover{
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
<!-- Navbar -->
<jsp:include page="/WEB-INF/view/layouts/nav.jsp"/>
<!-- Services Start -->
<div class="container-fluid py-5 wow fadeInUp" data-wow-delay="0.1s">
    <div class="container">
        <div class="text-center mx-auto mb-5" style="max-width: 600px;">
            <h5 class="text-primary text-uppercase" style="letter-spacing: 5px;">หลักสูตร</h5>
            <h1 class="display-5 mb-0">แนะนำสำหรับคุณ</h1>
        </div>
        <div class="row g-5">
            <input type="text" class="form-control me-2" id="searchInput" onkeyup="search()" placeholder="ค้นหาหลักสูตรที่คุณสนใจ..." style="width: 55%; margin-right: 2%">
                    <select class="form-select" name="majorId" id="majorSelect" style="width: 40%" onchange="document.location.href = 'http://localhost:8081/sci_mju_lifelonglearning_war_exploded/search_course/' + this.value">
<%--                    <select name="majorId" id="majorSelect" style="width: 40%">--%>
                        <option  value="หลักสูตรทั้งหมด">--กรุณาเลือกรายการ--</option>

                        <c:forEach items="${majors}" var="major">
                            <option value="${major.name}">${major.name}</option>
                        </c:forEach>
                    </select>
            <%! String majorName = "";%>

            <h3 id="showlist">${majorName}</h3>

            <!----------Course 1------------>
            <c:forEach var="course" items="${courses}">
                <%
                    DecimalFormat f = new DecimalFormat("#,###");
                %>
<%--                <c:set var="majorName" value="<%= type%>"/>--%>
                <fmt:parseNumber var="courseFee" type="number" value="${course.fee}"/>
                    <div class="block col-lg-4 col-md-6 wow zoomIn" style="transition: 0.5s" data-name=${course.name}>
                        <div class="col-lg-4 col-md-6 wow zoomIn" style="cursor: pointer" data-wow-delay="0.3s">
                            <div class="bg-light border-bottom border-5 border-primary rounded"
                                 style="width: 400px; height: 590px; box-shadow: 2px -2px 6px 1px #9c9c9c;">
                                <div class="p-5">
                                    <img src="${pageContext.request.contextPath}/assets/img/course_img/${course.img}"
                                         style="width: 400px;height: 350px;margin-top: -48px;margin-left: -48px;">
                                        <%--            <h5 class="text-primary mb-0">${course.course_id}</h5>--%>
                                    <div>
                                        <br>
<%--                                        <h4 class="item" style="max-width: 100px;display: -webkit-box;white-space: nowrap; overflow: hidden;text-overflow: ellipsis;-webkit-line-clamp: 2;--%>
<%--  -webkit-box-orient: vertical; " >${course.name}</h4>--%>
                                        <a href="${pageContext.request.contextPath}/course/${course.course_id}">
                                            <b><h4 class="item text_ellipsis" >${course.name}</h4></b>
                                        </a>
                                    </div>
                                    <p>${course.major.name}</p>
<%--                                    <h5>ระยะเวลา ${course.totalHours} ชั่วโมง</h5>--%>

                                    <b><p style="color: #0c7800; font-size: 22px">
<%--                                        <fmt:setLocale value="en_US"/>--%>
<%--                                        <fmt:formatNumber type="currency" value ="${courseFee}"/>--%>
                                            ราคา <fmt:formatNumber value="${courseFee}" />.00 บาท
                                    </p></b>
                                    <a href="${pageContext.request.contextPath}/course/${course.course_id}">อ่านเพิ่มเติม<i
                                            class="bi bi-arrow-right ms-2"></i></a></td>
                                </div>
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
    $(document).ready(function(){
        $("#majorSelect").change(function(){
            $("#majorSelect").val();
            var list = $("#majorSelect").val();
            $("#showlist").html(list);
        });
    });
</script>
</html>
