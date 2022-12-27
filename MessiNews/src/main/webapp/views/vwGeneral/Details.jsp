<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="m" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:useBean id="article" scope="request" type="com.messi.king.messinews.models.Articles"/>
<jsp:useBean id="allPCategories" scope="request" type="java.util.List<com.messi.king.messinews.models.ParentCategories>"/>
<jsp:useBean id="allCategories" scope="request" type="java.util.List<com.messi.king.messinews.models.Categories>"/>

<m:main>
    <div class="d-flex justify-content-center bgColorGray">
        <!--    left-->
        <div class="bgColorGray" style="width: 15%">

        </div>

        <!--    center-->
        <div style="width: 70%; background-color: white" class="mt-4 p-3">
            <!--    Chuyên mục-->
            <div>

                <a href="">
                    <c:forEach items="${allCategories}" var="c">
                        <c:if test="${c.id == article.categories_id}">
                            <c:set var = "PCatId" scope = "session" value = "${c.parent_cate_id}"/>
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

            <!--        Tác giả bài đọc-->
            <div class="d-flex align-items-center py-3">
                <div>
                    <img class="imageIcon"
                         src="https://vtv1.mediacdn.vn/thumb_w/1000/2021/9/11/photo-7-16313013756371150928268.jpg"
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

            <!--        Nội dung bài báo-->
            <div class="pt-2" align="center" style="font-size: 17px">
                ${article.content}
            </div>

            <!--        Danh sách bình luận-->
            <div class="pt-4">
                <hr>
                <div class="d-flex ">
                    <img class="imageIcon"
                         src="https://static2.yan.vn/YanNews/202109/202109210147413038-a77aa638-beca-4e89-a0e7-a679dc39daa5_1250x833.gif"
                         alt="">
                    <div class="bgColorGray w-100 ml-3 p-1">
                        <a href="">Thái công</a>
                        <p>
                            Thái công thấy anh 7 đẹp trai quá ờ
                        </p>
                    </div>
                </div>
                <br>

                <div class="d-flex ">
                    <img class="imageIcon"
                         src="https://gamek.mediacdn.vn/133514250583805952/2021/6/8/hinh1-1623126067929783253870.jpg"
                         alt="">
                    <div class="bgColorGray w-100 ml-3 p-1">
                        <a href="">Da Cát Nượng</a>
                        <p>
                            Nượng ta là fan Anh 7 từ thời chiên quốc.
                        </p>
                    </div>
                </div>
                <br>
                <hr>

                <!--            Comment mới-->
                <div class="d-flex ">
                    <img class="imageIcon"
                         src="https://vtv1.mediacdn.vn/thumb_w/650/2014/incognito-chrome-spicytricks-1420018283508.jpg"
                         alt="">
                    <textarea class="bgColorGray w-100 ml-3 p-3" rows="4" style="border-radius: 10px; border-style: none"
                              placeholder="Bình luận ngay nào..."></textarea>
                </div>
                <br>
                <div align="end">
                    <button type="button" class="btn btn-outline-dark">
                        Comment
                    </button>
                </div>
                <hr>

                <!--            5 Bài ngẫu nhiên cùng chuyên mục-->
                <h4>Có thể bạn sẽ thích</h4>
                <div class=" pt-3 w-100 d-flex justify-content-between">
                    <div class="boxShadow" style=" width: 19%">
                        <a href="">
                            <img src="https://hanoispiritofplace.com/wp-content/uploads/2014/10/hinh-anh-cr7-dep-4.jpg"
                                 alt="" class="w-100" style="border-bottom-left-radius: 0; border-bottom-right-radius: 0;">
                            <div class="pl-3">

                                <i class="fa fa-star" aria-hidden="true" style="color: gold"></i>
                                Tác giả
                                <p style="font-weight: normal; color: black">
                                    Tiêu đề dài loằng ngoằng. Tiêu đề dài loằng ngoằng. Tiêu đề dài loằng ngoằng.
                                </p>
                            </div>
                        </a>
                    </div>

                    <div class="boxShadow" style=" width: 19%">
                        <a href="">
                            <img src="https://hanoispiritofplace.com/wp-content/uploads/2014/10/hinh-anh-cr7-dep-4.jpg"
                                 alt="" class="w-100" style="border-bottom-left-radius: 0; border-bottom-right-radius: 0;">
                            <div class="pl-3">

                                <i class="fa fa-star" aria-hidden="true" style="color: gold"></i>
                                Tác giả
                                <p style="font-weight: normal; color: black">
                                    Tiêu đề dài loằng ngoằng. Tiêu đề dài loằng ngoằng. Tiêu đề dài loằng ngoằng.
                                </p>
                            </div>
                        </a>
                    </div>
                    <div class="boxShadow" style=" width: 19%">
                        <a href="">
                            <img src="https://hanoispiritofplace.com/wp-content/uploads/2014/10/hinh-anh-cr7-dep-4.jpg"
                                 alt="" class="w-100" style="border-bottom-left-radius: 0; border-bottom-right-radius: 0;">
                            <div class="pl-3">

                                <i class="fa fa-star" aria-hidden="true" style="color: gold"></i>
                                Tác giả
                                <p style="font-weight: normal; color: black">
                                    Tiêu đề dài loằng ngoằng. Tiêu đề dài loằng ngoằng. Tiêu đề dài loằng ngoằng.
                                </p>
                            </div>
                        </a>
                    </div>
                    <div class="boxShadow" style=" width: 19%">
                        <a href="">
                            <img src="https://hanoispiritofplace.com/wp-content/uploads/2014/10/hinh-anh-cr7-dep-4.jpg"
                                 alt="" class="w-100" style="border-bottom-left-radius: 0; border-bottom-right-radius: 0;">
                            <div class="pl-3">

                                <i class="fa fa-star" aria-hidden="true" style="color: gold"></i>
                                Tác giả
                                <p style="font-weight: normal; color: black">
                                    Tiêu đề dài loằng ngoằng. Tiêu đề dài loằng ngoằng. Tiêu đề dài loằng ngoằng.
                                </p>
                            </div>
                        </a>
                    </div>
                    <div class="boxShadow" style=" width: 19%">
                        <a href="">
                            <img src="https://hanoispiritofplace.com/wp-content/uploads/2014/10/hinh-anh-cr7-dep-4.jpg"
                                 alt="" class="w-100" style="border-bottom-left-radius: 0; border-bottom-right-radius: 0;">
                            <div class="pl-3">

                                <i class="fa fa-star" aria-hidden="true" style="color: gold"></i>
                                Tác giả
                                <p style="font-weight: normal; color: black">
                                    Tiêu đề dài loằng ngoằng. Tiêu đề dài loằng ngoằng. Tiêu đề dài loằng ngoằng.
                                </p>
                            </div>
                        </a>
                    </div>
                </div>
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
</m:main>
