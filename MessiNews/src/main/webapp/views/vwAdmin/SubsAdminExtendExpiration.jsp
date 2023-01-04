<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="m" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:useBean id="user" scope="request" type="com.messi.king.messinews.models.Users"/>

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
            $('#expireDate').datetimepicker({
                format: 'd/m/Y',
                timepicker: false,
                mask: true
            });
        </script>
  </jsp:attribute>
    <jsp:body>
        <div class="d-flex justify-content-center bgColorGray">
            <!--    left-->
            <div class="bgColorGray" style="width: 15%">

            </div>

            <!--    center-->
            <div style="width: 70%; background-color: white" class="my-4 p-3">
                <div class="d-flex justify-content-between">
                    <h3 id="title">Gia hạn cho người dùng</h3>
                </div>
                <hr>
                <div id="divEditProfile">
                    <form action="${pageContext.request.contextPath}/Admin/Users/Profile?id=${user.id}" method="post">
                        <table cellpadding="5px" class="w-100">
                            <tr>
                                <td style="width: 15%">
                                    Tài khoản:
                                </td>
                                <td>
                                   ${user.username}
                                </td>
                            </tr>
                            <tr>
                                <td>Hạn dùng:</td>
                                <td>
                                    ${user.expirationDate() <0 ? "Hết hạn sử dụng" : user.expirationDate() }
                                </td>
                            </tr>
                            <tr>
                                <td>Ngày gia hạn:</td>
                                <td>
                                    <input id="expireDate" name="expireDate" type="text" class="" style="border-style: solid; width: 15%; border-radius: 10px" required>
                                </td>
                            </tr>
                        </table>
                        <br>
                        <div id="save" align="end">
                            <a href="${pageContext.request.contextPath}/Admin/Users/ListSub"
                               class="btn btn-secondary mr-2">
                                <i class="fa fa-times" aria-hidden="true"></i>
                                Hủy bỏ
                            </a>
                            <button class="btn btn-success" type="submit" formaction="${pageContext.request.contextPath}/Admin/Users/ExtendExp?id=${user.id}">
                                <i class="fa fa-check" aria-hidden="true"></i>
                                Lưu lại
                            </button>
                        </div>
                    </form>
                </div>
            </div>
            <!--    right-->
            <div style="width: 15%" class="d-flex align-items-end flex-column bgColorGray">
            </div>
        </div>
    </jsp:body>
</m:main>
