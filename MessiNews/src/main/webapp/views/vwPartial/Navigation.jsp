<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<nav>
  <div class="collapse navbar-collapse d-flex justify-content-between px-4 py-3">
    <div class="d-flex align-items-center" style="width: 50%">
      <div class="pl-3">
        <a name="logo" href="${pageContext.request.contextPath}/" style="text-decoration: none">
          <img src="${pageContext.request.contextPath}/photos/logos/LogoMessi.png" alt="" style="width: 70px">
        </a>
      </div>
      <div class="pl-1 pt-3">
        <a href="${pageContext.request.contextPath}/" style="text-decoration: none" class="d-flex flex-column align-items-center">
          <h2 style="line-height: 10px;color: black"><b>Méc xi</b></h2>
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
        <input id="search" type="text" class="form-control bgColorGray h-100" placeholder="Bạn muốn tìm bài báo nào?"
               style="border-top-right-radius: 20px;border-bottom-right-radius: 20px; border-style: none; outline: none">
      </div>
    </div>

    <div class="dropleft">
      <a class="btn bgColorGray" href="#" role="button" data-toggle="dropdown"
         aria-expanded="false" style="border-radius: 40px">
        <div class="d-flex justify-items-center align-items-center">
          <div>
            <img class="imageIcon" src="https://media.bongda.com.vn/resize/630x539/files/hai.phan/2022/07/07/chuyen-nhuong-cau-thu-ronaldo-o-lai-man-utd-1806.jpg" alt="">
          </div>
          <div>
            <i class="fa fa-bars pl-3 pr-1" aria-hidden="true"></i>
          </div>
        </div>
      </a>
      <div class="dropdown-menu">
        <a class="dropdown-item" href="${pageContext.request.contextPath}/Account/Login">Đăng nhập</a>
        <a class="dropdown-item" href="${pageContext.request.contextPath}/Account/Register">Đăng ký</a>
      </div>
    </div>
  </div>


  <!--    10 danh mục ở đầu-->
  <div class="d-flex justify-content-center w-100">
    <div class="d-flex justify-content-between " style="border-style: solid; border-left: none; border-right: none; border-radius: 0; width: 70%">
      <div class="btn-group">
        <button type="button" class="btn btn-outline-dark" data-toggle="dropdown"
                aria-haspopup="true" aria-expanded="false" style="border-style: none; border-radius: 10px">
          Chủ đề 1
        </button>
        <div class="dropdown-menu">
          <a class="dropdown-item" href="#">Action</a>
          <a class="dropdown-item" href="#">Another action</a>
          <a class="dropdown-item" href="#">Something else here</a>
          <a class="dropdown-item" href="#">Separated link</a>
        </div>
      </div>

      <div class="btn-group">
        <button type="button" class="btn btn-outline-dark" data-toggle="dropdown"
                aria-haspopup="true" aria-expanded="false" style="border-style: none; border-radius: 10px">
          Chủ đề 1
        </button>
        <div class="dropdown-menu">
          <a class="dropdown-item" href="#">Action</a>
          <a class="dropdown-item" href="#">Another action</a>
          <a class="dropdown-item" href="#">Something else here</a>
          <a class="dropdown-item" href="#">Separated link</a>
        </div>
      </div>
      <div class="btn-group">
        <button type="button" class="btn btn-outline-dark" data-toggle="dropdown"
                aria-haspopup="true" aria-expanded="false" style="border-style: none; border-radius: 10px">
          Chủ đề 1
        </button>
        <div class="dropdown-menu">
          <a class="dropdown-item" href="#">Action</a>
          <a class="dropdown-item" href="#">Another action</a>
          <a class="dropdown-item" href="#">Something else here</a>
          <a class="dropdown-item" href="#">Separated link</a>
        </div>
      </div>
      <div class="btn-group">
        <button type="button" class="btn btn-outline-dark" data-toggle="dropdown"
                aria-haspopup="true" aria-expanded="false" style="border-style: none; border-radius: 10px">
          Chủ đề 1
        </button>
        <div class="dropdown-menu">
          <a class="dropdown-item" href="#">Action</a>
          <a class="dropdown-item" href="#">Another action</a>
          <a class="dropdown-item" href="#">Something else here</a>
          <a class="dropdown-item" href="#">Separated link</a>
        </div>
      </div>
      <div class="btn-group">
        <button type="button" class="btn btn-outline-dark" data-toggle="dropdown"
                aria-haspopup="true" aria-expanded="false" style="border-style: none; border-radius: 10px">
          Chủ đề 1
        </button>
        <div class="dropdown-menu">
          <a class="dropdown-item" href="#">Action</a>
          <a class="dropdown-item" href="#">Another action</a>
          <a class="dropdown-item" href="#">Something else here</a>
          <a class="dropdown-item" href="#">Separated link</a>
        </div>
      </div>
      <div class="btn-group">
        <button type="button" class="btn btn-outline-dark" data-toggle="dropdown"
                aria-haspopup="true" aria-expanded="false" style="border-style: none; border-radius: 10px">
          Chủ đề 1
        </button>
        <div class="dropdown-menu">
          <a class="dropdown-item" href="#">Action</a>
          <a class="dropdown-item" href="#">Another action</a>
          <a class="dropdown-item" href="#">Something else here</a>
          <a class="dropdown-item" href="#">Separated link</a>
        </div>
      </div>
      <div class="btn-group">
        <button type="button" class="btn btn-outline-dark" data-toggle="dropdown"
                aria-haspopup="true" aria-expanded="false" style="border-style: none; border-radius: 10px">
          Chủ đề 1
        </button>
        <div class="dropdown-menu">
          <a class="dropdown-item" href="#">Action</a>
          <a class="dropdown-item" href="#">Another action</a>
          <a class="dropdown-item" href="#">Something else here</a>
          <a class="dropdown-item" href="#">Separated link</a>
        </div>
      </div>
      <div class="btn-group">
        <button type="button" class="btn btn-outline-dark" data-toggle="dropdown"
                aria-haspopup="true" aria-expanded="false" style="border-style: none; border-radius: 10px">
          Chủ đề 1
        </button>
        <div class="dropdown-menu">
          <a class="dropdown-item" href="#">Action</a>
          <a class="dropdown-item" href="#">Another action</a>
          <a class="dropdown-item" href="#">Something else here</a>
          <a class="dropdown-item" href="#">Separated link</a>
        </div>
      </div>
      <div class="btn-group">
        <button type="button" class="btn btn-outline-dark" data-toggle="dropdown"
                aria-haspopup="true" aria-expanded="false" style="border-style: none; border-radius: 10px">
          Chủ đề 1
        </button>
        <div class="dropdown-menu">
          <a class="dropdown-item" href="#">Action</a>
          <a class="dropdown-item" href="#">Another action</a>
          <a class="dropdown-item" href="#">Something else here</a>
          <a class="dropdown-item" href="#">Separated link</a>
        </div>
      </div>
      <div class="btn-group">
        <button type="button" class="btn btn-outline-dark" data-toggle="dropdown"
                aria-haspopup="true" aria-expanded="false" style="border-style: none; border-radius: 10px">
          Chủ đề 1
        </button>
        <div class="dropdown-menu">
          <a class="dropdown-item" href="#">Action</a>
          <a class="dropdown-item" href="#">Another action</a>
          <a class="dropdown-item" href="#">Something else here</a>
          <a class="dropdown-item" href="#">Separated link</a>
        </div>
      </div>
    </div>
  </div>
  <br>
</nav>
