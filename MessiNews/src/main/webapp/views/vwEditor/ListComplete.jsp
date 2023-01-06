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
    </jsp:attribute>

    <jsp:body>
        <form action="" method="post">
            <div class="d-flex justify-content-center bgColorGray">
                <!--    left-->
                <div class="bgColorGray" style="width: 15%">

                </div>

                <!--    center-->
                <div style="width: 70%; background-color: white" class="m-4 p-3">
                    <h4>Danh sách các bài viết đã duyệt</h4>
                    <hr>
                    <br>
                    <div id="danhSach">
                        <table class="w-100" cellpadding="5px">
                            <tr style="background-color: #EEEEEE">
                                <td style="width: 35%">Tiêu đề</td>
                                <td align="center" style="width: 15%">Chuyên mục</td>
                                <td align="center" style="width: 20%">Tác giả</td>
                                <td align="center" style="width: 15%">Trang thái</td>
                                <td align="center" style="width: 10%">Ngày đăng</td>
                                <td align="center" style="width: 10%">Views</td>
                                <td align="center" style="width: 5%">Loại</td>

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
                                        <c:if test="${c.status == 1}">
                                            <script>
                                                document.write('${c.publish_date}'.slice(8, 10) + '/' + '${c.publish_date}'.slice(5, 7) + '/' + '${c.publish_date}'.slice(0, 4))
                                            </script>
                                        </c:if>
                                    </td>
                                    <td align="center">
                                        <c:if test="${c.status == 1}">
                                            ${c.views}
                                        </c:if>
                                    </td>
                                    <td align="center">
                                        <c:if test="${c.premium == 0}">
                                            <i class="fa fa-star" aria-hidden="true" style="color: grey"></i>
                                        </c:if>
                                        <c:if test="${c.premium == 1}">
                                            <i class="fa fa-star" aria-hidden="true" style="color: gold"></i>
                                        </c:if>
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
