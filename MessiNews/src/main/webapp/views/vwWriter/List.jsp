<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="m" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:useBean id="articlesList" scope="request" type="java.util.List<com.messi.king.messinews.models.Articles>"/>

<m:main>
    <jsp:attribute name="js">
        <script>
            function acceptClick() {
                $('#accept').css('display', 'block');
                $('#draft').css('display', 'none')
                $('#deny').css('display', 'none')
            }

            function draftClick() {
                $('#accept').css('display', 'none');
                $('#draft').css('display', 'block')
                $('#deny').css('display', 'none')
            }

            function denyClick() {
                $('#accept').css('display', 'none');
                $('#draft').css('display', 'none')
                $('#deny').css('display', 'block')
            }

            function confirmDelete(event) {
                if (!confirm("Bạn có chắc muốn xóa?")) {
                    event.preventDefault();
                }
            }
        </script>
    </jsp:attribute>
    <jsp:body>
        <form action="" method="post" class="h-100">
            <div class="d-flex justify-content-center bgColorGray">
                <!--    left-->
                <div class="bgColorGray" style="width: 15%">

                </div>

                <!--    center-->
                <div style="width: 70%; background-color: white" class="my-3 p-3">
                    <div class="d-flex justify-content-between">
                        <h4>Danh sách bài viết của bạn</h4>
                        <div>
                            <a class="mx-1 px-3 btn btn-outline-success" onclick="acceptClick()"
                               style="border-radius: 20px" type="button">
                                <i class="fa fa-check" aria-hidden="true"></i>
                                Đã duyệt
                            </a>
                            <a class="mx-1 px-3 btn btn-outline-warning" onclick="draftClick()"
                               style="border-radius: 20px" type="button">
                                <i class="fa fa-file-text-o" aria-hidden="true"></i>
                                Bản thảo
                            </a>
                            <a class="mx-1 px-3 btn btn-outline-danger" onclick="denyClick()"
                               style="border-radius: 20px" type="button">
                                <i class="fa fa-times" aria-hidden="true"></i>
                                Bị từ chối
                            </a>
                        </div>
                    </div>
                    <hr>
                    <br>

                    <div id="accept">
                        <table class="w-100" cellpadding="5px">
                            <tr style="background-color: #EEEEEE">
                                <td>Tiêu đề</td>
                                <td align="center">Tramg thái</td>
                                <td align="center">Ngày xuất bản</td>
                                <td align="center">Lượt xem</td>
                            </tr>
                            <c:forEach items="${articlesList}" var="c">
                                <c:if test="${c.status==1}">
                                    <tr>
                                        <td>
                                            <a href="${pageContext.request.contextPath}/Home/Details?id=${c.id}">
                                                    ${c.title}
                                            </a>
                                        </td>
                                        <td align="center">
                                            <p style="color: forestgreen"> Đã duyệt </p>
                                        </td>
                                        <td align="center">
                                            <script>
                                                document.write('${c.publish_date}'.slice(8, 10) + '/' + '${c.publish_date}'.slice(5, 7) + '/' + '${c.publish_date}'.slice(0, 4))
                                            </script>
                                        </td>
                                        <td align="center">
                                                ${c.views}</td>
                                    </tr>
                                </c:if>
                            </c:forEach>
                        </table>
                    </div>

                    <div id="draft" style="display: none">
                        <table class="w-100" cellpadding="5px">
                            <tr style="background-color: #EEEEEE">
                                <td>Tiêu đề</td>
                                <td align="center">Chuyên mục</td>
                                <td align="center">Trạng thái</td>
                                <td align="center"></td>
                            </tr>
                            <c:forEach items="${articlesList}" var="c">
                                <c:if test="${c.status==-1}">
                                    <tr>
                                        <td>
                                            <a href="${pageContext.request.contextPath}/Writer/Edit?id=${c.id}">
                                                    ${c.title}
                                            </a>
                                        </td>
                                        <td align="center">
                                                ${c.getCategoriesName(c.categories_id)}
                                        </td>
                                        <td align="center">
                                            <p style="color: goldenrod"> Bản thảo </p>
                                        </td>
                                        <td align="center">
                                            <button type="submit"
                                                    formaction="${pageContext.request.contextPath}/Writer/Delete?id=${c.id}"
                                                    onclick="confirmDelete(event)" class="btn btn-danger">Xóa
                                            </button>
                                        </td>
                                    </tr>
                                </c:if>
                            </c:forEach>
                        </table>
                    </div>

                    <div id="deny" style="display: none">
                        <table class="w-100" cellpadding="5px">
                            <tr style="background-color: #EEEEEE">
                                <td>Tiêu đề</td>
                                <td align="center">Chuyên mục</td>
                                <td align="center">Trạng thái</td>
                                <td align="center">Lý do</td>
                                <td align="center"></td>
                            </tr>
                            <c:forEach items="${articlesList}" var="c">
                                <c:if test="${c.status==0}">
                                    <tr>
                                        <td>
                                            <a href="${pageContext.request.contextPath}/Writer/Edit?id=${c.id}">
                                                    ${c.title}
                                            </a>
                                        </td>
                                        <td align="center">
                                                ${c.getCategoriesName(c.categories_id)}
                                        </td>
                                        <td align="center">
                                            <p style="color: red"> Bị từ chối </p>
                                        </td>
                                        <td align="center">
                                                ${c.reason}
                                        </td>
                                        <td align="center">
                                            <button type="submit"
                                                    formaction="${pageContext.request.contextPath}/Writer/Delete?id=${c.id}"
                                                    onclick="confirmDelete(event)" class="btn btn-danger">Xóa
                                            </button>
                                        </td>
                                    </tr>
                                </c:if>
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
