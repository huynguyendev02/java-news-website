<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="m" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:useBean id="articlesList" scope="request" type="java.util.List<com.messi.king.messinews.models.Articles>"/>
<jsp:useBean id="allPCategories" scope="request" type="java.util.List<com.messi.king.messinews.models.ParentCategories>"/>
<jsp:useBean id="allCategories" scope="request" type="java.util.List<com.messi.king.messinews.models.Categories>"/>

<m:main>
     <jsp:attribute name="css">
          <link rel="stylesheet"
                href="https://cdnjs.cloudflare.com/ajax/libs/jquery-datetimepicker/2.5.20/jquery.datetimepicker.min.css"
                integrity="sha512-f0tzWhCwVFS3WeYaofoLWkTP62ObhewQ1EZn65oSYDZUg1+CyywGKkWzm8BxaJj5HGKI72PnMH9jYyIFz+GH7g=="
                crossorigin="anonymous" referrerpolicy="no-referrer"/>

          <style>
              .Shadown {
                  border-style: solid;
                  border-right: none;
              }

              .aDelete {
                  color: red;
              }

              .aDelete:hover {
                  color: red;
                  font-weight: bold;
              }

              .aEdit {
                  color: forestgreen;
              }

              .aEdit:hover {
                  color: forestgreen;
                  font-weight: bold;
              }

              .btStyle {
                  width: 350px;
                  border-radius: 5px;
              }
              .inputStyle {
                  border-style: solid;
                  height: 40px;
                  border-radius: 10px;
                  border-color: #F0F0F0;
              }

          </style>
    </jsp:attribute>

    <jsp:body>
        <form action="" method="post">
            <div class="d-flex justify-content-center bgColorGray">
                <!--    left-->
                <div class="bgColorGray" style="width: 15%">

                </div>

                <!--    center-->
                <div style="width: 70%; background-color: white" class="m-4 p-3">
                    <h4>Những bài viết chưa được xử lý</h4>
                    <hr>
                    <br>
                    <div id="danhSach">
                        <table class="w-100" cellpadding="5px">
                            <tr style="background-color: #EEEEEE">
                                <td>Tiêu đề</td>
                                <td align="center">Tác giả</td>
                                <td align="center">Duyệt</td>
                                <td align="center">Từ chối</td>
                            </tr>
                            <c:forEach items="${articlesList}" var="c">
                                <tr>
                                    <td>${c.title}</td>
                                    <td align="center">
                                            ${c.writer_id}
                                    </td>
                                    <td align="center">
                                        <a type="button" href="${pageContext.request.contextPath}/Editor/Accept?id=${c.id}"
                                                class="btn btn-success">Duyệt
                                        </a>
                                    </td>
                                    <td align="center">
                                        <a type="button" href="${pageContext.request.contextPath}/Editor/Deny?id=${c.id}"
                                                class="btn btn-danger">Từ chối
                                        </a>
                                    </td>
                                    <td>

                                    </td>
                                </tr>
                            </c:forEach>
                        </table>
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
