<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<html>
<head>
    <title>${title}</title>


    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <jsp:include page="/WEB-INF/view/layouts/detail-all-style.jsp"/>
</head>
<body>

<!-- Navbar -->
<jsp:include page="/WEB-INF/view/layouts/check_nav.jsp"/>

<center>
    <br><br><br><br>
    <h1 style="font-size: 28px;">${title}</h1>
    <br>
    <div class="log-div">
        <form:form action="${pageContext.request.contextPath}/doLoginMember" method="POST">
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
                    <td><input type="submit" value="เข้าสู่ระบบ" class="btn btn-outline-success"/></td>
                </tr>
                <tr>
                    <td></td>
                    <td><br><a href="${pageContext.request.contextPath}/register_member" class="link-primary">สมัครสมาชิก</a></td>
                </tr>

                <tr>
                    <td></td>
                    <td>
                        <c:if test="${param.error != null}">ชื่อผู้ใช้หรือรหัสผ่านไม่ถูกต้อง</c:if>
                        <c:if test="${param.logout != null}">คุณออกจากระบบแล้ว</c:if>
                    </td>
                </tr>
            </table>
        </form:form>
    </div>
    <br><br><br>
</center>

<jsp:include page="/WEB-INF/view/layouts/footer.jsp"/>
</body>
</html>
