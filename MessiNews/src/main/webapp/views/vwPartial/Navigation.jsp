<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<jsp:useBean id="authUser" scope="session" type="com.messi.king.messinews.models.Users"/>
<jsp:useBean id="allPCategories" scope="request" type="java.util.List<com.messi.king.messinews.models.ParentCategories>"/>
<jsp:useBean id="allCategories" scope="request" type="java.util.List<com.messi.king.messinews.models.Categories>"/>

<nav>
    <form action="" method="post">
    <div class="collapse navbar-collapse d-flex justify-content-between px-4 py-3">
        <div class="d-flex align-items-center" style="width: 50%">
            <div class="pl-3">
                <a name="logo" href="${pageContext.request.contextPath}/" style="text-decoration: none">
                    <img src="${pageContext.request.contextPath}/photos/logos/LogoMessi.png" alt="" style="width: 70px">
                </a>
            </div>
            <div class="pl-1 pt-3">
                <a href="${pageContext.request.contextPath}/" style="text-decoration: none"
                   class="d-flex flex-column align-items-center">
                    <h2 style="line-height: 10px;color: black"><b>Messi</b></h2>
                    <h6 style="color: blue; font-size: 15px">NEWS</h6>
                </a>
            </div>

            <div class="input-group pl-5" style="width: 70%; height: 40px">
                <div class="input-group-prepend">
                <span class="input-group-text bgColorGray"
                      style="border-top-left-radius: 20px;border-bottom-left-radius: 20px; border-style: none">
                      <i class="fa fa-search" aria-hidden="true" style=" color: grey"></i>
                </span>
                </div>
                <input id="search" type="text" class="form-control bgColorGray h-100"
                       placeholder="Bạn muốn tìm bài báo nào?"
                       style="border-top-right-radius: 20px;border-bottom-right-radius: 20px; border-style: none; outline: none">
            </div>
        </div>

        <div onload="check(${authUser.role})" class="dropleft">
            <a class="btn bgColorGray" href="#" role="button" data-toggle="dropdown"
               aria-expanded="false" style="border-radius: 40px">
                <div class="d-flex justify-items-center align-items-center">
                    <div>
                        <img class="imageIcon"
                             src="https://media.bongda.com.vn/resize/630x539/files/hai.phan/2022/07/07/chuyen-nhuong-cau-thu-ronaldo-o-lai-man-utd-1806.jpg"
                             alt="">
                    </div>
                    <div>
                        <i class="fa fa-bars pl-3 pr-1" aria-hidden="true"></i>
                    </div>
                </div>
            </a>
            <div class="dropdown-menu">
                <c:choose>
                    <c:when test = "${authUser.role == 1}">
                        <a class="dropdown-item" href="${pageContext.request.contextPath}/Account/Profile">Thông tin cá nhân</a>
                        <a class="dropdown-item" href="${pageContext.request.contextPath}/Account/Password">Thay đổi mật khẩu</a>
                        <button class="dropdown-item" formaction="${pageContext.request.contextPath}/Account/Logout">Đăng xuất</button>
                    </c:when>

                    <c:when test = "${authUser.role == 2}">
                        <a class="dropdown-item" href="${pageContext.request.contextPath}/Account/Profile">Thông tin cá nhân</a>
                        <a class="dropdown-item" href="${pageContext.request.contextPath}/Account/Password">Thay đổi mật khẩu</a>
                        <a class="dropdown-item" href="${pageContext.request.contextPath}/Writer/Upload">Đăng bài viết</a>
                        <a class="dropdown-item" href="${pageContext.request.contextPath}/Writer/List">Danh sách bài viết</a>
                        <button class="dropdown-item" formaction="${pageContext.request.contextPath}/Account/Logout">Đăng xuất</button>
                    </c:when>

                    <c:when test = "${authUser.role == 3}">
                        <a class="dropdown-item" href="${pageContext.request.contextPath}/Account/Profile">Thông tin cá nhân</a>
                        <a class="dropdown-item" href="${pageContext.request.contextPath}/Account/Password">Thay đổi mật khẩu</a>
                        <a class="dropdown-item" href="${pageContext.request.contextPath}/Editor/List">Danh sách các bản thảo</a>
                        <button class="dropdown-item" formaction="${pageContext.request.contextPath}/Account/Logout">Đăng xuất</button>
                    </c:when>

                    <c:when test = "${authUser.role == 4}">
                        <a class="dropdown-item" href="${pageContext.request.contextPath}/Account/Profile">Thông tin cá nhân</a>
                        <a class="dropdown-item" href="${pageContext.request.contextPath}/Account/Password">Thay đổi mật khẩu</a>
                        <a class="dropdown-item" href="${pageContext.request.contextPath}/Account/Password">Quản lý chuyên mục</a>
                        <a class="dropdown-item" href="${pageContext.request.contextPath}/Account/Password">Quản lý nhãn</a>
                        <a class="dropdown-item" href="${pageContext.request.contextPath}/Account/Password">Quản lý bài viết</a>
                        <a class="dropdown-item" href="${pageContext.request.contextPath}/Account/Password">Quản lý người dùng</a>
                        <button class="dropdown-item" formaction="${pageContext.request.contextPath}/Account/Logout">Đăng xuất</button>
                    </c:when>

                    <c:otherwise>
                        <a class="dropdown-item" href="${pageContext.request.contextPath}/Account/Login">Đăng nhập</a>
                        <a class="dropdown-item" href="${pageContext.request.contextPath}/Account/Register">Đăng ký</a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>


    <!--    10 danh mục ở đầu-->
    <div class="d-flex justify-content-center w-100">
        <div class="d-flex justify-content-between "
             style="border-style: solid; border-left: none; border-right: none; border-radius: 0; width: 70%">
            <c:forEach items="${allPCategories}" var="c">
                <div class="dropdown">
                    <a href="${pageContext.request.contextPath}/Home/ByPCat?id=${c.id}" role="button" class="dropbtn btn btn-outline-secondary">
                            ${c.name_parent_cate}
                    </a>
                    <div class="dropdown-content">
                        <c:forEach items="${allCategories}" var="d">
                            <c:if test="${d.parent_cate_id == c.id}">
                                <a href="${pageContext.request.contextPath}/Home/ByCat?id=${d.id}">${d.name_category}</a>
                            </c:if>
                        </c:forEach>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
    <br>
    <script>
        document.getElementById('PCat').onmouseover = function (){
            document.getElementById('PCat').visible = 'visible'
        }
    </script>
    </form>
</nav>