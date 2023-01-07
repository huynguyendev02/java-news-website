<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="m" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:useBean id="articlesList" scope="request" type="java.util.List<com.messi.king.messinews.models.Articles>"/>
<jsp:useBean id="allPCategories" scope="request"
             type="java.util.List<com.messi.king.messinews.models.ParentCategories>"/>
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
                    <div class="d-flex justify-content-between">
                        <h4>Danh sách các bài viết đã duyệt</h4>
                        <a href="${pageContext.request.contextPath}/Admin/Articles/Upload"
                           class="mx-3 px-3 btn btn-outline-success"
                           style="border-radius: 20px" type="button">
                            <i class="fa fa-plus" aria-hidden="true"></i>
                            Thêm bài viết với
                        </a>
                    </div>
                    <hr>
                    <br>
                    <div id="danhSach">
                        <table class="w-100" cellpadding="5px">
                            <tr style="background-color: #EEEEEE">
                                <td style="width: 40%">Tiêu đề</td>
                                <td align="center" style="width: 15%">Chuyên mục</td>
                                <td align="center" style="width: 20%">Tác giả</td>
                                <td align="center" style="width: 10%">Ngày đăng</td>
                                <td align="center" style="width: 5%">Loại</td>
                                <td align="center" style="width: 20%">Lượt xem</td>
                            </tr>
                            <c:forEach items="${articlesList}" var="c">
                                <tr>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/Home/Details?id=${c.id}">
                                                ${c.title}
                                        </a>
                                    </td>
                                    <td align="center">
                                            ${c.getCategoriesName(c.categories_id)}
                                    </td>
                                    <td align="center">
                                            ${c.getWriterName(c.writer_id)}
                                    </td>
                                    <td align="center">
                                        <script>
                                            document.write('${c.publish_date}'.slice(8, 10) + '/' + '${c.publish_date}'.slice(5, 7) + '/' + '${c.publish_date}'.slice(0, 4))
                                        </script>
                                    </td>
                                    <td align="center">
                                        <c:if test="${c.premium == 0}">
                                            <i class="fa fa-star" aria-hidden="true" style="color: grey"></i>
                                        </c:if>
                                        <c:if test="${c.premium == 1}">
                                            <i class="fa fa-star" aria-hidden="true" style="color: gold"></i>
                                        </c:if>
                                    </td>
                                    <td align="center">
                                            ${c.views}
                                    </td>

                                </tr>
                            </c:forEach>
                        </table>
                    </div>
                </div>

                <!--    right-->
                <div style="width: 15%" class="d-flex align-items-end flex-column bgColorGray">
                </div>
            </div>
        </form>
    </jsp:body>
</m:main>
