<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="m" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:useBean id="editor" scope="request" type="com.messi.king.messinews.models.Users"/>
<jsp:useBean id="allPCategories" scope="request"
             type="java.util.List<com.messi.king.messinews.models.ParentCategories>"/>
<jsp:useBean id="allCategories" scope="request" type="java.util.List<com.messi.king.messinews.models.Categories>"/>
<jsp:useBean id="cates" scope="request" type="java.util.List<com.messi.king.messinews.models.Categories>"/>

<m:main>
    <jsp:attribute name="css">
          <style>
              .btStyle {
                  width: 350px;
                  border-radius: 5px;
              }

          </style>
    </jsp:attribute>
    <jsp:attribute name="js">
        <script>
            function setArrCat() {
                let list = []
                $('.ckBox').each(function (index, value) {
                    if ($(this).is(':checked')) {
                        list.push($(this).val())
                    }
                });
                document.getElementById('catesId').value = list;
            }

        </script>
    </jsp:attribute>
    <jsp:body>
        <form id="form" action="" method="post">
            <div class="d-flex justify-content-center bgColorGray">
                <!--    left-->
                <div class="bgColorGray" style="width: 15%">

                </div>

                <!--    center-->
                <div style="width: 70%; background-color: white" class="m-4 p-3">
                    <h4>Phân chuyên mục cho biên tập</h4>

                    <hr>
                    <h5>Biên tập: ${editor.username}</h5>
                    <input name="catesId" id="catesId" type="text" style="display: none">
                    <div class="w-100 px-5 pt-4">
                        <table border="1" class="w-100" cellpadding="10px">
                            <tr>
                                <td align="center">Chuyên mục lớn</td>
                                <td align="center">Chuyên mục nhỏ</td>
                            </tr>
                            <c:forEach items="${allPCategories}" var="c">
                                <tr>
                                    <td align="center" style="width: 50%">
                                            ${c.name_parent_cate}
                                    </td>
                                    <td class="pl-4">
                                        <c:forEach items="${allCategories}" var="d">
                                            <c:if test="${c.id == d.parent_cate_id}">
                                                <c:set var="checkCate" value="0"/>
                                                <c:forEach items="${cates}" var="f">
                                                    <c:if test="${f.id == d.id}">
                                                        <c:set var="checkCate" value="1"/>
                                                    </c:if>
                                                </c:forEach>
                                                <c:if test="${checkCate == 0}">
                                                    <input class="ckBox" type="checkbox" id="checkBox${d.id}"
                                                           name="fav_language" value="${d.id}">
                                                    <label for="checkBox${d.id}">${d.name_category}</label><br>
                                                </c:if>
                                                <c:if test="${checkCate == 1}">
                                                    <input class="ckBox" type="checkbox" id="checkBox${d.id}"
                                                           name="fav_language" value="${d.id}" checked>
                                                    <label for="checkBox${d.id}">${d.name_category}</label><br>
                                                </c:if>
                                            </c:if>
                                        </c:forEach>
                                    </td>
                                </tr>
                            </c:forEach>
                        </table>
                    </div>

                    <div id="save" align="end" class="mt-4">
                        <a href="${pageContext.request.contextPath}/Admin/Users/ListEditor"
                           class="btn btn-secondary mr-2">
                            <i class="fa fa-times" aria-hidden="true"></i>
                            Hủy bỏ
                        </a>
                        <button onclick="setArrCat()" class="btn btn-success" type="submit"
                                formaction="${pageContext.request.contextPath}/Admin/Users/AssignCategory?editorId=${editor.id}">
                            <i class="fa fa-check" aria-hidden="true"></i>
                            Lưu lại
                        </button>
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