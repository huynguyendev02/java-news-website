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
    <jsp:attribute name="js">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-datetimepicker/2.5.20/jquery.datetimepicker.full.min.js"
                integrity="sha512-AIOTidJAcHBH2G/oZv9viEGXRqDNmfdPVPYOYKGy3fti0xIplnlgMHUGfuNRzC6FkzIo0iIxgFnr9RikFxK+sw=="
                crossorigin="anonymous" referrerpolicy="no-referrer"></script>
        <script>
            function showListCart(idPCat, namePCat) {
                $('.listCat').each(function (index, value) {
                    $(this).css('display', 'none');
                });
                document.getElementById(idPCat).style.display = 'block';
                document.getElementById('btPCat').innerText = namePCat;

            }

            function btCatClick(idBtCat, nameCat, url) {
                document.getElementById(idBtCat).innerText = nameCat;
                document.getElementById('formAction').action = url
            }

            function setArrTag() {
                let list = []
                $('.ckBox').each(function (index, value) {
                    if ($(this).is(':checked')) {
                        list.push($(this).val())
                    }
                });
                document.getElementById('listTagId').value = list;
            }

            $('#publish_time').datetimepicker({
                format: 'd/m/Y',
                timepicker: false,
                mask: true
            });
            let a = 5;

        </script>
    </jsp:attribute>
    <jsp:body>
        <form id="formAction" action="" method="post">
            <div class="d-flex justify-content-center bgColorGray">
                <!--    left-->
                <div class="bgColorGray" style="width: 15%">

                </div>

                <!--    center-->
                <div style="width: 70%; background-color: white" class="m-4 p-3">
                    <h4>Xử lý phê duyệt bài viết</h4>
                    <hr>
                    <br>
                    <h5>Đang xử lý bài: ${article.title}</h5> <br>
                    <div class="w-100 d-flex">
                        <table width="100%" cellpadding="15px">
                            <tr>
                                <td style="width: 20%;" align="top">Chuyên mục</td>
                                <td style="width: 40%">
                                    <div class="dropdown mt-3">
                                        <button class="btn btn-outline-secondary btStyle" type="button" id="btPCat"
                                                data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                            Chuyên mục lớn
                                        </button>
                                        <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                                            <c:forEach items="${allPCategories}" var="c">
                                                <a class="dropdown-item"
                                                   onclick="showListCart('divCat${c.id}','${c.name_parent_cate}')">${c.name_parent_cate}</a>
                                            </c:forEach>
                                        </div>
                                    </div>
                                </td>
                                <td style="width: 40%">
                                    <c:forEach items="${allPCategories}" var="c">
                                        <div id="divCat${c.id}" class="dropdown mt-3 ml-5 listCat"
                                             style="display: none">
                                            <button id="btChillCat${c.id}"
                                                    class="btn btn-outline-secondary btStyle btCat" type="button"
                                                    data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                Chuyên mục nhỏ
                                            </button>
                                            <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                                                <c:forEach items="${allCategories}" var="d">
                                                    <c:if test="${c.id == d.parent_cate_id}">
                                                        <a class="dropdown-item"
                                                           onclick="btCatClick('btChillCat${c.id}','${d.name_category}','${pageContext.request.contextPath}/Editor/Accept?id=${article.id}&idCat=${d.id}')">${d.name_category}</a>
                                                    </c:if>
                                                </c:forEach>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </td>
                            </tr>
                            <tr>
                                <td>Ngày phát hành</td>
                                <td>
                                    <input name="publish_time" id="publish_time" type="text" class=" inputStyle">
                                </td>
                                <td>
                                </td>
                            </tr>
                            <tr>
                                <td style="vertical-align: top">Loại báo</td>
                                <td>
                                    <input type="radio" id="normal" name="premium" value="0">
                                    <label for="normal">Thường</label><br>
                                    <input type="radio" id="premium" name="premium" value="1">
                                    <label for="premium">Cao cấp</label><br>
                                </td>
                            </tr>
                            <tr>
                                <td style="vertical-align: top"> Chọn nhãn</td>
                                <td colspan="2">
                                    <input id="listTagId" name="listTagId" type="text" style="display: none">
                                    <c:forEach items="${tags}" var="c">
                                        <input class="ckBox" type="checkbox" id="checkBox${c.id}" value="${c.id}">
                                        <label for="checkBox${c.id}">${c.name_tags} &ensp;</label>
                                    </c:forEach>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <br>
                    <br>
                    <div align="end">
                        <a href="${pageContext.request.contextPath}/Editor/ListDraft" class="btn btn-secondary mr-2">
                            <i class="fa fa-times" aria-hidden="true"></i>
                            Hủy bỏ
                        </a>
                        <button onclick="setArrTag()" class="btn btn-success" type="submit">
                            <i class="fa fa-check" aria-hidden="true"></i>
                            Hoàn thành
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
