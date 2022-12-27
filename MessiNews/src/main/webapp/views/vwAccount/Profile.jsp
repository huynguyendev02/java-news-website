<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="m" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<m:main>
    <jsp:attribute name="css">
          <link rel="stylesheet"
                href="https://cdnjs.cloudflare.com/ajax/libs/jquery-datetimepicker/2.5.20/jquery.datetimepicker.min.css"
                integrity="sha512-f0tzWhCwVFS3WeYaofoLWkTP62ObhewQ1EZn65oSYDZUg1+CyywGKkWzm8BxaJj5HGKI72PnMH9jYyIFz+GH7g=="
                crossorigin="anonymous" referrerpolicy="no-referrer"/>
          <style>
              .bgColorPink {
                  background-image: linear-gradient(to right, pink, antiquewhite, pink);
              }

              .bigImageIcon {
                  width: 120px;
                  height: 120px;
                  border-radius: 120px
              }

              .inputOff {
                  border-style: none;
                  height: 40px;
                  border-radius: 10px;
              }

              .inputOff:focus {
                  border-style: none;
                  outline: none;
              }

              .inputOn {
                  border-style: solid;
                  height: 40px;
                  border-radius: 10px;
                  border-color: darkgrey;
              }

              .inputOn:focus {
                  outline: darkgrey;
              }
          </style>
      </jsp:attribute>
    <jsp:attribute name="js">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-datetimepicker/2.5.20/jquery.datetimepicker.full.min.js"
                integrity="sha512-AIOTidJAcHBH2G/oZv9viEGXRqDNmfdPVPYOYKGy3fti0xIplnlgMHUGfuNRzC6FkzIo0iIxgFnr9RikFxK+sw=="
                crossorigin="anonymous" referrerpolicy="no-referrer"></script>
        <script>
            document.getElementById('editProfile').onclick = function () {

                document.getElementById("newFullName").classList.add('inputOn');
                document.getElementById("newFullName").classList.remove('inputOff');
                document.getElementById('newFullName').readOnly = false;

                document.getElementById("newEmail").classList.add('inputOn');
                document.getElementById("newEmail").classList.remove('inputOff');
                document.getElementById('newEmail').readOnly = false;

                document.getElementById("newDob").classList.add('inputOn');
                document.getElementById("newDob").classList.remove('inputOff');
                document.getElementById('newDob').readOnly = false;

                document.getElementById('btRole').disabled = false;
                document.getElementById("btRole").classList.add('inputOn');
                document.getElementById("btRole").classList.remove('inputOff');

                document.getElementById('save').style.display = 'block';
                document.getElementById('editProfile').style.visibility = 'hidden';
            }

            function chooseRole(a, name) {
                document.getElementById('btRole').innerText = name;
                document.getElementById('form').action = a
            }

            $('#newDob').datetimepicker({
                format: 'd/m/Y',
                timepicker: false,
                mask: true
            });
        </script>
  </jsp:attribute>
    <jsp:body>
        <form action="" method="post">
            <div class="w-100 bgColorPink" align="center">
                <div class="py-4">
                    <img class="bigImageIcon mb-1"
                         src="${pageContext.request.contextPath}/photos/articles/29/a.png"
                         alt="">
                    <h2>Dương Quá</h2>
                    <p>Vai trò: Nhà báo</p>
                </div>
            </div>
            <div class="d-flex justify-content-center bgColorGray">
                <!--    left-->
                <div class="bgColorGray" style="width: 15%">

                </div>

                <!--    center-->
                <div style="width: 70%; background-color: white" class="mt-4 p-3">
                    <div class="d-flex justify-content-between">
                        <h3>Thông tin cá nhân</h3>
                        <button id="editProfile" class="px-3 btn btn-outline-primary" style="border-radius: 20px" type="button">
                            <i class="fa fa-pencil" aria-hidden="true"></i>
                            Chỉnh sửa thông tin
                        </button>
                    </div>
                    <hr>
                    <input id="newFullName" name="newFullName" type="text" placeholder="Họ và tên"
                           class="w-100 pl-2 inputOff mt-1" readonly="readonly">
                    <input id="newEmail" name="newEmail" type="text" placeholder="Email"
                           class="w-100 pl-2 inputOff mt-3" readonly="readonly">
                    <div class="dropdown mt-3">
                        <button id="btRole"
                                class="btn inputOff dropdown-toggle w-100 d-flex justify-content-between align-items-center "
                                type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"
                                disabled>
                            Vai trò
                        </button>
                        <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                            <a class="dropdown-item"
                               onclick="chooseRole('${pageContext.request.contextPath}/Account/Register?role=1','Phóng viên')">
                                Độc giả</a>
                            <a class="dropdown-item"
                               onclick="chooseRole('${pageContext.request.contextPath}/Account/Register?role=2','Phóng viên')">Phóng
                                viên</a>
                            <a class="dropdown-item"
                               onclick="chooseRole('${pageContext.request.contextPath}/Account/Register?role=3','Biên tập')">Biên
                                tập</a>
                            <a class="dropdown-item"
                               onclick="chooseRole('${pageContext.request.contextPath}/Account/Register?role=4', 'Quản trị')">Quản
                                trị</a>
                        </div>
                    </div>
                    <div class="d-flex justify-content-between align-items-center mt-3 pl-2">
                        <div>Ngày sinh</div>
                        <input id="newDob" name="newDob" type="text" class="inputOff" required style="width: 80%"
                               readonly="readonly">
                    </div>
                    <br>
                    <div id="save" align="end" style="display: none">
                        <a href="${pageContext.request.contextPath}/Account/Profile" class="btn btn-secondary mr-2">
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
                </div>
            </div>
        </form>
    </jsp:body>
</m:main>
