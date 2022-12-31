<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="m" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:useBean id="allPCategories" scope="request"
             type="java.util.List<com.messi.king.messinews.models.ParentCategories>"/>
<jsp:useBean id="allCategories" scope="request" type="java.util.List<com.messi.king.messinews.models.Categories>"/>

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
            function choosePCat(url, name){
                document.getElementById('btPCat').innerText = name;
                document.getElementById('form').action = url
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
                    <h4>Thêm chuyên mục nhỏ mới</h4>

                    <hr>
                    <label for="title">Tên chủ đề</label>
                    <input type="text" class="form-control" name="nameCate" id="title" autofocus required/>
                    <div class="dropdown mt-3">
                        <button class="btn btn-outline-secondary btStyle" type="button" id="btPCat"
                                data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            Chuyên mục lớn
                        </button>
                        <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                            <c:forEach items="${allPCategories}" var="c">
                                <a class="dropdown-item"
                                   onclick="choosePCat('${pageContext.request.contextPath}/Admin/Categories/AddCate?pcateId=${c.id}','${c.name_parent_cate}')">${c.name_parent_cate}</a>
                            </c:forEach>
                        </div>
                    </div>
                    <hr>
                    <div id="save" align="end">
                        <a href="${pageContext.request.contextPath}/Admin/Categories/ListCate" class="btn btn-secondary mr-2">
                            <i class="fa fa-times" aria-hidden="true"></i>
                            Hủy bỏ
                        </a>
                        <button class="btn btn-success" type="submit">
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
