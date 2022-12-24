<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>404</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <style>
        body {
            height: 100vh;
            background-image: url(${pageContext.request.contextPath}/photos/background/BackgroundError.jpeg);
            background-repeat: no-repeat;
            background-size: cover;
        }
    </style>
</head>
<body>

<div class="container-fluid h-100">
    <div class="row h-100 align-items-center">
        <div class="col-sm-12">
            <div class="card shadow w-50 mx-auto">
                <div class="card-body">
                    <h1 class="text-danger">Lỗi: 204!</h1>
                    <h3 class="card-title">Không xong rồi Đại Vương ơi!</h3>
                    <p class="card-text">
                        Không có nội dung hiển thị
                    </p>
                    <div>
                        <a class="btn btn-success" href="${pageContext.request.contextPath}/Home" role="button">
                            <i class="fa fa-backward" aria-hidden="true"></i>
                            Trang chủ
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.6.1.min.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.min.js" integrity="sha384-+sLIOodYLS7CIrQpBjl+C7nPvqq+FbNUBDunl/OZv93DB7Ln/533i8e/mZXLi/P+" crossorigin="anonymous"></script>
</body>
</html>