<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="m" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:useBean id="article" scope="request" type="com.messi.king.messinews.models.Articles"/>
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
    <jsp:attribute name="js">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-datetimepicker/2.5.20/jquery.datetimepicker.full.min.js"
                integrity="sha512-AIOTidJAcHBH2G/oZv9viEGXRqDNmfdPVPYOYKGy3fti0xIplnlgMHUGfuNRzC6FkzIo0iIxgFnr9RikFxK+sw=="
                crossorigin="anonymous" referrerpolicy="no-referrer"></script>
        <script>
            function showListCart(idPCat, namePCat) {
                let list = $('.listCat');
                document.getElementById('btPCat').innerText = namePCat;
                for (let i = 0; i <= 10; i++) {
                    if (i == idPCat-1) {
                        list.get(i).style.display = 'block';
                    } else {
                        list.get(i).style.display = 'none';
                    }
                }
            }

            function btCatClick(idPCat, idCat, nameCat, url){
                $('.btCat').get(idPCat-1).innerHTML = nameCat
                // $('#formAction').action = url
                document.getElementById('formAction').action = url
            }

            $('#txtDOB').datetimepicker({
                format: 'd/m/Y',
                timepicker: false,
                mask: true
            });

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
                    <div style=" width: 100%">
                        <div class="w-100 d-flex">
                            <div class="dropdown mt-3">
                                <button class="btn btn-outline-secondary btStyle" type="button" id="btPCat"
                                        data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    Chuyên mục lớn
                                </button>
                                <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                                    <c:forEach items="${allPCategories}" var="c">
                                        <a class="dropdown-item"
                                           onclick="showListCart('${c.id}','${c.name_parent_cate}')">${c.name_parent_cate}</a>
                                    </c:forEach>
                                </div>
                            </div>
                            <c:forEach items="${allPCategories}" var="c">
                                <div class="dropdown mt-3 ml-5 listCat" style="display: none">
                                    <button class="btn btn-outline-secondary btStyle btCat" type="button"
                                            data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                        Chuyên mục nhỏ
                                    </button>
                                    <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                                        <c:forEach items="${allCategories}" var="d">
                                            <c:if test="${c.id == d.parent_cate_id}">
                                                <a class="dropdown-item" onclick="btCatClick('${d.parent_cate_id}','${d.id}','${d.name_category}','${pageContext.request.contextPath}/Editor/Allow?idArticle=${article.id}&idCat=${d.id}')">${d.name_category}</a>
                                            </c:if>
                                        </c:forEach>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                        <br>
                        <div class="dropdown">
                            <button class="btn btn-outline-secondary btStyle" type="button" data-toggle="dropdown"
                                    aria-haspopup="true"
                                    aria-expanded="false">
                                Nhãn
                            </button>
                            <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                                <c:forEach items="${allCategories}" var="c">
                                    <a onclick="choosePCat(1)" class="dropdown-item">${c.name_category}</a>
                                </c:forEach>
                            </div>
                        </div>
                        <br>
                        <br>

                        <div class="pl-2 btStyle d-flex justify-content-between">
                            <div align="center">Ngày phát hành</div>
                            <input name="dob" id="txtDOB" type="text" class=" inputStyle">
                        </div>
                    </div>
                    <br>
                    <br>
                    <div align="end">
                        <a href="${pageContext.request.contextPath}/Editor/List" class="btn btn-secondary mr-2">
                            <i class="fa fa-times" aria-hidden="true"></i>
                            Hủy bỏ
                        </a>
                        <button class="btn btn-success" type="submit">
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
