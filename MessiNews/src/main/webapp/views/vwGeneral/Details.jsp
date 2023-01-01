<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="m" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:useBean id="article" scope="request" type="com.messi.king.messinews.models.Articles"/>
<jsp:useBean id="allPCategories" scope="request"
             type="java.util.List<com.messi.king.messinews.models.ParentCategories>"/>
<jsp:useBean id="allCategories" scope="request" type="java.util.List<com.messi.king.messinews.models.Categories>"/>
<jsp:useBean id="related" scope="request" type="java.util.List<com.messi.king.messinews.models.Articles>"/>
<jsp:useBean id="comments" scope="request" type="java.util.List<com.messi.king.messinews.models.Comments>"/>
<jsp:useBean id="auth" scope="session" type="java.lang.Boolean"/>
<jsp:useBean id="authUser" scope="session" type="com.messi.king.messinews.models.Users"/>

<m:main>
     <jsp:attribute name="css">
          <style>
              .Shadown {
                  border-style: solid;
                  border-right: none;
              }

              .btEdit {
                  border-style: none;
                  height: 70%;
              }

              .inputComment {
                  border-style: none;
              }

              .inputComment:focus {
                  outline: none;
              }

          </style>
    </jsp:attribute>
    <jsp:attribute name="js">
        <script>
            function chinhSua(inputId, btId){
                document.getElementById(inputId).readOnly = false;
                if (document.getElementById(btId).innerText == 'Save'){
                    document.getElementById('comment').value = document.getElementById(inputId).value
                    document.getElementById(btId).type = 'submit'
                }
                else{
                    document.getElementById(btId).innerText = 'Save';
                }
            }
        </script>
    </jsp:attribute>
    <jsp:body>
        <form action="" method="post">
            <div class="d-flex justify-content-center bgColorGray">
                <!--    left-->
                <div class="bgColorGray" style="width: 15%">
                </div>

                <!--    center-->
                <div style="width: 70%; background-color: white" class="mt-3 d-flex justify-content-center">
                    <div class=" p-3" style="width: 70%">
                        <div>
                            <a href="">
                                <c:forEach items="${allCategories}" var="c">
                                    <c:if test="${c.id == article.categories_id}">
                                        <c:set var="PCatId" scope="session" value="${c.parent_cate_id}"/>
                                    </c:if>
                                </c:forEach>
                                <c:forEach items="${allPCategories}" var="c">
                                    <c:if test="${c.id == PCatId}">
                                        <a href="${pageContext.request.contextPath}/Home/ByParentCat?id=${c.id}">
                                            <b>${c.name_parent_cate}</b>
                                        </a>
                                    </c:if>
                                </c:forEach>
                            </a>
                            <i class="fa fa-caret-right px-2" aria-hidden="true"></i>
                            <c:forEach items="${allCategories}" var="c">
                                <c:if test="${c.id == article.categories_id}">
                                    <a href="${pageContext.request.contextPath}/Home/ByCat?id=${c.id}">
                                        <b>${c.name_category}</b>
                                    </a>
                                </c:if>
                            </c:forEach>
                        </div>
                        <br>

                        <!--    Tiểu đề-->
                        <div>
                            <h1>${article.title}</h1>
                        </div>

                        <!--        Tác giả bài báo-->
                        <div class="d-flex justify-content-between py-3">
                            <div class="d-flex ">
                                <div>
                                    <img class="imageIcon"
                                         src="${pageContext.request.contextPath}/photos/userAvatar/${article.writer_id}/avatar.png"
                                         alt="">
                                </div>
                                <div class="pl-3">
                                    <div>
                                        <a href="">
                                                ${article.writer_id}
                                        </a>
                                    </div>
                                    <div style="font-size: 13px">
                                            ${article.publish_date} - ${article.views} lượt xem
                                    </div>
                                </div>
                            </div>
                            <div>
                                <c:if test="${auth}">
                                    <a href="${pageContext.request.contextPath}/Home/Download?id=${article.id}" class="btn btn-outline-info">
                                        <i class="fa fa-download" aria-hidden="true"></i>
                                        Tải xuống
                                    </a>
                                </c:if>
                            </div>
                        </div>

                        <!--        Nội dung bài báo-->
                        <div class="pt-2" style="font-size: 17px">
                                ${article.content}
                        </div>

                        <!--        Danh sách bình luận-->
                        <div class="pt-3">
                            <h4>Bình luận</h4>
                            <hr>
                            <input id="comment" name="comment" type="text" style="display: none">
                            <c:forEach items="${comments}" var="c">
                                <div class="d-flex ">
                                    <img class="imageIcon"
                                         src="${pageContext.request.contextPath}/photos/userAvatar/${c.user_id}/avatar.png"
                                         alt="">
                                    <div class="bgColorGray w-100 ml-3 p-1">
                                        <div class="d-flex justify-content-between">
                                            <div><b>${c.user_id}</b> - ${c.date}</div>
                                            <c:if test="${c.user_id == authUser.id}">
                                                <div>
                                                    <button type="submit" class="btEdit text-danger mr-2"
                                                            formaction="${pageContext.request.contextPath}/Home/Details/Comment/Delete?commentId=${c.id}">
                                                        Xóa
                                                    </button>
                                                    <button id="bt${c.id}" type="button" class="btEdit text-success"
                                                            formaction="${pageContext.request.contextPath}/Home/Details/Comment/Edit?commentId=${c.id}"
                                                            onclick="chinhSua('input${c.id}','bt${c.id}')">Chỉnh sửa
                                                    </button>
                                                </div>
                                            </c:if>
                                        </div>
                                        <input id="input${c.id}" type="text" class="inputComment w-100 bgColorGray" value="${c.comment}"
                                               readonly>
                                    </div>
                                </div>
                                <br>
                            </c:forEach>
                            <hr>

                            <!--            Comment mới-->
                            <c:if test="${auth}">
                                <div class="d-flex ">
                                    <img class="imageIcon"
                                         src="${pageContext.request.contextPath}/photos/userAvatar/${authUser.id}/avatar.png"
                                         alt="">
                                    <textarea name="realCmt" class="bgColorGray w-100 ml-3 p-3" rows="4"
                                              style="border-radius: 10px; border-style: none"
                                              placeholder="Bình luận ngay nào..."></textarea>
                                </div>
                                <br>
                                <div align="end">
                                    <button type="submit" class="btn btn-outline-dark"
                                            formaction="${pageContext.request.contextPath}/Home/Details/Comment/Add?artId=${article.id}">
                                        Bình luận
                                    </button>
                                </div>
                            </c:if>
                            <c:if test="${!auth}">
                                <div align="center">
                                    <h6>Bạn phải đăng nhập mới có thể tham gia bình luận! <a
                                            href="${pageContext.request.contextPath}/Account/Login"><b>Đăng nhập
                                        ngay</b></a></h6>
                                </div>
                            </c:if>
                        </div>
                    </div>


                    <div style="width: 30%;" class="p-3">
                        <h4>Có thể bạn sẽ quan tâm</h4>
                        <hr>
                            <%--    Các danh mục liên quan--%>
                        <c:forEach var="i" begin="0" end="4">
                            <div class="w-100 Shadown">
                                <a href="${pageContext.request.contextPath}/Home/Details?id=${related[i].id}">
                                    <img src="${pageContext.request.contextPath}/photos/articles/${related[i].id}/a.png"
                                         alt="" class="w-100"
                                         style="border-bottom-left-radius: 0; border-bottom-right-radius: 0;">
                                    <div class="p-2">
                                        <c:if test="${related[i].premium == 1}">
                                            <i class="fa fa-star" aria-hidden="true" style="color: gold"></i>
                                        </c:if>
                                        <c:forEach items="${allCategories}" var="c">
                                            <c:if test="${c.id == related[i].categories_id}">
                                                <a href="${pageContext.request.contextPath}/Home/ByCat?id=${c.id}">
                                                    <b>${c.name_category}</b>
                                                </a>
                                            </c:if>
                                        </c:forEach>
                                        <a href="${pageContext.request.contextPath}/Home/Details?id=${related[i].id}">
                                            <p>${related[i].title}</p>
                                        </a>
                                    </div>
                                </a>
                            </div>
                            <br>
                        </c:forEach>
                    </div>
                    <!--    Chuyên mục-->

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
