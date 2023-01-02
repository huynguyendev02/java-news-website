<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="m" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:useBean id="art" scope="request" type="com.messi.king.messinews.models.Articles"/>

<m:main>
     <jsp:attribute name="css">
           <link href="https://cdn.jsdelivr.net/gh/kartik-v/bootstrap-fileinput@5.2.5/css/fileinput.min.css" media="all"
                 rel="stylesheet" type="text/css"/>
         <style>
             label{
                 font-weight: bold;
             }
         </style>
    </jsp:attribute>
    <jsp:attribute name="js">
        <script src="https://cdn.jsdelivr.net/gh/kartik-v/bootstrap-fileinput@5.2.5/js/fileinput.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-fileinput/5.2.5/themes/fa/theme.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-fileinput/5.2.5/js/locales/vi.min.js"></script>
         <script src="https://cdn.tiny.cloud/1/9j7smfctwfkjpq7dixag0611zkfac5z40r6ismhkjyo8zvmm/tinymce/6/tinymce.min.js" referrerpolicy="origin"></script>

        <script>
            $('.fuMain').fileinput({
                theme: 'fa',
                language: 'vi',
                dropZoneEnabled: false,
                allowedFileExtensions: ['jpg', 'png']
            });

            tinymce.init({
                selector: '#newContent',
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
        <form method="post" enctype="multipart/form-data">
            <div class="d-flex justify-content-center bgColorGray">
                <!--    left-->
                <div class="bgColorGray" style="width: 15%">
                </div>

                <!--    center-->
                <div style="width: 70%; background-color: white" class="my-3 p-3">
                    <div class="card">
                        <h4 class="card-header">
                            Chỉnh sửa bài báo
                        </h4>
                        <div class="card-body">
                            <label for="newTitle">Tiêu đề</label>
                            <input type="text" class="form-control" name="newTitle" id="newTitle" autofocus required
                                   value="${art.title}"/>
                            <br>
                            <label for="newAbstract">Nội dung tóm tắt</label>
                            <input type="text" class="form-control" name="newAbstract" id="newAbstract" required
                                   value="${art.abstract_content}"/>
                            <br>
                            <label for="newImgMain">Ảnh đại diện</label>
                            <input type="file" class="fuMain" name="newImgMain" id="newImgMain" required
                                   value ="${pageContext.request.contextPath}/photos/articles/${art.id}/a.png"/>
                            <br>
                            <label for="newBackgroundMain">Ảnh bìa</label>
                            <input type="file" class="fuMain" name="newBackgroundMain" id="newBackgroundMain"
                                   required
                                   value="${pageContext.request.contextPath}/photos/articles/${art.id}/b.png"/>
                            <br>

                            <div class="form-group">
                                <label for="newContent">Nội dung bài báo</label>
                                <textarea id="newContent" name="newContent" value="${art.content}"></textarea>
                            </div>
                        </div>
                        <div class="card-footer" align="end">
                            <button type="submit" class="btn btn-success">
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
