<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="m" tagdir="/WEB-INF/tags" %>

<m:main>
    <div class="d-flex justify-content-center">
        <div style="width: 15%"></div>
        <div style="width: 70%">
            <!--        10 bài báo được xem nhiều nhất (tất cả các danh mục)-->
            <div id="carouselExampleCaptions" class="carousel slide py-4" data-ride="carousel">
                <h3>Top 10 bài báo nhiều lượt xem nhất</h3>
                <ol class="carousel-indicators">
                    <li data-target="#carouselExampleCaptions" data-slide-to="0" class="active"></li>
                    <li data-target="#carouselExampleCaptions" data-slide-to="1"></li>
                    <li data-target="#carouselExampleCaptions" data-slide-to="2"></li>
                </ol>
                <div class="carousel-inner">
                    <div class="carousel-item active">
                        <img src="https://vnn-imgs-f.vgcloud.vn/2019/11/15/06/ronaldo-2.jpg" class="d-block crop"
                             alt="...">
                        <div class="carousel-caption  w-100 h-100 grad"
                             style=" bottom: 0; left: 0 ; z-index:2">
                            <a href="${pageContext.request.contextPath}/Home/Details" class=" carousel-caption d-none d-md-block">
                                <h3>First slide label </h3>
                                <h5>Some representative placeholder content for the first slide.</h5>
                            </a>
                        </div>
                    </div>

                    <div class="carousel-item">
                        <img src="https://image.bongda24h.vn/medias/640x458twebp/original/2021/10/1/ronaldo-tro-lai-dt-bo-dao-nha.jpg" class="d-block crop"
                             alt="...">
                        <div class="carousel-caption d-flex align-items-end w-100 h-100 grad"
                             style=" bottom: 0; left: 0 ; z-index:2">
                            <div class="carousel-caption  w-100 h-100 grad"
                                 style=" bottom: 0; left: 0 ; z-index:2">
                                <a href="${pageContext.request.contextPath}/Home/Details" class=" carousel-caption d-none d-md-block">
                                    <h3>Second slide label </h3>
                                    <h5>Some representative placeholder content for the first slide.</h5>
                                </a>
                            </div>
                        </div>
                    </div>
                    <div class="carousel-item">
                        <img src="https://znews-photo.zingcdn.me/w1200/Uploaded/sotnzt/2022_11_15/Ronaldo_Rashford.jpg" class="d-block crop"
                             alt="...">
                        <div class="carousel-caption d-flex align-items-end w-100 h-100 grad"
                             style=" bottom: 0; left: 0 ; z-index:2">
                            <div class="carousel-caption  w-100 h-100 grad"
                                 style=" bottom: 0; left: 0 ; z-index:2">
                                <a href="${pageContext.request.contextPath}/Home/Details" class=" carousel-caption d-none d-md-block">
                                    <h3>Third slide label </h3>
                                    <h5>Some representative placeholder content for the first slide.</h5>
                                </a>
                            </div>
                        </div>
                    </div>

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

                    <!--                2 hih trên-->
                    <div class="w-100 d-flex justify-content-between">

                        <!--                    Đứng đầu-->
                        <div style=" width: 66%">
                            <img src="https://hanoispiritofplace.com/wp-content/uploads/2014/10/hinh-anh-cr7-dep-1.jpg"
                                 alt="" class="w-100">
                            <a href="">Thể thao</a>
                            <a href="">
                                <h4>
                                    <i class="fa fa-star" aria-hidden="true" style="color: gold"></i>
                                    Tiêu đề
                                </h4>
                            </a>
                        </div>

                        <!--                    Hạng nhì-->
                        <div style=" width: 32%; background-image: linear-gradient(to bottom, #EEEEEE, #EEEEEE, transparent) ">
                            <img src="https://hanoispiritofplace.com/wp-content/uploads/2014/10/hinh-anh-cr7-dep-3.jpg"
                                 alt="" class="w-100">
                            <div class="p-2" style="">
                                <a href="">Thể thao</a>
                                <h6><b>
                                    <i class="fa fa-star" aria-hidden="true" style="color: gold"></i>
                                    Tiêu đề
                                </b></h6>
                                <h6>Anh 7 - Cầu thủ xuất sắc của mọi thời đại </h6>
                            </div>
                        </div>
                    </div>

                    <!--                3 hình dưới-->
                    <div class=" pt-3 w-100 d-flex justify-content-between">
                        <div style=" width: 32%">
                            <img src="https://hanoispiritofplace.com/wp-content/uploads/2014/10/hinh-anh-cr7-dep-4.jpg"
                                 alt="" class="w-100">
                            <a href="">Thể thao</a> <br>
                            <a href="">
                                <i class="fa fa-star" aria-hidden="true" style="color: gold"></i>
                                Tiêu đề
                            </a>
                        </div>
                        <div style=" width: 32%">
                            <img src="https://hanoispiritofplace.com/wp-content/uploads/2014/10/hinh-anh-cr7-dep-7.jpg"
                                 alt="" class="w-100">
                            <a href="">Thể thao</a> <br>
                            <a href="">
                                <i class="fa fa-star" aria-hidden="true" style="color: gold"></i>
                                Tiêu đề
                            </a>
                        </div>
                        <div style=" width: 32%">
                            <img src="https://hanoispiritofplace.com/wp-content/uploads/2014/10/hinh-anh-cr7-dep-8.jpg"
                                 alt="" class="w-100">
                            <a href="">Thể thao</a> <br>
                            <a href="">
                                <i class="fa fa-star" aria-hidden="true" style="color: gold"></i>
                                Tiêu đề
                            </a>
                        </div>
                    </div>
                    <br>
                    <hr>

                    <!--                Chục hình bên dưới cùng-->
                    <h5>Một số thông tin liên quan</h5>
                    <div class=" mb-3 w-100 d-flex justify-content-between">
                        <div style="width: 30%">
                            <img style="width: 100%"
                                 src="https://hanoispiritofplace.com/wp-content/uploads/2014/10/hinh-anh-cr7-dep-15.jpg"
                                 alt="">
                        </div>
                        <div style="width: 69%" class="pl-2">
                            <a href="">
                                <i class="fa fa-star" aria-hidden="true" style="color: gold"></i>
                                Tiêu đề
                            </a>
                            <p >Sự trở lại đẳng cấp của anh 7. Sự trở lại đẳng cấp của anh 7. Sự trở lại đẳng cấp của anh 7. Sự
                                trở lại đẳng cấp của anh 7
                            </p>
                            <div class="d-flex justify-content-between w-100">
                                <div>
                                    <a href="">
                                        <img src="https://i.pinimg.com/originals/08/65/f1/0865f1362bb63020b5a5aa5a9994ee5a.jpg" alt="" style="width: 30px; height: 30px; border-radius: 30px">
                                    </a>
                                    Anh 7 cute
                                </div>
                                <div>
                                    <a href="">Thể thao</a>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class=" mb-3 w-100 d-flex justify-content-between">
                        <div style="width: 30%">
                            <img style="width: 100%"
                                 src="https://hanoispiritofplace.com/wp-content/uploads/2014/10/hinh-anh-cr7-dep-15.jpg"
                                 alt="">
                        </div>
                        <div style="width: 69%" class="pl-2">
                            <a href="">
                                <i class="fa fa-star" aria-hidden="true" style="color: gold"></i>
                                Tiêu đề
                            </a>
                            <p >Sự trở lại đẳng cấp của anh 7. Sự trở lại đẳng cấp của anh 7. Sự trở lại đẳng cấp của anh 7. Sự
                                trở lại đẳng cấp của anh 7
                            </p>
                            <div class="d-flex justify-content-between w-100">
                                <div>
                                    <a href="">
                                        <img src="https://i.pinimg.com/originals/08/65/f1/0865f1362bb63020b5a5aa5a9994ee5a.jpg" alt="" style="width: 30px; height: 30px; border-radius: 30px">
                                    </a>
                                    Anh 7 cute
                                </div>
                                <div>
                                    <a href="">Thể thao</a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class=" mb-3 w-100 d-flex justify-content-between">
                        <div style="width: 30%">
                            <img style="width: 100%"
                                 src="https://hanoispiritofplace.com/wp-content/uploads/2014/10/hinh-anh-cr7-dep-15.jpg"
                                 alt="">
                        </div>
                        <div style="width: 69%" class="pl-2">
                            <a href="">
                                <i class="fa fa-star" aria-hidden="true" style="color: gold"></i>
                                Tiêu đề
                            </a>
                            <p >Sự trở lại đẳng cấp của anh 7. Sự trở lại đẳng cấp của anh 7. Sự trở lại đẳng cấp của anh 7. Sự
                                trở lại đẳng cấp của anh 7
                            </p>
                            <div class="d-flex justify-content-between w-100">
                                <div>
                                    <a href="">
                                        <img src="https://i.pinimg.com/originals/08/65/f1/0865f1362bb63020b5a5aa5a9994ee5a.jpg" alt="" style="width: 30px; height: 30px; border-radius: 30px">
                                    </a>
                                    Anh 7 cute
                                </div>
                                <div>
                                    <a href="">Thể thao</a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class=" mb-3 w-100 d-flex justify-content-between">
                        <div style="width: 30%">
                            <img style="width: 100%"
                                 src="https://hanoispiritofplace.com/wp-content/uploads/2014/10/hinh-anh-cr7-dep-15.jpg"
                                 alt="">
                        </div>
                        <div style="width: 69%" class="pl-2">
                            <a href="">
                                <i class="fa fa-star" aria-hidden="true" style="color: gold"></i>
                                Tiêu đề
                            </a>
                            <p >Sự trở lại đẳng cấp của anh 7. Sự trở lại đẳng cấp của anh 7. Sự trở lại đẳng cấp của anh 7. Sự
                                trở lại đẳng cấp của anh 7
                            </p>
                            <div class="d-flex justify-content-between w-100">
                                <div>
                                    <a href="">
                                        <img src="https://i.pinimg.com/originals/08/65/f1/0865f1362bb63020b5a5aa5a9994ee5a.jpg" alt="" style="width: 30px; height: 30px; border-radius: 30px">
                                    </a>
                                    Anh 7 cute
                                </div>
                                <div>
                                    <a href="">Thể thao</a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class=" mb-3 w-100 d-flex justify-content-between">
                        <div style="width: 30%">
                            <img style="width: 100%"
                                 src="https://hanoispiritofplace.com/wp-content/uploads/2014/10/hinh-anh-cr7-dep-15.jpg"
                                 alt="">
                        </div>
                        <div style="width: 69%" class="pl-2">
                            <a href="">
                                <i class="fa fa-star" aria-hidden="true" style="color: gold"></i>
                                Tiêu đề
                            </a>
                            <p >Sự trở lại đẳng cấp của anh 7. Sự trở lại đẳng cấp của anh 7. Sự trở lại đẳng cấp của anh 7. Sự
                                trở lại đẳng cấp của anh 7
                            </p>
                            <div class="d-flex justify-content-between w-100">
                                <div>
                                    <a href="">
                                        <img src="https://i.pinimg.com/originals/08/65/f1/0865f1362bb63020b5a5aa5a9994ee5a.jpg" alt="" style="width: 30px; height: 30px; border-radius: 30px">
                                    </a>
                                    Anh 7 cute
                                </div>
                                <div>
                                    <a href="">Thể thao</a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class=" mb-3 w-100 d-flex justify-content-between">
                        <div style="width: 30%">
                            <img style="width: 100%"
                                 src="https://hanoispiritofplace.com/wp-content/uploads/2014/10/hinh-anh-cr7-dep-15.jpg"
                                 alt="">
                        </div>
                        <div style="width: 69%" class="pl-2">
                            <a href="">
                                <i class="fa fa-star" aria-hidden="true" style="color: gold"></i>
                                Tiêu đề
                            </a>
                            <p >Sự trở lại đẳng cấp của anh 7. Sự trở lại đẳng cấp của anh 7. Sự trở lại đẳng cấp của anh 7. Sự
                                trở lại đẳng cấp của anh 7
                            </p>
                            <div class="d-flex justify-content-between w-100">
                                <div>
                                    <a href="">
                                        <img src="https://i.pinimg.com/originals/08/65/f1/0865f1362bb63020b5a5aa5a9994ee5a.jpg" alt="" style="width: 30px; height: 30px; border-radius: 30px">
                                    </a>
                                    Anh 7 cute
                                </div>
                                <div>
                                    <a href="">Thể thao</a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class=" mb-3 w-100 d-flex justify-content-between">
                        <div style="width: 30%">
                            <img style="width: 100%"
                                 src="https://hanoispiritofplace.com/wp-content/uploads/2014/10/hinh-anh-cr7-dep-15.jpg"
                                 alt="">
                        </div>
                        <div style="width: 69%" class="pl-2">
                            <a href="">
                                <i class="fa fa-star" aria-hidden="true" style="color: gold"></i>
                                Tiêu đề
                            </a>
                            <p >Sự trở lại đẳng cấp của anh 7. Sự trở lại đẳng cấp của anh 7. Sự trở lại đẳng cấp của anh 7. Sự
                                trở lại đẳng cấp của anh 7
                            </p>
                            <div class="d-flex justify-content-between w-100">
                                <div>
                                    <a href="">
                                        <img src="https://i.pinimg.com/originals/08/65/f1/0865f1362bb63020b5a5aa5a9994ee5a.jpg" alt="" style="width: 30px; height: 30px; border-radius: 30px">
                                    </a>
                                    Anh 7 cute
                                </div>
                                <div>
                                    <a href="">Thể thao</a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class=" mb-3 w-100 d-flex justify-content-between">
                        <div style="width: 30%">
                            <img style="width: 100%"
                                 src="https://hanoispiritofplace.com/wp-content/uploads/2014/10/hinh-anh-cr7-dep-15.jpg"
                                 alt="">
                        </div>
                        <div style="width: 69%" class="pl-2">
                            <a href="">
                                <i class="fa fa-star" aria-hidden="true" style="color: gold"></i>
                                Tiêu đề
                            </a>
                            <p >Sự trở lại đẳng cấp của anh 7. Sự trở lại đẳng cấp của anh 7. Sự trở lại đẳng cấp của anh 7. Sự
                                trở lại đẳng cấp của anh 7
                            </p>
                            <div class="d-flex justify-content-between w-100">
                                <div>
                                    <a href="">
                                        <img src="https://i.pinimg.com/originals/08/65/f1/0865f1362bb63020b5a5aa5a9994ee5a.jpg" alt="" style="width: 30px; height: 30px; border-radius: 30px">
                                    </a>
                                    Anh 7 cute
                                </div>
                                <div>
                                    <a href="">Thể thao</a>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>

                <!--            10 bài có lượt xem cao nhất theo mỗi danh mục-->
                <div class="" style="width: 30%">
                    <h5>Top 10 bài báo nhiều lượt xem nhất theo mỗi danh mục</h5> <br>
                    <div style="border-style: solid; border-color: cornflowerblue ; border-top: none; border-right:none; border-top-left-radius: 0; border-bottom-right-radius: 0">
                        <div class="w-100 mb-3 pl-2 d-flex justify-content-between align-items-start" ;>
                            <div style="width: 59%">
                                <a href="">Thể thao</a> <br>
                                <b style="line-height: 0"> Anh 7 vừa đẹp trai vừa đá bóng hay</b>
                            </div>
                            <div class=" align-items-center" style="width: 40%">
                                <img class="w-100"
                                     src="https://hanoispiritofplace.com/wp-content/uploads/2014/10/hinh-anh-cr7-dep-12.jpg"
                                     alt="">
                            </div>
                        </div>

                        <div class="w-100 mb-3 pl-2 d-flex justify-content-between align-items-center" ;>
                            <div style="width: 59%">
                                <a href="">Thể thao</a> <br>
                                <b style="line-height: 0"> Anh 7 vừa đẹp trai vừa đá bóng hay</b>
                            </div>
                            <div class=" align-items-center" style="width: 40%">
                                <img class="w-100"
                                     src="https://hanoispiritofplace.com/wp-content/uploads/2014/10/hinh-anh-cr7-dep-12.jpg"
                                     alt="">
                            </div>
                        </div>
                        <div class="w-100 mb-3 pl-2 d-flex justify-content-between align-items-center" ;>
                            <div style="width: 59%">
                                <a href="">Thể thao</a> <br>
                                <b style="line-height: 0"> Anh 7 vừa đẹp trai vừa đá bóng hay</b>
                            </div>
                            <div class=" align-items-center" style="width: 40%">
                                <img class="w-100"
                                     src="https://hanoispiritofplace.com/wp-content/uploads/2014/10/hinh-anh-cr7-dep-12.jpg"
                                     alt="">
                            </div>
                        </div>
                        <div class="w-100 mb-3 pl-2 d-flex justify-content-between align-items-center" ;>
                            <div style="width: 59%">
                                <a href="">Thể thao</a> <br>
                                <b style="line-height: 0"> Anh 7 vừa đẹp trai vừa đá bóng hay</b>
                            </div>
                            <div class=" align-items-center" style="width: 40%">
                                <img class="w-100"
                                     src="https://hanoispiritofplace.com/wp-content/uploads/2014/10/hinh-anh-cr7-dep-12.jpg"
                                     alt="">
                            </div>
                        </div>
                        <div class="w-100 mb-3 pl-2 d-flex justify-content-between align-items-center" ;>
                            <div style="width: 59%">
                                <a href="">Thể thao</a> <br>
                                <b style="line-height: 0"> Anh 7 vừa đẹp trai vừa đá bóng hay</b>
                            </div>
                            <div class=" align-items-center" style="width: 40%">
                                <img class="w-100"
                                     src="https://hanoispiritofplace.com/wp-content/uploads/2014/10/hinh-anh-cr7-dep-12.jpg"
                                     alt="">
                            </div>
                        </div>
                        <div class="w-100 mb-3 pl-2 d-flex justify-content-between align-items-center" ;>
                            <div style="width: 59%">
                                <a href="">Thể thao</a> <br>
                                <b style="line-height: 0"> Anh 7 vừa đẹp trai vừa đá bóng hay</b>
                            </div>
                            <div class=" align-items-center" style="width: 40%">
                                <img class="w-100"
                                     src="https://hanoispiritofplace.com/wp-content/uploads/2014/10/hinh-anh-cr7-dep-12.jpg"
                                     alt="">
                            </div>
                        </div>
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
