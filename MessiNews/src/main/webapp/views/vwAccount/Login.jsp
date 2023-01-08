<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<jsp:useBean id="errorMessage" scope="request" type="java.lang.String"/>
<jsp:useBean id="googleLogin" scope="request" type="java.lang.String"/>
<jsp:useBean id="githubLogin" scope="request" type="java.lang.String"/>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Messi News | Login</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css"
          integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <style>
        body {
            scroll-behavior: auto;
        }

        div {
            border-radius: 10px;
        }

        img {
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

        .crop img {
            width: 100%;
            height: 100%;
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

        .imageIconInBT {
            width: 30px;
            height: 30px;
            border-radius: 30px
        }

    </style>
</head>
<body>
<form action="" method="post" class="d-flex justify-content-center w-100 h-100 bgColorGray">
    <div class="my-5 p-4" style="background-color: white; width: 30%">
        <div class="d-flex justify-content-between">
            <h4>
                Đăng nhập tài khoản
            </h4>
            <a href="${pageContext.request.contextPath}/Home">
                <i class="fa fa-times-circle-o fa-2x" aria-hidden="true"></i>
            </a>
        </div>
        <hr>

        <div class="d-flex justify-content-center">
            <img src="${pageContext.request.contextPath}/photos/logos/LogoMessi.png" alt="" style="width: 120px">
        </div>

        <input name="username" type="text" placeholder="Tài khoản" class="w-100 pl-2 inputStyle mt-4" required>
        <input name="password" type="password" placeholder="Mật khẩu" class="w-100 pl-2 inputStyle mt-3" required>

        <div class=" pt-1 pb-4" align="end">
            <a href="${pageContext.request.contextPath}/Account/Forgot" style="font-weight: normal; font-size: 15px">Quên mật khẩu</a>
        </div>

        <button class="w-100 inputStyle btn btn-primary" type="submit">Đăng nhập</button>

        <div class="d-flex justify-content-center align-items-center my-4">
            <div style="width: 40%">
                <hr>
            </div>
            <div class="mx-3">Hoặc</div>
            <div style="width: 40%">
                <hr>
            </div>
        </div>

        <a href="${googleLogin}" class="btn w-100 inputStyle" role="button" style="background-color: #f9f9fb; font-weight: bold">
            <img class="imageIconInBT mr-1" src="${pageContext.request.contextPath}/photos/logos/LogoGoogle.png"
                 alt="">
            Đăng nhập bằng Google
        </a>
        <a href="${githubLogin}" class="btn w-100 inputStyle mt-3" role="button"  style="background-color: #f9f9fb; font-weight: bold">
            <img class="imageIconInBT mr-1" src="${pageContext.request.contextPath}/photos/logos/LogoGitHub.png"
                 alt="">
            Đăng nhập bằng Github
        </a>
        <div align="center" class="mt-4">
            Chưa có tài khoản? <a href="${pageContext.request.contextPath}/Account/Register">Đăng ký</a>
        </div>
    </div>
    <c:if test="${errorMessage.length()!=0}">
        <script>
            alert("${errorMessage}");
        </script>
    </c:if>
</form>
<script src="https://code.jquery.com/jquery-3.6.1.min.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"
        integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN"
        crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.min.js"
        integrity="sha384-+sLIOodYLS7CIrQpBjl+C7nPvqq+FbNUBDunl/OZv93DB7Ln/533i8e/mZXLi/P+"
        crossorigin="anonymous"></script>
</body>
</html>
