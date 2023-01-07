<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="m" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:useBean id="allPCategories" scope="request"
             type="java.util.List<com.messi.king.messinews.models.ParentCategories>"/>
<jsp:useBean id="allCategories" scope="request" type="java.util.List<com.messi.king.messinews.models.Categories>"/>
<jsp:useBean id="tags" scope="request" type="java.util.List<com.messi.king.messinews.models.Tags>"/>
<jsp:useBean id="authUser" scope="session" type="com.messi.king.messinews.models.Users"/>


<m:main>
     <jsp:attribute name="css">
         <link rel="stylesheet"
               href="https://cdnjs.cloudflare.com/ajax/libs/jquery-datetimepicker/2.5.20/jquery.datetimepicker.min.css"
               integrity="sha512-f0tzWhCwVFS3WeYaofoLWkTP62ObhewQ1EZn65oSYDZUg1+CyywGKkWzm8BxaJj5HGKI72PnMH9jYyIFz+GH7g=="
               crossorigin="anonymous" referrerpolicy="no-referrer"/>
           <link href="https://cdn.jsdelivr.net/gh/kartik-v/bootstrap-fileinput@5.2.5/css/fileinput.min.css" media="all"
                 rel="stylesheet" type="text/css"/>
         <style>
             label {
                 font-weight: bold;
             }
         </style>
    </jsp:attribute>
    <jsp:attribute name="js">
        <script src="https://cdn.jsdelivr.net/gh/kartik-v/bootstrap-fileinput@5.2.5/js/fileinput.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-fileinput/5.2.5/themes/fa/theme.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-fileinput/5.2.5/js/locales/vi.min.js"></script>
         <script src="https://cdn.tiny.cloud/1/9j7smfctwfkjpq7dixag0611zkfac5z40r6ismhkjyo8zvmm/tinymce/6/tinymce.min.js"
                 referrerpolicy="origin"></script>
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


            $('.fuMain').fileinput({
                theme: 'fa',
                language: 'vi',
                dropZoneEnabled: false,
                allowedFileExtensions: ['jpg', 'png']
            });

            $('#publish_time').datetimepicker({
                format: 'd/m/Y',
                timepicker: false,
                mask: true
            });

            tinymce.init({
                selector: '#content',
                height: 450,
                plugins: 'paste image link autolink lists table media',
                menubar: false,
                toolbar: [
                    'undo redo | bold italic underline strikethrough | numlist bullist | alignleft aligncenter alignright | forecolor backcolor | table link image media'
                ],
            });
        </script>
  </jsp:attribute>
    <jsp:body>
        <form id="formAction" method="post" enctype="multipart/form-data">
            <div class="d-flex justify-content-center bgColorGray">
                <!--    left-->
                <div class="bgColorGray" style="width: 15%">
                </div>

                <!--    center-->
                <div style="width: 70%; background-color: white" class="mt-3 p-3">
                    <div class="card">
                        <h4 class="card-header">
                            Tạo bài báo mới
                        </h4>
                        <div class="card-body">
                            <label for="title">Tiêu đề</label>
                            <input type="text" class="form-control" name="title" id="title" autofocus required/><br>

                            <label for="abstract">Nội dung tóm tắt</label>
                            <input type="text" class="form-control" name="abstract" id="abstract" required/><br>

                            <label for="imgMain">Ảnh đại diện</label>
                            <input type="file" class="fuMain" name="imgMain" id="imgMain" required/><br>

                            <label for="backgroundMain">Ảnh bìa</label>
                            <input type="file" class="fuMain" name="backgroundMain" id="backgroundMain" required/><br>                             <br>

                            <label for="divCategory">Chọn chuyên mục</label>
                            <div id="divCategory" class="d-flex w-100">
                                <div class="dropdown" style="width: 20%">
                                    <button class="btn btn-outline-secondary btStyle w-100" type="button" id="btPCat"
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

                                <c:forEach items="${allPCategories}" var="c">
                                    <div id="divCat${c.id}" class="dropdown ml-5 listCat"
                                         style="display: none; width: 20%">
                                        <button id="btChillCat${c.id}"
                                                class="btn btn-outline-secondary btStyle btCat w-100" type="button"
                                                data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                            Chuyên mục nhỏ
                                        </button>
                                        <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                                            <c:forEach items="${allCategories}" var="d">
                                                <c:if test="${c.id == d.parent_cate_id}">
                                                    <a class="dropdown-item"
                                                       onclick="btCatClick('btChillCat${c.id}','${d.name_category}','${pageContext.request.contextPath}/Writer/Upload?cateId=${d.id}')">${d.name_category}</a>
                                                </c:if>
                                            </c:forEach>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div><br>

                            <c:if test="${authUser.role==4}">
                                <label for="publish_time">Ngày phát hành</label> <br>
                                <input name="publish_time" id="publish_time" type="text" class="form-control" style="width: 20%"> <br>

                                <label for="articleType">Loại báo</label>
                                <div id="articleType" class="pl-3">
                                    <input type="radio" id="normal" name="premium" value="0">
                                    <label for="normal">Thường</label><br>
                                    <input type="radio" id="premium" name="premium" value="1">
                                    <label for="premium">Cao cấp</label><br>
                                </div>
                                <br>
                            </c:if>

                            <label for="divTags">Chọn tag</label>
                            <div id="divTags">
                                <input id="listTagId" name="listTagId" type="text" style="display: none">
                                <c:forEach items="${tags}" var="c">
                                        <input class="ckBox ml-3" type="checkbox" id="checkBox${c.id}" value="${c.id}">
                                        <label for="checkBox${c.id}" style="font-weight: normal">${c.name_tags}</label>
                                </c:forEach>
                            </div><br>

                            <div class="form-group">
                                <label for="content">Nội dung bài báo</label>
                                <textarea id="content" name="content"></textarea>
                            </div>
                        </div>
                        <div class="card-footer" align="end">
                            <button onclick="setArrTag()" type="submit" class="btn btn-success">
                                <i class="fa fa-check" aria-hidden="true"></i>
                                Save
                            </button>
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
        </form>
    </jsp:body>
</m:main>
