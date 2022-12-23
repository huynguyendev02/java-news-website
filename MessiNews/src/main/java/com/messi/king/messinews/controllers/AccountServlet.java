package com.messi.king.messinews.controllers;

import com.messi.king.messinews.models.Users;
import com.messi.king.messinews.services.UsersService;
import com.messi.king.messinews.utils.ServletUtils;

import at.favre.lib.crypto.bcrypt.BCrypt;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@WebServlet(name = "AccountServlet", value = "/Account/*")
public class AccountServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String url = request.getPathInfo();
        switch (url) {
            case "/Login":
                ServletUtils.forward("/views/vwAccount/Login.jsp",request,response);
                break;
            case "/Register":
                ServletUtils.forward("/views/vwAccount/Register.jsp",request,response);
                break;
            case "/Forgot":
                ServletUtils.forward("/views/vwAccount/Forgot.jsp",request,response);
                break;
            case "/Profile":
                ServletUtils.forward("/views/vwAccount/Profile.jsp",request,response);
                break;
            case "/IsAvailable":
                String username = request.getParameter("username");
                String email = request.getParameter("email");

                Users userByName = UsersService.findByUsername(username);
                Users userByEmail = UsersService.findByEmail(email);

                boolean isAvailable = (userByName == null && userByEmail == null);

                PrintWriter out = response.getWriter();
                response.setContentType("application/json");
                response.setCharacterEncoding("utf-8");

                out.print(isAvailable);
                out.flush();
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
            default:
                ServletUtils.forward("/views/404.jsp",request,response);
                break;
        }
    }
    private void registerUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String rawpwd = request.getParameter("rawpwd");
        String bcryptHashString = BCrypt.withDefaults().hashToString(12, rawpwd.toCharArray());

        String strDob = request.getParameter("dob");
        DateTimeFormatter df = DateTimeFormatter.ofPattern("dd/MM/yyyy");
        LocalDate dob = LocalDate.parse(strDob, df);

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
        ServletUtils.forward("/views/vwAccount/Login.jsp", request, response);
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
                request.setAttribute("hasError", true);
                request.setAttribute("errorMessage", "Thông tin đăng nhập không chính xác");
                ServletUtils.forward("/views/vwAccount/Login.jsp", request, response);
            }
        } else {
            request.setAttribute("hasError", true);
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
