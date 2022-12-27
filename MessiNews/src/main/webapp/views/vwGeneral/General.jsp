<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="m" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:useBean id="top10AllCate" scope="request" type="java.util.List<com.messi.king.messinews.models.Articles>"/>
<jsp:useBean id="top5AllCateInWeek" scope="request" type="java.util.List<com.messi.king.messinews.models.Articles>"/>
<jsp:useBean id="latestNewsAllCate" scope="request" type="java.util.List<com.messi.king.messinews.models.Articles>"/>
<jsp:useBean id="newest10PerCate" scope="request" type="java.util.List<com.messi.king.messinews.models.Articles>"/>

<jsp:useBean id="allCategories" scope="request" type="java.util.List<com.messi.king.messinews.models.Categories>"/>

<m:main>
    <div class="d-flex justify-content-center">
        <div style="width: 15%"></div>
        <div style="width: 70%">
            <!--        10 bài báo được xem nhiều nhất (tất cả các danh mục)-->
            <div id="carouselExampleCaptions" class="carousel slide py-4" data-ride="carousel">
                <h3>Top 10 bài báo nhiều lượt xem nhất</h3>
                <ol class="carousel-indicators">
                    <li data-target="#carouselExampleCaptions" data-slide-to="0" class="active"></li>
                    <c:forEach var="i" begin="1" end="9">
                        <li data-target="#carouselExampleCaptions" data-slide-to="${i}"></li>
                    </c:forEach>
                </ol>
                <div class="carousel-inner">
                    <div class="carousel-item active">
                        <img src="${pageContext.request.contextPath}/photos/articles/${top10AllCate[0].id}/b.png"
                             class="d-block crop"
                             alt="...">
                        <div class="carousel-caption  w-100 h-100 grad"
                             style=" bottom: 0; left: 0 ; z-index:2">
                            <a href="${pageContext.request.contextPath}/Home/Details?id=${top10AllCate[0].id}"
                               class=" carousel-caption d-none d-md-block p-0">
                                <h2>${top10AllCate[0].title}</h2>
                                <p>${top10AllCate[0].views} lượt xem</p>
                            </a>
                        </div>
                    </div>

                    <c:forEach var="i" begin="1" end="9">
                        <div class="carousel-item">
                            <img src="${pageContext.request.contextPath}/photos/articles/${top10AllCate[i].id}/b.png"
                                 class="d-block crop"
                                 alt="...">
                            <div class="carousel-caption d-flex align-items-end w-100 h-100 grad"
                                 style=" bottom: 0; left: 0 ; z-index:2">
                                <div class="carousel-caption  w-100 h-100 grad"
                                     style=" bottom: 0; left: 0 ; z-index:2">
                                    <a href="${pageContext.request.contextPath}/Home/Details?id=${top10AllCate[i].id}"
                                       class=" carousel-caption d-none d-md-block p-0">
                                        <h2>${top10AllCate[i].title}</h2>
                                        <p>${top10AllCate[i].views} lượt xem</p>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
                <button class="carousel-control-prev" type="button" data-target="#carouselExampleCaptions"
                        data-slide="prev" style="z-index:3">
                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                    <span class="sr-only">Previous</span>
                </button>
                <button class="carousel-control-next" type="button" data-target="#carouselExampleCaptions"
                        data-slide="next" style="z-index:3">
                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                    <span class="sr-only">Next</span>
                </button>
            </div>


            <h3>Tin nóng trong tuần</h3>
            <div class="w-100 d-flex justify-content-between">
                <!--            5 bài nhiều lượt xem nhất trong tuần-->

                <div style=" width: 68% ">
                    <div class="w-100 d-flex justify-content-between">

                        <!--                    Bài báo top 1 trong tuần-->
                        <div style=" width: 66%">
                            <img src="${pageContext.request.contextPath}/photos/articles/${top5AllCateInWeek[0].id}/a.png"
                                 alt="" class="w-100">
                            <a href="${pageContext.request.contextPath}/Home/ByCat?id=${top5AllCateInWeek[0].id}">
                                <c:forEach items="${allCategories}" var="c">
                                    <c:if test="${c.id == top5AllCateInWeek[0].categories_id}">
                                        <b>${c.name_category}</b>
                                    </c:if>
                                </c:forEach>
                            </a>
                            <a href="${pageContext.request.contextPath}/Home/Details?id=${top5AllCateInWeek[0].id}">
                                <h4>
                                    <c:if test="${top5AllCateInWeek[0].premium == 0}">
                                        <i class="fa fa-star" aria-hidden="true" style="color: gold"></i>
                                    </c:if>
                                        ${top5AllCateInWeek[0].title}
                                </h4>
                            </a>
                        </div>

                        <!--                    Bài báo top 2 trong tuần-->
                        <div style=" width: 32%; background-image: linear-gradient(to bottom, #EEEEEE, #EEEEEE, transparent) ">
                            <img src="${pageContext.request.contextPath}/photos/articles/${top5AllCateInWeek[1].id}/a.png"
                                 alt="" class="w-100">
                            <div class="p-2" style="">
                                <a href="${pageContext.request.contextPath}/Home/ByCat?id=${top5AllCateInWeek[1].id}">
                                    <c:forEach items="${allCategories}" var="c">
                                        <c:if test="${c.id == top5AllCateInWeek[1].categories_id}">
                                            <b>${c.name_category}</b>
                                        </c:if>
                                    </c:forEach>
                                <a href="${pageContext.request.contextPath}/Home/Details?id=${top5AllCateInWeek[1].id}">
                                    <h6><b>
                                        <c:if test="${top5AllCateInWeek[1].premium == 0}">
                                            <i class="fa fa-star" aria-hidden="true" style="color: gold"></i>
                                        </c:if>
                                            ${top5AllCateInWeek[1].title}</b> <br> <br>
                                        <p>${top5AllCateInWeek[1].abstract_content}</p>
                                    </h6>
                                </a>
                            </div>
                        </div>
                    </div>

                    <!--                    Bài báo top 3-5 trong tuần-->

                    <div class=" pt-3 w-100 d-flex justify-content-between">
                        <c:forEach var="i" begin="2" end="4">
                            <div style=" width: 32%">
                                <img src="${pageContext.request.contextPath}/photos/articles/${top5AllCateInWeek[i].id}/a.png"
                                     alt="" class="w-100">
                                <a href="${pageContext.request.contextPath}/Home/ByCat?id=${top5AllCateInWeek[i].id}">
                                    <c:forEach items="${allCategories}" var="c">
                                        <c:if test="${c.id == top5AllCateInWeek[i].categories_id}">
                                            <b>${c.name_category}</b>
                                        </c:if>
                                    </c:forEach>
                                </a> <br>
                                <a href="${pageContext.request.contextPath}/Home/Details?id=${top5AllCateInWeek[i].id}">
                                    <c:if test="${top5AllCateInWeek[i].premium == 0}">
                                        <i class="fa fa-star" aria-hidden="true" style="color: gold"></i>
                                    </c:if>
                                        ${top5AllCateInWeek[i].title}
                                </a>
                            </div>
                        </c:forEach>
                    </div>
                    <br>
                    <hr>

                    <!--                Chục hình bên dưới cùng-->
                    <h5>Một số thông tin liên quan</h5>
                    <c:forEach items="${latestNewsAllCate}" var="c">
                        <div class=" mb-3 w-100 d-flex justify-content-between">
                            <div style="width: 30%">
                                <img style="width: 100%"
                                     src="${pageContext.request.contextPath}/photos/articles/${c.id}/a.png"
                                     alt="">
                            </div>
                            <div style="width: 69%" class="pl-2 d-flex flex-column justify-content-between">
                                <div>
                                    <a href="${pageContext.request.contextPath}/Home/ByCat?id=${c.categories_id}">
                                        <c:forEach items="${allCategories}" var="d">
                                            <c:if test="${d.id == c.categories_id}">
                                                <b>${d.name_category}</b>
                                            </c:if>
                                        </c:forEach>
                                    </a> <br>
                                    <a href="${pageContext.request.contextPath}/Home/Details?id=${c.id}">
                                        <c:if test="${c.premium == 0}">
                                            <i class="fa fa-star" aria-hidden="true" style="color: gold"></i>
                                        </c:if>
                                            ${c.title} <br>
                                            ${c.abstract_content}
                                    </a>
                                </div>
                                <div class="d-flex w-100 align-items-end">
                                    <a href="" class="mr-3">
                                        <img src="https://i.pinimg.com/originals/08/65/f1/0865f1362bb63020b5a5aa5a9994ee5a.jpg"
                                             alt="" style="width: 30px; height: 30px; border-radius: 30px">
                                        Anh 7 cute
                                    </a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>

                <!--            10 bài có lượt xem cao nhất theo mỗi danh mục-->
                <div class="" style="width: 30%">
                    <h5>Top 10 bài báo nhiều lượt xem nhất theo mỗi danh mục</h5> <br>
                    <div style="border-style: solid; border-color: cornflowerblue ; border-top: none; border-right:none; border-top-left-radius: 0; border-bottom-right-radius: 0">
                        <c:forEach items="${newest10PerCate}" var="c">
                            <div class="w-100 mb-3 pl-2 d-flex justify-content-between align-items-start" ;>
                                <div style="width: 59%">
                                    <a href="${pageContext.request.contextPath}/Home/ByCat?id=${c.categories_id}">
                                        <c:if test="${c.premium == 0}">
                                            <i class="fa fa-star" aria-hidden="true" style="color: gold"></i>
                                        </c:if>
                                        <c:forEach items="${allCategories}" var="d">
                                            <c:if test="${d.id == c.categories_id}">
                                                <b>${d.name_category}</b>
                                            </c:if>
                                        </c:forEach>
                                    </a> <br>
                                    <a href="${pageContext.request.contextPath}/Home/Details?id=${c.id}"
                                       style="line-height: 0">
                                            ${c.title}
                                    </a>
                                </div>
                                <div class=" align-items-center" style="width: 40%">
                                    <img class="w-100"
                                         src="${pageContext.request.contextPath}/photos/articles/${c.id}/a.png"
                                         alt="">
                                </div>
                            </div>
                        </c:forEach>
                    </div>
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
    </div>
</m:main>
