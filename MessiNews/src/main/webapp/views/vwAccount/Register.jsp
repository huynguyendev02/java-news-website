<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
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

        .form-control:focus {
            border-color: transparent;
            -webkit-box-shadow: none;
            box-shadow: none;
        }

        .crop {
            width: 1060px;
            height: 300px;
        }

        .crop img {
            width: 100%;
            height: 100%;
        }

        .grad {
            background-image: linear-gradient(to top right, black 5%, transparent);
        }

        .bgColorGray {
            background-color: #F0F0F0;
        }

        .imageIcon {
            width: 40px;
            height: 40px;
            border-radius: 40px
        }

        .boxShadow {
            border: 1px solid;
            border-left: none;
            box-shadow: 0.5px 0.5px;
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

        .imageIconInBT
        {
            width: 30px;
            height: 30px;
            border-radius: 30px
        }

    </style>
</head>
<body>
<form id="form" action="" method="post" class="d-flex justify-content-center w-100 h-100 bgColorGray">
    <div class="mt-5 p-4" style="background-color: white; width: 30%">
        <div class="d-flex justify-content-between">
            <h4>
                <a href="" class="mr-2">
                    <a href="${pageContext.request.contextPath}/Account/Login">
                        <i class="fa fa-caret-left" aria-hidden="true"></i>
                    </a>
                </a>
                Đăng ký tài khoản
            </h4>
            <a href="${pageContext.request.contextPath}/Home">
                <i class="fa fa-times-circle-o fa-2x" aria-hidden="true"></i>
            </a>
        </div>
        <hr>

        <div class="d-flex justify-content-center">
            <img src="${pageContext.request.contextPath}/photos/logos/LogoMessi.png" alt="" style="width: 120px">
        </div>

        <h6 class="mt-3 pl-2">Thông tin tài khoản</h6>
        <input name="username" type="text" placeholder="Tài khoản" class="w-100 pl-2 inputStyle mt-1" required>
        <input name="rawpwd" id="pwd" type="password" placeholder="Mật khẩu" class="w-100 pl-2 inputStyle mt-3" required>
        <input id="confirmPwd" type="password" placeholder="Xác nhận mật khẩu" class="w-100 pl-2 inputStyle mt-3" required>

        <div class="dropdown mt-3" >
            <button id="btRole" class="btn inputStyle dropdown-toggle w-100 d-flex justify-content-between align-items-center " type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                Vai trò
            </button>
            <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                <a class="dropdown-item"  onclick="chooseRole('${pageContext.request.contextPath}/Account/Register?role=1','Phóng viên')"> Độc giả</a>
                <a class="dropdown-item"  onclick="chooseRole('${pageContext.request.contextPath}/Account/Register?role=2','Phóng viên')">Phóng viên</a>
                <a class="dropdown-item"  onclick="chooseRole('${pageContext.request.contextPath}/Account/Register?role=3','Biên tập')">Biên tập</a>
                <a class="dropdown-item"  onclick="chooseRole('${pageContext.request.contextPath}/Account/Register?role=4', 'Quản trị')">Quản trị</a>
            </div>
        </div>

        <h6 class="mt-4 pl-2">Thông tin cá nhân</h6>
        <input name="fullName" type="text" placeholder="Họ và tên" class="w-100 pl-2 inputStyle mt-1" required>
        <input name="email" type="password" placeholder="Email" class="w-100 pl-2 inputStyle mt-3" required>
        <input name="dob" type="text" placeholder="Ngày sinh: dd/MM/yyyy" class="w-100 pl-2 inputStyle mt-3" required>

        <button id="btRegister" type="submit" class="w-100 inputStyle btn btn-primary mt-3">Đăng ký</button>
    </div>
</form>

<script src="https://code.jquery.com/jquery-3.6.1.min.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"
        integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN"
        crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.min.js"
        integrity="sha384-+sLIOodYLS7CIrQpBjl+C7nPvqq+FbNUBDunl/OZv93DB7Ln/533i8e/mZXLi/P+"
        crossorigin="anonymous"></script>
</body>
<script>
    let urlRole
    function chooseRole(a, name){
        document.getElementById('form').action = a
        document.getElementById('btRole').innerText = name;
    }

    document.getElementById('btRegister').onclick = function (event){
        if (document.getElementById('pwd').value != document.getElementById('confirmPwd').value){
            alert('Xác nhận mật khẩu chưa chính xác')
            event.preventDefault()
            return;
        }
    }
</script>
</html>
