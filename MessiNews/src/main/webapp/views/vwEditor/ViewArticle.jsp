<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="m" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:useBean id="article" scope="request" type="com.messi.king.messinews.models.Articles"/>
<jsp:useBean id="allPCategories" scope="request"
             type="java.util.List<com.messi.king.messinews.models.ParentCategories>"/>
<jsp:useBean id="allCategories" scope="request" type="java.util.List<com.messi.king.messinews.models.Categories>"/>
<jsp:useBean id="tags" scope="request" type="java.util.List<com.messi.king.messinews.models.Tags>"/>

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

              .aTags {
                  border-style: none;
                  border-radius: 20px;
              }
          </style>
    </jsp:attribute>
    <jsp:attribute name="js">
        <script>
            function chinhSua(inputId, btId) {
                document.getElementById(inputId).readOnly = false;
                if (document.getElementById(btId).innerText == 'Save') {
                    document.getElementById('comment').value = document.getElementById(inputId).value
                    document.getElementById(btId).type = 'submit'
                } else {
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
                <div style="width: 70%; background-color: white" class="mt-3 p-3">
                    <div>
                        <c:forEach items="${allCategories}" var="c">
                            <c:if test="${c.id == article.categories_id}">
                                <c:set var="PCatId" scope="session" value="${c.parent_cate_id}"/>
                            </c:if>
                        </c:forEach>
                        <c:forEach items="${allPCategories}" var="c">
                            <c:if test="${c.id == PCatId}">
                                <b>${c.name_parent_cate}</b>
                            </c:if>
                        </c:forEach>
                        <i class="fa fa-caret-right px-2" aria-hidden="true"></i>
                        <c:forEach items="${allCategories}" var="c">
                            <c:if test="${c.id == article.categories_id}">
                                <b>${c.name_category}</b>
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
                                        ${article.getWriterName(article.writer_id)}
                                </div>
                                <div style="font-size: 13px">
                                    Ngày:
                                    <script>
                                        document.write('${article.publish_date}'.slice(8, 10) + '/' + '${article.publish_date}'.slice(5, 7) + '/' + '${article.publish_date}'.slice(0, 4))
                                    </script>
                                    - ${article.views} lượt xem
                                </div>
                            </div>
                        </div>
                    </div>

                    <!--        Nội dung bài báo-->
                    <div class="pt-2" style="font-size: 17px">
                            ${article.content}
                    </div>
                    <hr>

                        <%--                        Danh sách tag --%>
                    <div>
                        <b>Tags:</b>
                        <c:forEach items="${tags}" var="c">
                            <span class="ml-3" >
                                    ${c.name_tags}
                            </span>
                        </c:forEach>
                        <c:if test="${tags.size()==0}">
                            Bài báo này chưa gán tag nào cả...
                        </c:if>
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
