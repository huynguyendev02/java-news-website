<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="m" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:useBean id="articleList" scope="request" type="java.util.List<com.messi.king.messinews.models.Articles>"/>


<m:main>
    <jsp:attribute name="css">
          <style>
              .ATitle {
                  font-size: 13px;
                  font-weight: bold;
                  color: cornflowerblue;
              }
          </style>
    </jsp:attribute>
    <jsp:attribute name="js">
        <script>
            function checkPermission(premium, event) {
                if (premium == 1) {
                    if (!${auth}) {
                        alert("Bạn phải đăng nhập mới xem được bài này")
                        event.preventDefault();
                    } else {
                        if (${authUser.checkExpiration()==0}) {
                            alert("Bạn cần phải gia hạn tài khoản để có thể xem bài này")
                            event.preventDefault();
                        }
                    }
                }
            }
        </script>
    </jsp:attribute>
    <jsp:body>
        <div style="width: 15%"></div>
        <div class="d-flex justify-content-center">
            <div style="width: 70%">
                <h3>Kết quả tìm kiếm</h3>
                <br>
                <c:forEach items="${articleList}" var="c">
                    <div class=" mb-3 w-100 d-flex justify-content-between">
                        <div style="width: 30%">
                            <a href="${pageContext.request.contextPath}/Home/Details?id=${c.id}" onclick="checkPermission(${c.premium},event)">
                                <img style="width: 100%"
                                     src="${pageContext.request.contextPath}/photos/articles/${c.id}/a.png"
                                     alt="">
                            </a>
                        </div>
                        <div style="width: 69%" class="pl-2 d-flex flex-column justify-content-between">
                            <div>
                                <a href="${pageContext.request.contextPath}/Home/Details?id=${c.id}" onclick="checkPermission(${c.premium},event)">
                                    <c:if test="${c.premium == 1}">
                                        <i class="fa fa-star" aria-hidden="true" style="color: gold"></i>
                                    </c:if>
                                    <b>${c.title}</b><br>
                                        ${c.abstract_content}
                                </a>
                            </div>
                            <div class="d-flex w-100 justify-content-between">
                                <div>
                                    <img src="${pageContext.request.contextPath}/photos/userAvatar/${c.writer_id}/avatar.png"
                                         alt="" style="width: 30px; height: 30px; border-radius: 30px">
                                        ${c.getWriterName(c.writer_id)}
                                </div>
                                <div class="pr-4">
                                    <a href="${pageContext.request.contextPath}/Home/ByCat?id=${c.categories_id}"
                                       class="ATitle">
                                        <b>${c.getCategoriesName(c.categories_id)}</b>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>


            </div>
        </div>
        <div style="width: 15%" class="d-flex align-items-end flex-column">
            <div class="mt-auto p-2" style="position: fixed; bottom: 10px; right: 10px">
                <a href="">
                    <i class="fa fa-arrow-circle-o-up fa-3x" aria-hidden="true"></i>
                </a>
            </div>
        </div>
    </jsp:body>
</m:main>
