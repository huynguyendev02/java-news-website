<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="m" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:useBean id="article" scope="request" type="com.messi.king.messinews.models.Articles"/>
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
                    <h4>Xử lý từ chối bài viết</h4>
                    <hr>
                    <br>
                    <h5>Đang xử lý bài: ${article.title}</h5> <br>
                    <div style=" width: 100%">
                        <h5 id="titleTuChoi"></h5>
                        <label for="txtTuChoi"><b>Lý do từ chối</b></label>
                        <textarea id="txtTuChoi" name="reason" class="bgColorGray w-100 p-3" rows="4"
                                  style="border-radius: 10px; border-style: none">
                        </textarea>
                        <br>
                        <br>
                        <div align="end">
                            <a href="${pageContext.request.contextPath}/Editor/ListDraft" class="btn btn-secondary mr-2">
                                <i class="fa fa-times" aria-hidden="true"></i>
                                Hủy bỏ
                            </a>
                            <button class="btn btn-success" type="submit">
                                <i class="fa fa-check" aria-hidden="true"></i>
                                Hoàn thành
                            </button>
                        </div>
                    </div>
                </div>

                <!--    right-->
                <div style="width: 15%" class="d-flex align-items-end flex-column bgColorGray">
                </div>
            </div>
        </form>
    </jsp:body>
</m:main>
