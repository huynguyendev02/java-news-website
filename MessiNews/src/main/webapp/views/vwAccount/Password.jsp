<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="m" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:useBean id="authUser" scope="session" type="com.messi.king.messinews.models.Users"/>

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

              input {
                  border-style: solid;
                  height: 40px;
                  border-radius: 10px;
                  border-color: #F0F0F0;
              }

              input:focus {
                  outline: #F0F0F0;
              }
          </style>
      </jsp:attribute>
    <jsp:attribute name="js">
        <script>
        </script>
    </jsp:attribute>
    <jsp:body>
        <form action="" method="post">
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
                        <h3>Thay đổi mật khẩu</h3>
                    </div>
                    <hr>
                    <input id="oldPassword" name="oldPassword" type="password" placeholder="Mật khẩu cũ"
                           class="w-100 pl-2  mt-1">
                    <input id="newPassword" name="newPassword" type="password" placeholder="Mật khẩu mới"
                           class="w-100 pl-2  mt-3">
                    <input id="ConfirmNewPassword" name="ConfirmNewPassword" type="password"
                           placeholder="Xác nhận mật khẩu mới"
                           class="w-100 pl-2  mt-3">
                    <br> <br>
                    <div id="save" align="end">
                        <a href="${pageContext.request.contextPath}/Home" class="btn btn-secondary mr-2">
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
