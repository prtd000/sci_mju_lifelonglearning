<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <title>Login</title>
    <!-- Customized Bootstrap Stylesheet -->
    <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/member.css" rel="stylesheet">
</head>

<body>

<!-- Hero Start -->
<div class="container-fluid bg-primary p-5 hero-header mb-5">
    <div class="row py-5">
        <div class="col-12 text-center">
            <h1 class="display-1 text-white animated zoomIn">Login</h1>
        </div>
    </div>
</div>
<!-- Hero End -->


<!-- Contact Start -->
<div class="container-fluid py-5 wow fadeInUp" data-wow-delay="0.1s">
    <div class="container">
        <div class="row g-5">
            <!--Login Block-->
            <div class="log-block">
                <div class="col-lg-7 wow slideInUp" data-wow-delay="0.3s">
                    <div class="bg-light rounded p-5">
                        <form>
                            <div class="row g-3">
                                <div class="col-12">
                                    <input type="text" class="form-control border-0 px-4" placeholder="Username" style="height: 55px;">
                                </div>
                                <div class="col-12">
                                    <input type="text" class="form-control border-0 px-4" placeholder="Password" style="height: 55px;">
                                </div>
                                <div class="col-12">
                                    <button class="btn btn-primary w-100 py-3" type="submit">Login</button>
                                </div>
                                <div class="col-12">
                                    <button class="btn btn-primary w-100 py-3">Register</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>

</html>