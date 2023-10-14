<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<html>
<head>
    <title>Login</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <link href="https://fonts.googleapis.com/css2?family=Mitr:wght@200&family=Prompt:wght@200&display=swap" rel="stylesheet">

    <jsp:include page="/WEB-INF/view/layouts/detail-all-style.jsp"/>
    <script>
        /****************** Script *****************************/
        function checkScript(frm) {
            //Check Username
            var username = /^[A-Za-z0-9(_)]{4,10}$/;
            if (!frm.username.value.match(username)) {
                alert("กรุณากรอกบัญชีผู้ใช้เป็นภาษาอังกฤษและตัวเลข (อย่างน้อย 4 - 10 ตัว)");
                frm.username.value = "";
                return false;
            }

            //Check Password
            var password = /^[0-9]{4,8}$/;
            if (!frm.password.value.match(password)) {
                alert("รหัสผ่านต้องเป็นตัวเลข (อย่างน้อย 4 - 8 ตัว)");
                frm.password.value = "";
                return false;
            }
        }
    </script>

    <style>
        .log-div{
            width: fit-content;
            padding: 86px;
            box-shadow: 0px 0px 10px 2px #c6c5c5;
            border-radius: 10px;
        }
        .header{
            font-size: 37px;
            font-family: 'Mitr', sans-serif;
            color: #3b5f3b;
            font-weight: bold;
            position: absolute;
            top: 31%;
            left: 50%;
            transform: translate(-50%, -50%);
        }
    </style>
</head>
<body>

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
    <div class="collapse navbar-collapse" style="margin-right: 43px;">
        <div class="navbar-nav ms-auto py-0">
            <a href="${pageContext.request.contextPath}/" class="nav-item nav-link" style="font-size: 17px">หน้าหลัก</a>
<%--            <a href="#" class="nav-item nav-link" style="font-size: 17px">เกี่ยวกับคณะ</a>--%>
            <a href="${pageContext.request.contextPath}/search_course" class="nav-item nav-link" style="font-size: 17px">หลักสูตรการอบรม</a>
            <a href="${pageContext.request.contextPath}/view_activity" class="nav-item nav-link" style="font-size: 17px">ข่าวสารและกิจกรรม</a>
<%--            <a href="#" class="nav-item nav-link" style="font-size: 17px">เกี่ยวกับเรา</a>--%>
            <div class="nav-item dropdown">
                <a href="#" class="nav-link dropdown-toggle nav-item active" data-bs-toggle="dropdown" style="font-size: 17px">เข้าสู่ระบบ</a>
                <div class="dropdown-menu m-0">
                    <a href="${pageContext.request.contextPath}/loginMember" class="dropdown-item" style="font-size: 17px">สำหรับสมาชิก</a>
                    <a href="${pageContext.request.contextPath}/loginLecturer" class="dropdown-item" style="font-size: 17px">สำหรับบุคลากร</a>
                    <a href="${pageContext.request.contextPath}/loginAdmin" class="dropdown-item" style="font-size: 17px">สำหรับผู้ดูแลระบบ</a>
                </div>
            </div>
        </div>
    </div>
</nav>
<!-- Navbar End -->

<center>
    <br><br><br>
    <p class="header">${title}</p>

    <div class="log-div">
        <br><br><br>
        <form action="${pageContext.request.contextPath}/doLoginMember" name="frm" method="POST">
            <table>
                <tr>
                    <td style="width: 88px; font-weight: bold; color: black; font-size: 19px;"><p class="form-label">ชื่อผู้ใช้</p></td>
                    <td><input type="text" name="username" class="form-control"/> <br></td>
                </tr>

                <tr>
                    <td style="width: 88px; font-weight: bold; color: black; font-size: 19px;"><p class="form-label">รหัสผ่าน</p></td>
                    <td><input type="password" name="password" class="form-control"/> <br></td>
                </tr>

                <tr>
                    <td></td>
                    <td><input type="submit" value="เข้าสู่ระบบ" class="btn btn-outline-success" onclick="return checkScript(frm)"/></td>
                </tr>
                <tr>
                    <td></td>
                    <td><br><a href="${pageContext.request.contextPath}/register_member" class="link-primary" style="font-weight: bold;">สมัครสมาชิก</a></td>
                </tr>

                <tr>
                    <td></td>
                    <td>
                        <c:if test="${param.error != null}">ชื่อผู้ใช้หรือรหัสผ่านไม่ถูกต้อง</c:if>
                        <c:if test="${param.logout != null}">คุณออกจากระบบแล้ว</c:if>
                    </td>
                </tr>
            </table>
        </form>
    </div>
    <br><br><br>
</center>

<jsp:include page="/WEB-INF/view/layouts/footer.jsp"/>
</body>
</html>
