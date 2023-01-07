<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="m" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:useBean id="admins" scope="request" type="java.util.List<com.messi.king.messinews.models.Users>"/>

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
                                <td align="center">Họ tên</td>
                                <td align="center">Ngày sinh</td>
                                <td align="center">Email</td>
                            </tr>
                            <c:forEach items="${admins}" var="c">
                                <tr>
                                    <td align="center">
                                        ${c.username}
                                    </td>
                                    <td align="center">
                                        <script>
                                            document.write('${c.issue_at}'.slice(8, 10) + '/' + '${c.issue_at}'.slice(5, 7) + '/' + '${c.issue_at}'.slice(0, 4))
                                        </script>
                                    </td>
                                    <td align="center">${c.full_name}</td>
                                    <td align="center">
                                        <script>
                                            document.write('${c.dob}'.slice(8, 10) + '/' + '${c.dob}'.slice(5, 7) + '/' + '${c.dob}'.slice(0, 4))
                                        </script>
                                    </td>

                                    <td align="center">${c.email}</td>
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
