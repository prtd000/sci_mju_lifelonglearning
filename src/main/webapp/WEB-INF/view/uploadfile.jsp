<%--
  Created by IntelliJ IDEA.
  User: asus
  Date: 20/10/2023
  Time: 11:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<form action="${pageContext.request.contextPath}/member/upload_file/save"
      method="post" name="frm" onsubmit="return confirm('ยืนยันข้อมูลการชำระเงิน')" enctype="multipart/form-data">

    <input type="text" placeholder="file name" name="name">
    <input type="file" id="fileInput" accept="image/*" name="slip" class="file-input"
           onchange="previewImage(this)">

</form>
</body>
</html>
