<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="m" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:useBean id="articlesList" scope="request" type="java.util.List<com.messi.king.messinews.models.Articles>"/>

<m:main>
     <jsp:attribute name="css">
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

          </style>
    </jsp:attribute>
    <jsp:body>
        <form action="" method="post" class="h-100">
            <div class="d-flex justify-content-center bgColorGray">
                <!--    left-->
                <div class="bgColorGray" style="width: 15%">

                </div>

                <!--    center-->
                <div style="width: 70%; background-color: white" class="my-3 p-3">
                    <h4>Những bài viết của bạn</h4>
                    <hr>
                    <br>
                    <table class="w-100" cellpadding="5px">
                        <tr style="background-color: #EEEEEE">
                            <td>Tiêu đề</td>
                            <td align="center">Tramg thái</td>
                            <td align="center">Ngày xuất bản</td>
                            <td align="center">Lượt xem</td>
                            <td align="center">Xóa</td>
                        </tr>
                        <c:forEach items="${articlesList}" var="c">
                            <tr>
                                <td>
                                    <c:choose>
                                        <c:when test="${c.status != 1}">
                                            <a href="${pageContext.request.contextPath}/Writer/Edit?id=${c.id}">
                                                    ${c.title}
                                            </a>
                                        </c:when>
                                        <c:otherwise>
                                            ${c.title}
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td align="center">
                                    <c:choose>
                                        <c:when test="${c.status == 0}">
                                            <p style="color: red"> Bị từ chối </p>
                                        </c:when>

                                        <c:when test="${c.status == 1}">
                                            <p style="color: forestgreen"> Đã duyệt </p>
                                        </c:when>

                                        <c:otherwise>
                                            <p style="color: goldenrod"> Bản thảo </p>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td align="center">
                                    <script>
                                        document.write('${c.publish_date}'.slice(8, 10) + '/' + '${c.publish_date}'.slice(5, 7) + '/' + '${c.publish_date}'.slice(0, 4))
                                    </script>
                                </td>
                                <td align="center"> ${c.views}</td>
                                <td align="center">
                                    <button type="button" formaction="" class="btn btn-danger">Xóa</button>
                                </td>
                                <td>

                                </td>
                            </tr>
                        </c:forEach>
                    </table>
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
