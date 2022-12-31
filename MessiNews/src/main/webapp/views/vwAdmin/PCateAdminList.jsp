<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="m" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:useBean id="allPCategories" scope="request"
             type="java.util.List<com.messi.king.messinews.models.ParentCategories>"/>
<jsp:useBean id="allCategories" scope="request" type="java.util.List<com.messi.king.messinews.models.Categories>"/>

<m:main>
  <jsp:body>
    <form action="" method="post">
      <div class="d-flex justify-content-center bgColorGray">
        <!--    left-->
        <div class="bgColorGray" style="width: 15%">

        </div>

        <!--    center-->
        <div style="width: 70%; background-color: white" class="m-4 p-3">
          <div class="d-flex justify-content-between">
            <h4>Danh sách các chuyên mục lớn</h4>
            <a href="${pageContext.request.contextPath}/Admin/Categories/AddPCate"
               class="mx-3 px-3 btn btn-outline-success"
               style="border-radius: 20px" type="button">
              <i class="fa fa-plus" aria-hidden="true"></i>
              Thêm chuyên mục lớn mới
            </a>
          </div>

          <hr>
          <div id="danhSach">
            <table class="w-100" cellpadding="5px">
              <tr style="background-color: #EEEEEE">
                <td>ID</td>
                <td align="center">Tên chuyên mục</td>
                <td align="center">Xóa</td>
              </tr>
              <c:forEach items="${allPCategories}" var="c">
                <tr>
                  <td>${c.id}</td>
                  <td align="center">
                    <a href="${pageContext.request.contextPath}/Admin/Categories/EditPCate?id=${c.id}">
                        ${c.name_parent_cate}
                    </a>
                  </td>
                  <td align="center">
                    <button type="submit"
                            formaction="${pageContext.request.contextPath}/Admin/Categories/DeletePCate?idPCate=${c.id}"
                            class="btn btn-danger">Xóa
                    </button>
                  </td>
                </tr>
              </c:forEach>
            </table>
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
