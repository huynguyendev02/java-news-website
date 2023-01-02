<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="m" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:useBean id="authUser" scope="session" type="com.messi.king.messinews.models.Users"/>

<m:main>
    <jsp:attribute name="css">
          <link href="https://cdn.jsdelivr.net/gh/kartik-v/bootstrap-fileinput@5.2.5/css/fileinput.min.css" media="all"
                rel="stylesheet" type="text/css"/>
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
        <script src="https://cdn.jsdelivr.net/gh/kartik-v/bootstrap-fileinput@5.2.5/js/fileinput.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-fileinput/5.2.5/themes/fa/theme.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-fileinput/5.2.5/js/locales/vi.min.js"></script>

        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-datetimepicker/2.5.20/jquery.datetimepicker.full.min.js"
                integrity="sha512-AIOTidJAcHBH2G/oZv9viEGXRqDNmfdPVPYOYKGy3fti0xIplnlgMHUGfuNRzC6FkzIo0iIxgFnr9RikFxK+sw=="
                crossorigin="anonymous" referrerpolicy="no-referrer"></script>
        <script>

            function editClick() {
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
                document.getElementById('divEditProfile').style.display = 'block';
                document.getElementById('divUploadAvatar').style.display = 'none';
                document.getElementById('title').innerText = 'Chỉnh sửa thông tin';

            }

            function changeAvatar() {
                document.getElementById('divEditProfile').style.display = 'none';
                document.getElementById('divUploadAvatar').style.display = 'block';
                document.getElementById('title').innerText = 'Thay đổi ảnh đại diện';
            }

            function chooseRole(idRole, name) {
                document.getElementById('btRole').innerText = name;
                document.getElementById('role').value = idRole
            }

            $('.upAvatar').fileinput({
                theme: 'fa',
                language: 'vi',
                dropZoneEnabled: false,
                allowedFileExtensions: ['jpg', 'png']
            });


            window.onload = function () {
                let str = '${authUser.dob}';
                $('#newDob').datetimepicker({
                    value: new Date((str.split('T')[0].replaceAll('-', '/'))),
                    format: 'd/m/Y',
                    timepicker: false,
                    mask: true
                });
            }
        </script>
  </jsp:attribute>
    <jsp:body>

        <div class="w-100 bgColorPink" align="center">
            <div class="py-4">
                <img class="bigImageIcon mb-1"
                     src="${pageContext.request.contextPath}/photos/userAvatar/${authUser.id}/avatar.png"
                     alt="">
                <h2>${authUser.username}</h2>
                <p>
                    Vai trò:
                    <c:choose>
                        <c:when test="${authUser.role == 1}">
                            Độc giả
                        </c:when>

                        <c:when test="${authUser.role == 2}">
                            Phóng viên
                        </c:when>

                        <c:when test="${authUser.role == 3}">
                            Nhà báo
                        </c:when>

                        <c:when test="${authUser.role == 4}">
                            Quản trị viên
                        </c:when>
                    </c:choose>
                </p>
            </div>
        </div>
        <div class="d-flex justify-content-center bgColorGray">
            <!--    left-->
            <div class="bgColorGray" style="width: 15%">

            </div>

            <!--    center-->
            <div style="width: 70%; background-color: white" class="mt-4 p-3">
                <div class="d-flex justify-content-between">
                    <h3 id="title">Thông tin cá nhân</h3>
                    <div>
                        <button onclick="changeAvatar()" class="px-3 btn btn-outline-info"
                                style="border-radius: 20px" type="button">
                            <i class="fa fa-picture-o" aria-hidden="true"></i>
                            Đổi Avatar
                        </button>
                        <button onclick="editClick()" class="px-3 btn btn-outline-primary"
                                style="border-radius: 20px" type="button">
                            <i class="fa fa-pencil" aria-hidden="true"></i>
                            Chỉnh sửa thông tin
                        </button>
                    </div>
                </div>
                <hr>
                <div id="divEditProfile">
                    <form action="${pageContext.request.contextPath}/Account/Profile" method="post">
                        <table cellpadding="5px" class="w-100">
                            <tr>
                                <td style="width: 10%">Họ vàn tên:</td>
                                <td>
                                    <input id="newFullName" name="newFullName" type="text"
                                           value="${authUser.full_name}"
                                           class="w-100 pl-2 inputOff" readonly="readonly" required>
                                </td>
                            </tr>
                            <tr>
                                <td>Email:</td>
                                <td>
                                    <input id="newEmail" name="newEmail" type="email" value="${authUser.email}"
                                           class="w-100 pl-2 inputOff" readonly="readonly" required>
                                </td>
                            </tr>
                            <tr>
                                <td>Vai trò:</td>
                                <td>
                                    <div class="dropdown">
                                        <button id="btRole"
                                                class="btn inputOff dropdown-toggle w-100 d-flex justify-content-between align-items-center "
                                                type="button" data-toggle="dropdown" aria-haspopup="true"
                                                aria-expanded="false"
                                                disabled>
                                            <c:choose>
                                                <c:when test="${authUser.role == 1}">
                                                    Độc giả
                                                </c:when>

                                                <c:when test="${authUser.role == 2}">
                                                    Phóng viên
                                                </c:when>

                                                <c:when test="${authUser.role == 3}">
                                                    Nhà báo
                                                </c:when>

                                                <c:when test="${authUser.role == 4}">
                                                    Quản trị viên
                                                </c:when>
                                            </c:choose>
                                        </button>
                                        <input name="role" type="text" value="${authUser.role}" style="display: none">
                                        <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                                            <a class="dropdown-item"
                                               onclick="chooseRole('1','Phóng viên')">
                                                Độc giả</a>
                                            <a class="dropdown-item"
                                               onclick="chooseRole('2','Phóng viên')">Phóng
                                                viên</a>
                                            <a class="dropdown-item"
                                               onclick="chooseRole('3','Biên tập')">Biên
                                                tập</a>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>Ngày sinh:</td>
                                <td>
                                    <input id="newDob" name="newDob" type="text" class="pl-2 inputOff w-100" required>
                                </td>
                            </tr>
                        </table>
                        <br>
                        <div id="save" align="end" style="display: none">
                            <a href="${pageContext.request.contextPath}/Account/Profile"
                               class="btn btn-secondary mr-2">
                                <i class="fa fa-times" aria-hidden="true"></i>
                                Hủy bỏ
                            </a>
                            <button class="btn btn-success" type="submit">
                                <i class="fa fa-check" aria-hidden="true"></i>
                                Lưu lại
                            </button>
                        </div>
                    </form>
                </div>

                    <%--                    Thay avatar--%>
                <div id="divUploadAvatar" style="display: none">
                    <br>
                    <form action="${pageContext.request.contextPath}/Account/ChangeAvatar" method="post"
                          enctype="multipart/form-data">
                        <input id="input-b2" name="avatar" type="file"
                               value="${pageContext.request.contextPath}/photos/userAvatar/${authUser.id}/avatar.png"
                               class="upAvatar" data-show-preview="false" required>
                    </form>
                    <br>
                    <div align="right">
                        <a href="${pageContext.request.contextPath}/Account/Profile" class="btn btn-secondary">
                            <i class="fa fa-times" aria-hidden="true"></i>
                            Hủy bỏ
                        </a>
                    </div>
                    <br>
                    <br>
                </div>
            </div>
            <!--    right-->
            <div style="width: 15%" class="d-flex align-items-end flex-column bgColorGray">
            </div>
        </div>
    </jsp:body>
</m:main>
