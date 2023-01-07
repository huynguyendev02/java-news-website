<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="m" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:useBean id="allArticle" scope="request" type="java.util.List<com.messi.king.messinews.models.Articles>"/>
<jsp:useBean id="byTitle" scope="request" type="java.util.List<com.messi.king.messinews.models.Articles>"/>
<jsp:useBean id="byAbstract" scope="request" type="java.util.List<com.messi.king.messinews.models.Articles>"/>
<jsp:useBean id="byContent" scope="request" type="java.util.List<com.messi.king.messinews.models.Articles>"/>

<jsp:useBean id="url" scope="request" type="java.lang.String"/>

<jsp:useBean id="currentPage" scope="request" type="java.lang.Integer"/>
<jsp:useBean id="maxPage" scope="request" type="java.lang.Integer"/>

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

            function byAllClick() {
                $('#byAll').css('display', 'block')
                $('#byTitle').css('display', 'none')
                $('#byAbstract').css('display', 'none')
                $('#byContent').css('display', 'none')
            }

            function byTitleClick() {
                $('#byAll').css('display', 'none')
                $('#byTitle').css('display', 'block')
                $('#byAbstract').css('display', 'none')
                $('#byContent').css('display', 'none')
            }

            function byAbstract() {
                $('#byAll').css('display', 'none')
                $('#byTitle').css('display', 'none')
                $('#byAbstract').css('display', 'block')
                $('#byContent').css('display', 'none')
            }

            function byContent() {
                $('#byAll').css('display', 'none')
                $('#byTitle').css('display', 'none')
                $('#byAbstract').css('display', 'none')
                $('#byContent').css('display', 'block')
            }

        </script>
    </jsp:attribute>
    <jsp:body>
        <div style="width: 15%"></div>
        <div class="d-flex justify-content-center">
            <div style="width: 70%">
                <div align="center">
                    <h3><i><b>Kết quả tìm kiếm</b></i></h3>
                    <div class="d-flex justify-content-center w-100 my-4">
                        <a href="#" onclick="byAllClick()" class="mx-3"><b>Toàn bộ</b></a>
                        <a href="#" onclick="byTitleClick()" class="mx-3"><b>Tiêu đề</b></a>
                        <a href="#" onclick="byAbstract()" class="mx-3"><b>Nội dung tóm tắt</b></a>
                        <a href="#" onclick="byContent()" class="mx-3"><b>Nôi dung đầy đủ</b></a>
                    </div>
                    <hr>
                </div>

                <div id="byAll">
                    <c:if test="${allArticle.size()==0}">
                        <div class=" mt-3 w-100" align="center">
                            <h5>
                                Không tìm thấy bài báo nào phù hợp...
                            </h5>
                        </div>
                    </c:if>
                    <c:forEach items="${allArticle}" var="c">
                        <div class=" mb-3 w-100 d-flex justify-content-between">
                            <div style="width: 30%">
                                <a href="${pageContext.request.contextPath}/Home/Details?id=${c.id}"
                                   onclick="checkPermission(${c.premium},event)">
                                    <img style="width: 100%"
                                         src="${pageContext.request.contextPath}/photos/articles/${c.id}/a.png"
                                         alt="">
                                </a>
                            </div>
                            <div style="width: 69%" class="pl-2 d-flex flex-column justify-content-between">
                                <div>
                                    <a href="${pageContext.request.contextPath}/Home/Details?id=${c.id}"
                                       onclick="checkPermission(${c.premium},event)">
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

                        <%--                        Phần trang --%>
                    <div class="mt-5 mb-3 w-100 d-flex justify-content-center">
                        <nav aria-label="Page navigation example">
                            <ul class="pagination">
                                <li class="page-item">
                                    <a class="page-link" href="${pageContext.request.contextPath}/Home${url}&page=1">
                                        <i class="fa fa-fast-backward" aria-hidden="true"></i>
                                    </a>
                                </li>
                                <li class="page-item">
                                    <c:if test="${currentPage==1}">
                                        <a class="page-link"
                                           href="${pageContext.request.contextPath}/Home${url}&page=1">
                                            <i class="fa fa-step-backward" aria-hidden="true"></i>
                                        </a>
                                    </c:if>
                                    <c:if test="${currentPage>1}">
                                        <a class="page-link"
                                           href="${pageContext.request.contextPath}/Home${url}&page=${currentPage-1}">
                                            <i class="fa fa-step-backward" aria-hidden="true"></i>
                                        </a>
                                    </c:if>
                                </li>
                                <li class="page-item">
                                    <a class="page-link"
                                       href="${pageContext.request.contextPath}/Home${url}&page=${currentPage}">
                                            ${currentPage}
                                    </a>
                                </li>
                                <li class="page-item">
                                    <c:if test="${currentPage==maxPage}">
                                        <a class="page-link"
                                           href="${pageContext.request.contextPath}/Home${url}&page=${maxPage}">
                                            <i class="fa fa-step-forward" aria-hidden="true"></i>
                                        </a>
                                    </c:if>
                                    <c:if test="${currentPage<maxPage}">
                                        <a class="page-link"
                                           href="${pageContext.request.contextPath}/Home${url}&page=${currentPage+1}">
                                            <i class="fa fa-step-forward" aria-hidden="true"></i>
                                        </a>
                                    </c:if>
                                </li>
                                <li class="page-item">
                                    <a class="page-link"
                                       href="${pageContext.request.contextPath}/Home${url}&page=${maxPage}">
                                        <i class="fa fa-fast-forward" aria-hidden="true"></i>
                                    </a>
                                </li>
                            </ul>
                        </nav>
                    </div>
                </div>

                <div id="byTitle" style="display: none">
                    <c:if test="${byTitle.size()==0}">
                        <div class=" mt-3 w-100" align="center">
                            <h5>
                                Không tìm thấy bài báo nào phù hợp...
                            </h5>
                        </div>
                    </c:if>
                    <c:forEach items="${byTitle}" var="c">
                        <div class=" mb-3 w-100 d-flex justify-content-between">
                            <div style="width: 30%">
                                <a href="${pageContext.request.contextPath}/Home/Details?id=${c.id}"
                                   onclick="checkPermission(${c.premium},event)">
                                    <img style="width: 100%"
                                         src="${pageContext.request.contextPath}/photos/articles/${c.id}/a.png"
                                         alt="">
                                </a>
                            </div>
                            <div style="width: 69%" class="pl-2 d-flex flex-column justify-content-between">
                                <div>
                                    <a href="${pageContext.request.contextPath}/Home/Details?id=${c.id}"
                                       onclick="checkPermission(${c.premium},event)">
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

                <div id="byAbstract" style="display: none">
                    <c:if test="${byAbstract.size()==0}">
                        <div class=" mt-3 w-100" align="center">
                            <h5>
                                Không tìm thấy bài báo nào phù hợp...
                            </h5>
                        </div>
                    </c:if>
                    <c:forEach items="${byAbstract}" var="c">
                        <div class=" mb-3 w-100 d-flex justify-content-between">
                            <div style="width: 30%">
                                <a href="${pageContext.request.contextPath}/Home/Details?id=${c.id}"
                                   onclick="checkPermission(${c.premium},event)">
                                    <img style="width: 100%"
                                         src="${pageContext.request.contextPath}/photos/articles/${c.id}/a.png"
                                         alt="">
                                </a>
                            </div>
                            <div style="width: 69%" class="pl-2 d-flex flex-column justify-content-between">
                                <div>
                                    <a href="${pageContext.request.contextPath}/Home/Details?id=${c.id}"
                                       onclick="checkPermission(${c.premium},event)">
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

                <div id="byContent" style="display: none">
                    <c:if test="${byContent.size()==0}">
                        <div class=" mt-3 w-100" align="center">
                            <h5>
                                Không tìm thấy bài báo nào phù hợp...
                            </h5>
                        </div>
                    </c:if>
                    <c:forEach items="${byContent}" var="c">
                        <div class=" mb-3 w-100 d-flex justify-content-between">
                            <div style="width: 30%">
                                <a href="${pageContext.request.contextPath}/Home/Details?id=${c.id}"
                                   onclick="checkPermission(${c.premium},event)">
                                    <img style="width: 100%"
                                         src="${pageContext.request.contextPath}/photos/articles/${c.id}/a.png"
                                         alt="">
                                </a>
                            </div>
                            <div style="width: 69%" class="pl-2 d-flex flex-column justify-content-between">
                                <div>
                                    <a href="${pageContext.request.contextPath}/Home/Details?id=${c.id}"
                                       onclick="checkPermission(${c.premium},event)">
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