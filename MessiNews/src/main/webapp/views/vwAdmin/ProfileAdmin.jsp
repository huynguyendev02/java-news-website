<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="m" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:useBean id="user" scope="request" type="com.messi.king.messinews.models.Users"/>

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

            function editClick(strTime) {
                $('#newDob').datetimepicker({
                    value: new Date((strTime.split('T')[0].replaceAll('-', '/')))
                });
                document.getElementById("newFullName").classList.add('inputOn');
                document.getElementById("newFullName").classList.remove('inputOff');
                document.getElementById('newFullName').readOnly = false;

                document.getElementById("newEmail").classList.add('inputOn');
                document.getElementById("newEmail").classList.remove('inputOff');
                document.getElementById('newEmail').readOnly = false;

                document.getElementById("newDob").classList.add('inputOn');
                document.getElementById("newDob").classList.remove('inputOff');
                document.getElementById('newDob').readOnly = false;

                document.getElementById('save').style.display = 'block';
            }

            $('#newDob').datetimepicker({
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
                    <div class="d-flex justify-content-between">
                        <h3>Thông tin cá nhân</h3>
                        <button onclick="editClick('${user.dob}')" class="px-3 btn btn-outline-primary"
                                style="border-radius: 20px" type="button">
                            <i class="fa fa-pencil" aria-hidden="true"></i>
                            Chỉnh sửa thông tin
                        </button>
                    </div>
                    <hr>
                    <table cellpadding="5px" class="w-100">
                        <tr>
                            <td style="width: 10%">Họ vàn tên:</td>
                            <td>
                                <input id="newFullName" name="newFullName" type="text" value="${user.full_name}"
                                       class="w-100 pl-2 inputOff" readonly="readonly">
                            </td>
                        </tr>
                        <tr>
                            <td>Email:</td>
                            <td>
                                <input id="newEmail" name="newEmail" type="email" value="${user.email}"
                                       class="w-100 pl-2 inputOff" readonly="readonly">
                            </td>
                        </tr>
                        <tr>
                            <td>Ngày sinh:</td>
                            <td><input id="newDob" name="newDob" type="text" class="inputOff w-100"></td>
                        </tr>
                    </table>
                    <br>
                    <div id="save" align="end" style="display: none">
                        <a href="${pageContext.request.contextPath}/Admin/Users/Profile?id=${user.id}" class="btn btn-secondary mr-2">
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
