package com.messi.king.messinews.controllers;

import com.messi.king.messinews.models.Users;
import com.messi.king.messinews.services.UsersService;
import com.messi.king.messinews.utils.ServletUtils;

import at.favre.lib.crypto.bcrypt.BCrypt;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@WebServlet(name = "AccountServlet", value = "/Account/*")
public class AccountServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String url = request.getPathInfo();
        switch (url) {
            case "/Login":
                request.setAttribute("errorMessage", "");
                ServletUtils.forward("/views/vwAccount/Login.jsp",request,response);
                break;
            case "/Register":
                ServletUtils.forward("/views/vwAccount/Register.jsp",request,response);
                break;
            case "/Forgot":
                ServletUtils.forward("/views/vwAccount/Forgot.jsp",request,response);
                break;
            case "/OTP":
                ServletUtils.forward("/views/vwAccount/OTP.jsp",request,response);
                break;
            case "/Profile":
                Users user = (Users) session.getAttribute("authUser");
                request.setAttribute("user",user);
                ServletUtils.forward("/views/vwAccount/Profile.jsp",request,response);
                break;
            case "/Password":
                ServletUtils.forward("/views/vwAccount/Password.jsp",request,response);
                break;

//

            case "/IsAvailable":
                String username = request.getParameter("username");
                String email = request.getParameter("email");

                Users userByName = UsersService.findByUsername(username);
                Users userByEmail = UsersService.findByEmail(email);

                boolean isAvailable = (userByName == null && userByEmail == null);

                PrintWriter outer = response.getWriter();
                response.setContentType("application/json");
                response.setCharacterEncoding("utf-8");

                outer.print(isAvailable);
                outer.flush();
                break;
            default:
                ServletUtils.forward("/views/404.jsp",request,response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String url = request.getPathInfo();
        switch (url) {
            case "/Login":
                login(request, response);
                break;
            case "/Register":
                registerUser(request, response);
                break;
            case "/Logout":
                logout(request, response);
                break;
            case "/Profile":
                editProfileUser(request,response);
            case "/ChangePassword":
                changePassword(request,response);
            case "/ChangeAvatar":
                changeAvatar(request,response);
            default:
                ServletUtils.forward("/views/404.jsp",request,response);
                break;
        }
    }

    private void changeAvatar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Users user  = (Users)request.getSession().getAttribute("authUser");
        String targetDir = this.getServletContext().getRealPath("photos/avatars/"+ user.getId());
        File dir = new File(targetDir);
        if (!dir.exists()) {
            dir.mkdir();
        }
        String destination = "";
        for (Part part: request.getParts()) {
            if (part.getName().equals("avatar")) {
                destination = targetDir + "/" + "avatar.png";
                part.write(destination);
            }

        }
    }

    private void changePassword(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        HttpSession session = request.getSession();

        String oldPassword = request.getParameter("oldPassword");
        Users sessionUser = (Users) session.getAttribute("authUser");
        BCrypt.Result result = BCrypt.verifyer().verify(oldPassword.toCharArray(), sessionUser.getPassword());

       if (result.verified) {
           String rawpwd = request.getParameter("rawpwd");
           String bcryptHashString = BCrypt.withDefaults().hashToString(12, rawpwd.toCharArray());

           UsersService.changePassword(sessionUser.getId(), bcryptHashString);
           ServletUtils.redirect("/Account/Profile",request,response);
       } else {
           request.setAttribute("errorMessage", "Mật khẩu cũ không chính xác, vui lòng thử lại!");
           ServletUtils.forward("/views/vwAccount/Password.jsp", request, response);
       }
    }

    private void editProfileUser(HttpServletRequest request, HttpServletResponse response) throws IOException {
        request.setCharacterEncoding("UTF-8");

        Users user = (Users) request.getSession().getAttribute("authUser");
        String fullName = request.getParameter("newFullName");
        String email = request.getParameter("newEmail");


        int role = user.getRole();
        try {
            role = Integer.parseInt(request.getParameter("role"));
        }catch (NumberFormatException e) {}

        LocalDateTime dob = user.getDob();
        if (!request.getParameter("newDob").equals("__/__/____"))
        {
            String strDob = request.getParameter("newDob") + " 00:00";
            DateTimeFormatter df = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
            dob = LocalDateTime.parse(strDob, df);
        }

        UsersService.updateProfile(user.getId(), fullName, role, email, dob);
        ServletUtils.redirect("/Account/Profile", request, response);
    }

    private void registerUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String rawpwd = request.getParameter("rawpwd");
        String bcryptHashString = BCrypt.withDefaults().hashToString(12, rawpwd.toCharArray());

        String strDob = request.getParameter("dob") + " 00:00";
        DateTimeFormatter df = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
        LocalDateTime dob = LocalDateTime.parse(strDob, df);

        String username = request.getParameter("username");
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");

        int role =0;
        try {
            role = Integer.parseInt(request.getParameter("role"));
        }catch (NumberFormatException e) {
        }


        Users c = new Users();
        if (role==1) {
            c = new Users(0, username,bcryptHashString, fullName, LocalDateTime.now(), 7*24*60,1,dob, email, null,null );
        } else {
            c = new Users(0, username,bcryptHashString, fullName, LocalDateTime.now(), 0,role,dob, email, null,null );
        }
        UsersService.add(c);
        ServletUtils.redirect("/Account/Login",request,response);
    }
    private void login(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        Users user = UsersService.findByUsername(username);

        if (user != null) {
            BCrypt.Result result = BCrypt.verifyer().verify(password.toCharArray(), user.getPassword());
            if (result.verified) {
                HttpSession session = request.getSession();
                session.setAttribute("auth", true);
                session.setAttribute("authUser", user);

                String url = (String) session.getAttribute("retUrl");
                if (url == null)
                    url = "/Home";
                ServletUtils.redirect(url, request, response);
            } else {
                request.setAttribute("errorMessage", "Thông tin đăng nhập không chính xác");
                ServletUtils.forward("/views/vwAccount/Login.jsp", request, response);
            }
        } else {
            request.setAttribute("errorMessage", "Thông tin đăng nhập không chính xác");
            ServletUtils.forward("/views/vwAccount/Login.jsp", request, response);
        }
    }
    private void logout(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        session.setAttribute("auth", false);
        session.setAttribute("authUser", new Users());

        String url = request.getHeader("referer");
        if (url == null)
            url = "/Home";
        ServletUtils.redirect(url, request, response);
    }
}
