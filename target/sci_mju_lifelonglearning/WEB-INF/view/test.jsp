<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %><%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 8/28/2023
  Time: 9:00 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Upload Image</title>
    <style>
        #editor {
            width: 100%;
            height: 500px;
            border: 1px solid #ccc;
            padding: 10px;
            font-size: 16px;
        }
        .toolbar {
            background-color: #f2f2f2;
            padding: 5px;
        }
        .toolbar button {
            margin: 5px;
            padding: 3px 10px;
            font-size: 14px;
        }
    </style>
</head>
<body>
<div class="toolbar">
    <button onclick="boldText()">Bold</button>
    <button onclick="italicText()">Italic</button>
    <button onclick="underlineText()">Underline</button>
</div>
<div id="editor" contenteditable="true">
    <!-- เริ่มเพิ่มเนื้อหาของ Text Editor ที่นี่ -->
</div>
<!-- เพิ่มปุ่มหรือเมนูเพื่อควบคุม Text Editor ตามต้องการ -->
<script>
    function boldText() {
        document.execCommand('bold', false, null);
    }

    function italicText() {
        document.execCommand('italic', false, null);
    }

    function underlineText() {
        document.execCommand('underline', false, null);
    }
</script>
</body>

</html>

