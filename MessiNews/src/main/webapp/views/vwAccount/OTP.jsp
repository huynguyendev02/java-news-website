<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="errorOTP" scope="request" type="java.lang.String"/>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Messi News | OTP</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css"
          integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/jquery-datetimepicker/2.5.20/jquery.datetimepicker.min.css"
          integrity="sha512-f0tzWhCwVFS3WeYaofoLWkTP62ObhewQ1EZn65oSYDZUg1+CyywGKkWzm8BxaJj5HGKI72PnMH9jYyIFz+GH7g=="
          crossorigin="anonymous" referrerpolicy="no-referrer"/>

    <style>
        body {
            height: 100vh;
        }

        div {
            border-radius: 10px;
        }

        a {
            text-decoration: none;
            color: black;
            font-weight: bold;

        }

        a:hover {
            text-decoration: none;
            color: cornflowerblue;
            font-weight: bold;

        }

        .bgColorGray {
            background-color: #F0F0F0;
        }

        .inputStyle {
            border-style: solid;
            height: 40px;
            border-radius: 10px;
            border-color: #F0F0F0;
        }

        .inputStyle:focus {
            outline: #F0F0F0;
        }
    </style>
</head>
<body>
<form id="form" action="" method="post"
      class="d-flex justify-content-center w-100 h-100 bgColorGray align-items-center">
    <div id="divBackGround" class="p-4" style="background-color: white; width: 30%; height: 70%">
        <div class="d-flex justify-content-between">
            <h4>
                Xác thực mật khẩu
            </h4>
            <a href="${pageContext.request.contextPath}/Account/Login">
                <i class="fa fa-times-circle-o fa-2x" aria-hidden="true"></i>
            </a>
        </div>
        <hr>

        <div class="d-flex justify-content-center">
            <img src="${pageContext.request.contextPath}/photos/logos/LogoMessi.png" alt="" style="width: 120px">
        </div>

        <input  id="otp" name="otp" type="text" placeholder="Vui lòng nhập mã OTP" class="w-100 pl-2 inputStyle my-4"
               required>

<%--        <button id="btXacNhan" class="w-100 inputStyle btn btn-primary " type="button" onclick="xacNhanClick()">Tiếp tục</button>--%>

        <div id="resetPass" style="display: block">
            <h6>Tạo mật khẩu mới</h6>
            <input name="rawpwd" id="pwd" type="password" placeholder="Mật khẩu" class="w-100 pl-2 inputStyle" required>
            <input id="confirmPwd" type="password" placeholder="Xác nhận mật khẩu" class="w-100 pl-2 inputStyle mt-3"
                   required>
            <button class="w-100 inputStyle btn btn-primary mt-4" type="submit">Hoàn thành</button>
        </div>

    </div>
</form>
<c:if test="${errorOTP.length()!=0}">
    <script>
        alert("${errorOTP}");
    </script>
</c:if>

<script src="https://code.jquery.com/jquery-3.6.1.min.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"
        integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN"
        crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.min.js"
        integrity="sha384-+sLIOodYLS7CIrQpBjl+C7nPvqq+FbNUBDunl/OZv93DB7Ln/533i8e/mZXLi/P+"
        crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-datetimepicker/2.5.20/jquery.datetimepicker.full.min.js"
        integrity="sha512-AIOTidJAcHBH2G/oZv9viEGXRqDNmfdPVPYOYKGy3fti0xIplnlgMHUGfuNRzC6FkzIo0iIxgFnr9RikFxK+sw=="
        crossorigin="anonymous" referrerpolicy="no-referrer"></script>
</body>
<script>
    <%--function xacNhanClick(){--%>
    <%--    let value = $('#otp').val();--%>
    <%--    if (value == ${code}) {--%>
    <%--        $('#btXacNhan').css('display','none');--%>
    <%--        $('#resetPass').css('display','block');--%>
    <%--        $('#divBackGround').css('height','70%');--%>
    <%--    }--%>
    <%--    else {--%>
    <%--        alert("Mã OTP không đúng, vui lòng thử lại")--%>
    <%--    }--%>

    <%--}--%>

    $('#form').on('submit', function (e) {
        e.preventDefault();
        let pwd = document.getElementById('pwd').value;

        if (/^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z]{8,}$/.test(pwd)==false){
            alert('Mật khẩu phải có tối thiểu 8 kí tự, gồm ít nhất 1 số, 1 chữ thường, 1 chữ in hoa')
            return
        }
        if (document.getElementById('pwd').value != document.getElementById('confirmPwd').value){
            alert('Xác nhận mật khẩu chưa chính xác')
            return
        }
        $('#form').off('submit').submit();

    })
</script>
</html>