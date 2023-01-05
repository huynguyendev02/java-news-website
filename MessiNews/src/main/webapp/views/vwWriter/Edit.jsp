<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="m" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:useBean id="allPCategories" scope="request"
             type="java.util.List<com.messi.king.messinews.models.ParentCategories>"/>
<jsp:useBean id="allCategories" scope="request" type="java.util.List<com.messi.king.messinews.models.Categories>"/>
<jsp:useBean id="categories" scope="request" type="com.messi.king.messinews.models.Categories"/>
<jsp:useBean id="allTags" scope="request" type="java.util.List<com.messi.king.messinews.models.Tags>"/>
<jsp:useBean id="tags" scope="request" type="java.util.List<com.messi.king.messinews.models.Tags>"/>
<jsp:useBean id="art" scope="request" type="com.messi.king.messinews.models.Articles"/>

<m:main>
     <jsp:attribute name="css">
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
        <script>
            function editContent() {
                $('#titleText').text('Chỉnh sửa nội dung');
                $('#editContent').css('display', 'block');
                $('#editAvatar').css('display', 'none');
                $('#editBackground').css('display', 'none');
            }

            function editAvatar() {
                $('#titleText').text('Chỉnh sửa ảnh đại diện');
                $('#editContent').css('display', 'none');
                $('#editAvatar').css('display', 'block');
                $('#editBackground').css('display', 'none');
            }

            function editBackground() {
                $('#titleText').text('Chỉnh sửa ảnh bìa');
                $('#editContent').css('display', 'none');
                $('#editAvatar').css('display', 'none');
                $('#editBackground').css('display', 'block');
            }

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

            window.onload = function () {
                let list = []
                <c:forEach items="${tags}" var="c">
                list.push(${c.id})
                </c:forEach>
                document.getElementById('listTagId').value = list;
                document.getElementById('divCat' +${categories.id}).style.display = 'block';
                document.getElementById('btChillCat' +${categories.id}).innerText = '${categories.name_category}';
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
        <div class="d-flex justify-content-center bgColorGray">
            <!--    left-->
            <div class="bgColorGray" style="width: 15%">
            </div>

            <!--    center-->
            <div style="width: 70%; background-color: white" class="my-3 p-3">
                <div>
                    <div class="d-flex justify-content-between">
                        <h3 id="titleText">Chỉnh sửa nội dung</h3>
                        <div>
                            <button onclick="editContent()" class="px-2 mx-1 btn btn-outline-info"
                                    style="border-radius: 20px" type="button">
                                <i class="fa fa-pencil" aria-hidden="true"></i>
                                Sửa nội dung
                            </button>
                            <button onclick="editAvatar()" class="px-2 mx-1 btn btn-outline-info"
                                    style="border-radius: 20px" type="button">
                                <i class="fa fa-camera" aria-hidden="true"></i>
                                Đổi Avatar
                            </button>
                            <button onclick="editBackground()" class="px-2 mx-1 btn btn-outline-info"
                                    style="border-radius: 20px" type="button">
                                <i class="fa fa-picture-o" aria-hidden="true"></i>
                                Đổi hình nền
                            </button>
                        </div>
                    </div>
                    <hr>

                        <%--                        Chỉnh sửa nội dung--%>
                    <div id="editContent">
                        <form id="formAction"
                              action="${pageContext.request.contextPath}/Writer/Edit?id=${art.id}&cateId=${art.categories_id}"
                              method="post" enctype="multipart/form-data">
                            <label for="title">Tiêu đề</label>
                            <input type="text" class="form-control" name="title" id="title" autofocus required
                                   value="${art.title}"/>
                            <br>
                            <label for="abstract">Nội dung tóm tắt</label>
                            <input type="text" class="form-control" name="abstract" id="abstract" required
                                   value="${art.abstract_content}"/>
                            <br>
                            <label for="divCategory">Chọn chuyên mục</label>
                            <div id="divCategory" class="d-flex w-100">
                                <div class="dropdown" style="width: 20%">
                                    <button class="btn btn-outline-secondary btStyle w-100" type="button" id="btPCat"
                                            data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                        <c:forEach items="${allPCategories}" var="c">
                                            <c:if test="${c.id == categories.parent_cate_id}">
                                                ${c.name_parent_cate}
                                            </c:if>
                                        </c:forEach>
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
                                                       onclick="btCatClick('btChillCat${c.id}','${d.name_category}','${pageContext.request.contextPath}/Writer/Edit?id=${art.id}&cateId=${d.id}')">${d.name_category}</a>
                                                </c:if>
                                            </c:forEach>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                            <br>
                            <label for="divTags">Chọn tag</label>
                            <div id="divTags">
                                <input id="listTagId" name="listTagId" type="text" style="display: none">
                                <c:forEach items="${allTags}" var="c">
                                    <c:set var="checkTag" value="0"/>
                                    <c:forEach items="${tags}" var="d">
                                        <c:if test="${c.id == d.id}">
                                            <c:set var="checkTag" value="1"/>
                                        </c:if>
                                    </c:forEach>
                                    <c:if test="${checkTag == 0}">
                                        <input class="ckBox ml-3" type="checkbox" id="checkBox${c.id}" value="${c.id}">
                                        <label for="checkBox${c.id}" style="font-weight: normal">${c.name_tags}</label>
                                    </c:if>
                                    <c:if test="${checkTag == 1}">
                                        <input class="ckBox ml-3" type="checkbox" id="checkBox${c.id}" value="${c.id}"
                                               checked>
                                        <label for="checkBox${c.id}" style="font-weight: normal">${c.name_tags}</label>
                                    </c:if>
                                </c:forEach>
                            </div>
                            <br>
                            <div class="form-group">
                                <label for="content">Nội dung bài báo</label>
                                <textarea id="content" name="content" value="${art.content}"></textarea>
                            </div>
                            <div class="mt-4" align="end">
                                <a href="${pageContext.request.contextPath}/Editor/ListDraft"
                                   class="btn btn-secondary mr-2">
                                    <i class="fa fa-times" aria-hidden="true"></i>
                                    Hủy bỏ
                                </a>
                                <button onclick="setArrTag()" class="btn btn-success" type="submit">
                                    <i class="fa fa-check" aria-hidden="true"></i>
                                    Hoàn thành
                                </button>
                            </div>
                        </form>
                    </div>

                        <%--                        Thay ảnh đại diện --%>
                    <div id="editAvatar" style="display: none">
                        <form action="${pageContext.request.contextPath}/Writer/EditMain?id=${art.id}" method="post"
                              enctype="multipart/form-data">
                            <div class="mb-3" style="width:30%">
                                <label for="CurrentAvatar">Ảnh đại diện hiện tại</label>
                                <img id="CurrentAvatar"
                                     src="${pageContext.request.contextPath}/photos/articles/${art.id}/a.png"
                                     class="w-100" alt="" style="border-style: solid">
                            </div>
                            <label for="imgMain">Chọn ảnh đại diện mới</label>
                            <input type="file" class="fuMain" name="imgMain" id="imgMain" required/>
                            <div class="mt-4" align="end">
                                <a href="${pageContext.request.contextPath}/Writer/List"
                                   class="btn btn-secondary">
                                    <i class="fa fa-times" aria-hidden="true"></i>
                                    Hủy bỏ
                                </a>
                            </div>
                        </form>
                    </div>

                        <%--                        Thay ảnh bìa --%>
                    <div id="editBackground" style="display: none">
                        <form action="${pageContext.request.contextPath}/Writer/EditBackground?id=${art.id}"
                              method="post" enctype="multipart/form-data">
                            <div class="mb-3" style="width:70%">
                                <label for="CurrentBackground">Ảnh bìa hiện tại</label>
                                <img id="CurrentBackground"
                                     src="${pageContext.request.contextPath}/photos/articles/${art.id}/b.png"
                                     class="w-100" alt="" style="border-style: solid">
                            </div>
                            <label for="backgroundMain">Chọn ảnh đại diện mới</label>
                            <input type="file" class="fuMain" name="backgroundMain" id="backgroundMain" required/>
                            <div class="mt-4" align="end">
                                <a href="${pageContext.request.contextPath}/Writer/List"
                                   class="btn btn-secondary">
                                    <i class="fa fa-times" aria-hidden="true"></i>
                                    Hủy bỏ
                                </a>
                            </div>
                        </form>
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
    </jsp:body>
</m:main>
