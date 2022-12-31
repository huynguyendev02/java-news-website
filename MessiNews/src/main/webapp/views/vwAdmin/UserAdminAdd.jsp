<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="m" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<m:main>
    <jsp:attribute name="css">
          <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-datetimepicker/2.5.20/jquery.datetimepicker.min.css" integrity="sha512-f0tzWhCwVFS3WeYaofoLWkTP62ObhewQ1EZn65oSYDZUg1+CyywGKkWzm8BxaJj5HGKI72PnMH9jYyIFz+GH7g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
          <style>
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
    </jsp:attribute>
    <jsp:attribute name="js">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-datetimepicker/2.5.20/jquery.datetimepicker.full.min.js" integrity="sha512-AIOTidJAcHBH2G/oZv9viEGXRqDNmfdPVPYOYKGy3fti0xIplnlgMHUGfuNRzC6FkzIo0iIxgFnr9RikFxK+sw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
        <script>
            function chooseRole(a, name){
                document.getElementById('form').action = a
                document.getElementById('btRole').innerText = name;
            }

            $('#form').on('submit', function (e) {
                e.preventDefault();
                const username = $('#username').val();
                const email = $('#email').val();
                $.getJSON('${pageContext.request.contextPath}/Account/IsAvailable?username='+username+'&email='+email, (data) => {
                    if (data==false) {
                        alert('Tên tài khoản hoặc email đã được sử dụng.')
                        return
                    } else {
                        $('#form').off('submit').submit();
                    }
                })
            })

            $('#txtDOB').datetimepicker({
                format: 'd/m/Y',
                timepicker: false,
                mask: true
            });
        </script>
    </jsp:attribute>
    <jsp:body>
        <form id="form" action="" method="post">
            <div class="d-flex justify-content-center bgColorGray">
                <!--    left-->
                <div class="bgColorGray" style="width: 15%">

                </div>

                <!--    center-->
                <div style="width: 70%; background-color: white" class="m-4 p-3">
                    <h4>Thêm tài khoản mới</h4>
                    <hr>
                    <h6 class="mt-3 pl-2">Thông tin tài khoản</h6>
                    <input id="username" name="username" type="text" placeholder="Tài khoản" class="w-100 pl-2 inputStyle mt-1" required>
                    <input name="rawpwd" id="pwd" type="password" placeholder="Mật khẩu" class="w-100 pl-2 inputStyle mt-3" required>

                    <div class="dropdown mt-3" >
                        <button id="btRole" class="btn inputStyle dropdown-toggle w-100 d-flex justify-content-between align-items-center " type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            Vai trò
                        </button>
                        <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                            <a class="dropdown-item"  onclick="chooseRole('${pageContext.request.contextPath}/Account/Register?role=1','Độc giả')"> Độc giả</a>
                            <a class="dropdown-item"  onclick="chooseRole('${pageContext.request.contextPath}/Account/Register?role=2','Phóng viên')">Phóng viên</a>
                            <a class="dropdown-item"  onclick="chooseRole('${pageContext.request.contextPath}/Account/Register?role=3','Biên tập')">Biên tập</a>
                            <a class="dropdown-item"  onclick="chooseRole('${pageContext.request.contextPath}/Account/Register?role=4','Quản lý')">Quản lý</a>
                        </div>
                    </div>

                    <h6 class="mt-4 pl-2">Thông tin cá nhân</h6>
                    <input name="fullName" type="text" placeholder="Họ và tên" class="w-100 pl-2 inputStyle mt-1" required>
                    <input id="email" name="email" type="email" placeholder="Email" class="w-100 pl-2 inputStyle mt-3" required>
                    <div class="d-flex justify-content-between align-items-center mt-3 pl-2">
                        <div>Ngày sinh</div>
                        <input name="dob" id="txtDOB" type="text" class=" inputStyle" required style="width: 80%">
                    </div>
                    <br>
                    <div id="save" align="end">
                        <a href="${pageContext.request.contextPath}/Admin/Users//List" class="btn btn-secondary mr-2">
                            <i class="fa fa-times" aria-hidden="true"></i>
                            Hủy bỏ
                        </a>
                        <button class="btn btn-success" type="submit">
                            <i class="fa fa-check" aria-hidden="true"></i>
                            Lưu lại
                        </button>
                    </div>
                </div>

                <!--    right-->
                <div style="width: 15%" class="d-flex align-items-end flex-column bgColorGray">
                    <div class="mt-auto p-2" style="position: fixed; bottom: 10px; right: 10px">
                        <a href="">
                            <i class="fa fa-arrow-circle-o-up fa-3x" aria-hidden="true"></i>
                        </a>
                    </div>
                </div>
            </div>
        </form>
    </jsp:body>
</m:main>
