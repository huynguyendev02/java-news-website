package com.messi.king.messinews.controllers;

import at.favre.lib.crypto.bcrypt.BCrypt;
import com.messi.king.messinews.models.Users;
import com.messi.king.messinews.services.CategoriesService;
import com.messi.king.messinews.services.EditorService;
import com.messi.king.messinews.services.UsersService;
import com.messi.king.messinews.utils.ServletUtils;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@WebServlet(name = "AdminUsersServlet", value = "/Admin/Users/*")
public class AdminUsersServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String url = request.getPathInfo();
        switch (url) {
            case "/Profile":
                int id = 0;
                try {
                    id = Integer.parseInt(request.getParameter("id"));
                } catch (NumberFormatException e) {
                }
                Users user = UsersService.findById(id);
                request.setAttribute("user", user);
                ServletUtils.forward("/views/vwAdmin/ProfileAdmin.jsp", request, response);
                break;
            case "/ListSub":
                request.setAttribute("subs", UsersService.findAllByRole(1));
                ServletUtils.forward("/views/vwAdmin/SubsAdminList.jsp", request, response);
                break;
            case "/ListWriter":
                request.setAttribute("writers", UsersService.findAllByRole(2));
                ServletUtils.forward("/views/vwAdmin/WritersAdminList.jsp", request, response);
                break;
            case "/ListEditor":
                request.setAttribute("editors", UsersService.findAllByRole(3));
                ServletUtils.forward("/views/vwAdmin/EditorsAdminList.jsp", request, response);
                break;
            case "/ListAdmin":
                request.setAttribute("editors", UsersService.findAllByRole(4));
                ServletUtils.forward("/views/vwAdmin/AdminList.jsp", request, response);
                break;
            case "/ExtendExp":
                getExtendExp(request, response);
                break;
            case "/AssignCategory":
                int editorId = 0;
                try {
                    editorId = Integer.parseInt(request.getParameter("editorId"));
                } catch (NumberFormatException e) {
                }
                Users editor = UsersService.findById(editorId);
                if (editor != null) {
                    request.setAttribute("editor", editor);
                    request.setAttribute("cates", CategoriesService.findAllByEditorId(editor.getId()));
                    ServletUtils.forward("/views/vwAdmin/CateAdminAssign.jsp", request, response);
                } else {
                    ServletUtils.forward("/views/204.jsp", request, response);
                }
                break;
            case "/Add":
                ServletUtils.forward("/views/vwAdmin/UserAdminAdd.jsp", request, response);
                break;
            default:
                ServletUtils.forward("/views/404.jsp", request, response);
                break;
        }
    }

    private static void getExtendExp(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = 0;
        try {
            id = Integer.parseInt(request.getParameter("id"));
        } catch (NumberFormatException e) {
        }
        Users user = UsersService.findById(id);
        request.setAttribute("user", user);
        ServletUtils.forward("/views/vwAdmin/SubsAdminExtendExpiration.jsp", request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String url = request.getPathInfo();
        switch (url) {
            case "/Profile":
                adminUpdateUser(request, response);
                break;
            case "/AssignCategory":
                assignCategories(request, response);
                break;
            case "/Add":
                adminAddUser(request, response);
                break;
            case "/Delete":
                adminDeleteUser(request, response);
                break;
            case "/ExtendExp":
                adminExtendExpUser(request, response);
                break;
            default:
                ServletUtils.forward("/views/404.jsp", request, response);
                break;
        }
    }

    private static void assignCategories(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        int editorId = 0;
        try {
            editorId = Integer.parseInt(request.getParameter("editorId"));
        } catch (NumberFormatException e) {
        }
        Users editor = UsersService.findById(editorId);
        if (editor != null) {

            String[] catesIdStr = request.getParameter("catesId")
                    .split(",");
            int[] catesId = Arrays
                    .stream(catesIdStr)
                    .mapToInt(Integer::parseInt)
                    .toArray();

            UsersService.assignCategories(editorId, catesId);

            ServletUtils.redirect("/Admin/Users/Profile?id=" + editorId, request, response);
        } else {
            ServletUtils.forward("/views/204.jsp", request, response);
        }
    }

    private void adminUpdateUser(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        request.setCharacterEncoding("UTF-8");

        int id = 0;
        try {
            id = Integer.parseInt(request.getParameter("id"));
        } catch (NumberFormatException e) {
        }
        System.out.println(id);
        Users user = UsersService.findById(id);
        if (user != null) {
            String fullName = request.getParameter("newFullName");
            String email = request.getParameter("newEmail");
            int role = user.getRole();
            try {
                role = Integer.parseInt(request.getParameter("role"));
            } catch (NumberFormatException e) {
            }
            LocalDateTime dob = user.getDob();
            if (!request.getParameter("newDob").equals("__/__/____")) {
                String strDob = request.getParameter("newDob") + " 00:00";
                DateTimeFormatter df = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
                dob = LocalDateTime.parse(strDob, df);
            }
            UsersService.updateProfile(user.getId(), fullName, role, email, dob);
            ServletUtils.redirect("/Admin/Users/Profile?id="+id, request, response);
        } else
            ServletUtils.forward("/views/204.jsp", request, response);

    }

    private void adminDeleteUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = 0;
        try {
            id = Integer.parseInt(request.getParameter("id"));
        } catch (NumberFormatException e) {
        }
        Users user = UsersService.findById(id);
        if (user != null) {
            UsersService.delete(user);
            int role = user.getRole();
            switch (role) {
                case 1:
                    ServletUtils.redirect("/Admin/Users/ListSub", request, response);
                    break;
                case 2:
                    ServletUtils.redirect("/Admin/Users/ListWriter", request, response);
                    break;
                case 3:
                    ServletUtils.redirect("/Admin/Users/ListEditor", request, response);
                    break;
            }
        } else {
            ServletUtils.forward("/views/204.jsp", request, response);
        }

    }

    private void adminAddUser(HttpServletRequest request, HttpServletResponse response) throws IOException {
        request.setCharacterEncoding("UTF-8");

        String rawpwd = request.getParameter("rawpwd");
        String bcryptHashString = BCrypt.withDefaults().hashToString(12, rawpwd.toCharArray());

        String strDob = request.getParameter("dob") + " 00:00";
        DateTimeFormatter df = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
        LocalDateTime dob = LocalDateTime.parse(strDob, df);

        String username = request.getParameter("username");
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");

        int role = 0;
        try {
            role = Integer.parseInt(request.getParameter("role"));
        } catch (NumberFormatException e) {
        }

        Users c = new Users();
        if (role == 1) {
            c = new Users(0, username, bcryptHashString, fullName, LocalDateTime.now(), 7 * 24 * 60, 1, dob, email, null, null);
        } else {
            c = new Users(0, username, bcryptHashString, fullName, LocalDateTime.now(), 0, role, dob, email, null, null);
        }
        UsersService.add(c);
        switch (role) {
            case 1:
                ServletUtils.redirect("/Admin/Users/ListSub", request, response);
                break;
            case 2:
                ServletUtils.redirect("/Admin/Users/ListWriter", request, response);
                break;
            case 3:
                ServletUtils.redirect("/Admin/Users/ListEditor", request, response);
                break;
        }
    }

    private void adminExtendExpUser(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        int id = 0;
        try {
            id = Integer.parseInt(request.getParameter("id"));
        } catch (NumberFormatException e) {
        }
        Users user = UsersService.findById(id);
        if (user != null) {

            String expireDateStr = request.getParameter("expireDate") + " 00:00";
            DateTimeFormatter df = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
            LocalDateTime expireDate = LocalDateTime.parse(expireDateStr, df);

            UsersService.extendSubscriber(id, expireDate);
            ServletUtils.redirect("/Admin/Users/ListSub", request, response);
        } else {
            ServletUtils.forward("/views/204.jsp", request, response);
        }
    }
}
