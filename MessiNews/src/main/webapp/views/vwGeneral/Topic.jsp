<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="m" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:useBean id="articles" scope="request" type="java.util.List<com.messi.king.messinews.models.Articles>"/>

<m:main>
    <jsp:attribute name="css">
          <link rel="stylesheet"
                href="https://cdnjs.cloudflare.com/ajax/libs/jquery-datetimepicker/2.5.20/jquery.datetimepicker.min.css"
                integrity="sha512-f0tzWhCwVFS3WeYaofoLWkTP62ObhewQ1EZn65oSYDZUg1+CyywGKkWzm8BxaJj5HGKI72PnMH9jYyIFz+GH7g=="
                crossorigin="anonymous" referrerpolicy="no-referrer"/>
          <style>
              /*.bgColorGray {*/
              /*    border-radius: 10px;*/
              /*    background-color:#EEEEEE;*/
              /*}*/
          </style>
      </jsp:attribute>
    <jsp:body>
        <div class="d-flex justify-content-center">
            <div style="width: 15%"></div>
            <div style="width: 70%">

<%--            Tiêu đề và danh mục--%>
                <div align="center">
                    <h1><i><b>Thế giới</b></i></h1>
                    <div class="d-flex justify-content-center w-100 my-4">
                        <a href="" class="mx-4">Hello1</a>
                        <a href="" class="mx-4">Hello2</a>
                        <a href="" class="mx-4">Hello3</a>
                        <a href="" class="mx-4">Hello4</a>
                        <a href="" class="mx-4">Hello5</a>
                        <a href="" class="mx-4">Hello6</a>
                    </div>
                    <hr>
                </div>

                    <%--            các bài báo--%>
                <div>
                        <%--                Bài lớn nhất--%>
                    <div class="d-flex justify-content-between bgColorGray">
                        <div style="width: 60%">
                            <img src="${pageContext.request.contextPath}/photos/articles/${articles[0].id}/a.png" alt=""
                                 class="w-100">
                        </div>
                        <div class="p-3 d-flex justify-content-between flex-column" style="width: 40%">
                            <div>
                                <a href="${pageContext.request.contextPath}/Home/Details?id=${articles[0].id}">
                                    <h3 class="mb-0">
                                        <c:if test="${articles[0].premium == 0}">
                                            <i class="fa fa-star" aria-hidden="true" style="color: gold"></i>
                                        </c:if>
                                        ${articles[0].title}
                                    </h3>
                                    <p>${articles[0].publish_date}</p>
                                    <p>${articles[0].abstract_content}</p>
                                </a>
                            </div>

                            <div>
                                <img class="imageIcon"
                                     src="https://static2.yan.vn/YanNews/202109/202109210147413038-a77aa638-beca-4e89-a0e7-a679dc39daa5_1250x833.gif"
                                     alt="">
                                Tác giả
                            </div>
                        </div>
                    </div>
                    <hr>
                    <br>

                        <%--                các bài nhỏ--%>
                    <c:forEach items="${articles}" begin="1" var="c">
                        <div class="d-flex justify-content-between bgColorGray">
                            <div style="width: 30%">
                                <img src="${pageContext.request.contextPath}/photos/articles/${c.id}/a.png" alt=""
                                     class="w-100">
                            </div>
                            <div class="p-3 d-flex justify-content-between flex-column" style="width: 70%">
                                <div>
                                    <a href="${pageContext.request.contextPath}/Home/Details?id=${c.id}">
                                        <h4 class="mb-0">
                                            <c:if test="${c.premium == 0}">
                                                <i class="fa fa-star" aria-hidden="true" style="color: gold"></i>
                                            </c:if>
                                            ${c.title}
                                        </h4>
                                        <p>${c.publish_date}</p>
                                        <p>${c.abstract_content}</p>
                                    </a>
                                </div>

                                <div>
                                    <img class="imageIcon"
                                         src="https://static2.yan.vn/YanNews/202109/202109210147413038-a77aa638-beca-4e89-a0e7-a679dc39daa5_1250x833.gif"
                                         alt="">
                                    ${c.writer_id}
                                </div>
                            </div>
                        </div>
                        <hr>
                        <br>
                    </c:forEach>
                </div>

                    <%--            Phân trang--%>
                <div class="w-100 d-flex justify-content-center">
                    <nav aria-label="...">
                        <ul class="pagination">
                            <li class="page-item disabled">
                                <span class="page-link">Previous</span>
                            </li>
                            <li class="page-item">
                                <a class="page-link" href="#">1</a>
                            </li>
                            <li class="page-item active">
                        <span class="page-link">2
                            <span class="sr-only">(current)</span>
                        </span>
                            </li>
                            <li class="page-item"><a class="page-link" href="#">3</a></li>
                            <li class="page-item">
                                <a class="page-link" href="#">Next</a>
                            </li>
                        </ul>
                    </nav>
                </div>
            </div>

                <%--            left--%>
            <div style="width: 15%" class="d-flex align-items-end flex-column">
                <div class="mt-auto p-2" style="position: fixed; bottom: 10px; right: 10px">
                    <a href="">
                        <i class="fa fa-arrow-circle-o-up fa-3x" aria-hidden="true"></i>
                    </a>
                </div>
            </div>
        </div>
    </jsp:body>
</m:main>
