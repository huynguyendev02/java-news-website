<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="m" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:useBean id="editors" scope="request" type="java.util.List<com.messi.king.messinews.models.Users>"/>

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
                        <h4>Danh sách các biên tập</h4>
                        <a href="${pageContext.request.contextPath}/Admin/Users/Add"
                           class="mx-3 px-3 btn btn-outline-success"
                           style="border-radius: 20px" type="button">
                            <i class="fa fa-plus" aria-hidden="true"></i>
                            Thêm tài khoản mới
                        </a>
                    </div>

                    <hr>
                    <div>
                        <table class="w-100" cellpadding="5px">
                            <tr style="background-color: #EEEEEE">
                                <td align="center">Tài khoản</td>
                                <td align="center">Ngày tạo</td>
                                <td align="center">Số chuyên mục nhỏ đang quản lý</td>
                                <td align="center">Số chuyên mục lớn đang quản lý</td>
                                <td align="center"></td>
                                <td align="center"></td>
                            </tr>
                            <c:forEach items="${editors}" var="c">
                                <tr>
                                    <td align="center">
                                        <a href="${pageContext.request.contextPath}/Admin/Users/Profile?id=${c.id}">
                                                ${c.username}
                                        </a>
                                    </td>
                                    <td align="center">
                                        <script>
                                            document.write('${c.issue_at}'.slice(8, 10) + '/' + '${c.issue_at}'.slice(5, 7) + '/' + '${c.issue_at}'.slice(0, 4))
                                        </script>
                                    </td>
                                    <td align="center">${c.cateSum()}</td>
                                    <td align="center">${c.pcateSum()}</td>
                                    <td align="center">
                                        <a type="submit"
                                           href="${pageContext.request.contextPath}/Admin/Users/AssignCategory?editorId=${c.id}"
                                           class="btn btn-info">Phân quyền
                                        </a>
                                    </td>
                                    <td align="center">
                                        <button type="submit"
                                                formaction="${pageContext.request.contextPath}/Admin/Users/Delete?id=${c.id}"
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
