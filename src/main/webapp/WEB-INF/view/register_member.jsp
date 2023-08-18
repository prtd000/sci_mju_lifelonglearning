<%--
  Created by IntelliJ IDEA.
  User: asus
  Date: 25/7/2566
  Time: 15:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
  <title>Register</title>
  <jsp:include page="/WEB-INF/view/layouts/detail-all-style.jsp"/>
</head>
<style>
  /**********Register First Step**********/
  .block_form1 {
    padding: 30px;
    width: 680px;
    border-radius: 25px;
    box-shadow: 2px 2px 5px 1px #626262;
  }

  .regis_block_step1 {
    margin-left: 427px;
    margin-top: 52px;
  }

  .inp_idcard {
    width: 100%;
  }

  .btn_nextstep1 {
    width: 114px;
    height: 41px;
    border-radius: 14px;
    border: 1px solid;
    background-color: #ff7100;
    color: white;
    float: right;
    transition: 0.5s;
  }

  .btn_nextstep1:hover {
    background-color: #c5c5c5;
    color: rgb(0, 0, 0);
    transition: 0.5s;
  }

  div[class='regis_block_step1'] form table tr {
    height: 50px;
  }

  div[class='regis_block_step1'] form table tr td {
    font-weight: bold;
    font-size: 20px;
    color: black;
  }

  div[class='regis_block_step1'] form table tr td input {
    border-radius: 8px;
    border: 1px solid;
    height: 36px;
    padding: 10px;
  }

  /**********Register Second Step**********/

  .regis_block_step2 {
    margin-left: 427px;
    margin-top: 52px;
  }

  .block_form2 {
    padding: 30px;
    width: 680px;
    border-radius: 25px;
    box-shadow: 2px 2px 5px 1px #626262;
  }

  div[class='regis_block_step2'] form table tr td input {
    border-radius: 8px;
    border: 1px solid;
    height: 36px;
    padding: 10px;
  }

  div[class='regis_block_step2'] form table tr {
    height: 50px;
  }

  div[class='regis_block_step2'] form table tr td {
    font-weight: bold;
    font-size: 20px;
    color: black;
  }

  div[class='regis_block_step2'] form table tr td input[type='text'] {
    border-radius: 8px;
    border: 1px solid;
    height: 36px;
    padding: 10px;
    width: 100%;
  }

  div[class='regis_block_step2'] form table tr td input[type='radio'] {
    width: 26px;
    margin-left: 68px;
    cursor: pointer;
  }

  .label_radio {
    position: absolute;
    margin-top: 5px;
    margin-left: 12px;
  }

  .hidden-form {
    display: none;
  }
</style>
<body>

<jsp:include page="/WEB-INF/view/layouts/nav.jsp"/>


<div align="center">
  <h1>${title}</h1>
  <div class="list_course_detail" align="center">
    <div class="hr_line"></div>
    <button id="FClick" class="tablinks" onclick="openList(event, 'form1')">Step 1</button>
    <button class="tablinks" onclick="openList(event, 'form2')">Step 2</button>
    <button class="tablinks" onclick="openList(event, 'form3')">Step 3</button>
  </div>
  <form action="${pageContext.request.contextPath}/register_member/save" method="POST">
    <!-- Form 1 -->
    <div id="form1" class="block_form1 tabcontent">
      <table>
        <tr>
          <td>บัตรประชาชน</td>
          <td></td>
        </tr>
        <tr>
          <td colspan="3"><input name="idcard" id="idcard" type="text" class="inp_idcard"/></td>
        </tr>
        <tr>
          <td>ชื่อ</td>
          <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
          <td>นามสกุล</td>
        </tr>
        <tr>
          <td><input name="firstName" id="firstName" type="text" name="firstname"/></td>
          <td></td>
          <td><input name="lastName" id="lastName" type="text" name="lastname"/></td>
        </tr>
      </table>
    </div>

    <!-- Form 2 -->
    <div id="form2" class="block_form2 tabcontent">
      <table style="width: 100%;">
        <tr>
          <td>วันเดือนปีเกิด</td>
          <td></td>
        </tr>
        <tr>
          <td colspan="2"><input name="birthday" id="birthday" type="date" style="width: 50%;"/></td>

        </tr>
        <tr>
          <td>
            <input type="radio" name="gender"  value="Male">
            <label>ชาย</label>
            <input type="radio" name="gender" value="Female">
            <label>หญิง</label>
          </td>
        </tr>
        <tr>
          <td>เบอร์โทร</td>
        </tr>
        <tr>
          <td colspan="2"><input name="tel" id="tel" type="text" name="tel"/></td>
        </tr>
        <tr>
          <td>อีเมล</td>
        </tr>
        <tr>
          <td colspan="3"><input name="email" id="email" type="text" name="email"/></td>
        </tr>
        <tr>
          <td>การศึกษา</td>
        </tr>
        <tr>
          <td colspan="3">
            <select id="education" name="education">
              <option value="ระดับมัธยมศึกษา">ระดับมัธยมศึกษา</option>
              <option value="ระดับอาชีวศึกษา">ระดับอาชีวศึกษา</option>
              <option value="ระดับอุดมศึกษา">ระดับอุดมศึกษา</option>
              <option value="ปริญญาตรี">ปริญญาตรี</option>
              <option value="ปริญญาโท">ปริญญาโท</option>
              <option value="ปริญญาเอก">ปริญญาเอก</option>
            </select>
          </td>
        </tr>
      </table>
    </div>

    <!-- Form 3 -->
    <div id="form3" class="block_form2 tabcontent">
      <table style="width: 100%;">
        <tr>
          <td>ชื่อ</td>
        </tr>
        <tr>
          <td><input name="username" id="username" type="text" placeholder="Username"/></td>
        </tr>
        <tr>
          <td>นามสกุล</td>
        </tr>
        <tr>
          <td><input name="password" id="password" type="password" placeholder="Password"/></td>
        </tr>
        <tr>
          <td>
            <input type="submit" value="สมัครสมาชิก">
          </td>
        </tr>
      </table>
    </div>
  </form>
</div>


<jsp:include page="/WEB-INF/view/layouts/footer.jsp"/>
</body>
<script>
  window.addEventListener('DOMContentLoaded', (event) => {
    var button = document.getElementById('FClick');
    button.click()
  });
  function openList(evt, list_name) {
    var i, tabcontent, tablinks;
    tabcontent = document.getElementsByClassName("tabcontent");
    for (i = 0; i < tabcontent.length; i++) {
      tabcontent[i].style.display = "none";
    }
    tablinks = document.getElementsByClassName("tablinks");
    for (i = 0; i < tablinks.length; i++) {
      tablinks[i].className = tablinks[i].className.replace(" active", "");
    }
    document.getElementById(list_name).style.display = "block";
    evt.currentTarget.className += " active";
  }
</script>
</html>
