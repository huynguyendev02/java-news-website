package com.messi.king.messinews.controllers;

import com.messi.king.messinews.models.Users;
import com.messi.king.messinews.services.CategoriesService;
import com.messi.king.messinews.services.UsersService;
import com.messi.king.messinews.utils.ServletUtils;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "AdminUsersServlet", value = "/Admin/Users/*")
public class AdminUsersServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String url = request.getPathInfo();
        switch (url) {
            case "/Profile":
                int id = 0;
                try {
                    id = Integer.parseInt(request.getParameter("id"));
                } catch (NumberFormatException e) {
                }
                Users user = UsersService.findById(id);
                request.setAttribute("user",user);
                ServletUtils.forward("/views/vwAdmin/ProfileAdmin.jsp",request,response);

            case "/ListSub":
                request.setAttribute("subs", UsersService.findAllByRole(1));
                ServletUtils.forward("/views/vwAdmin/SubsAdminList.jsp",request,response);
                break;
            case "/ListWriter":
                request.setAttribute("writers", UsersService.findAllByRole(2));
                ServletUtils.forward("/views/vwAdmin/WritersAdminList.jsp",request,response);
                break;
            case "/ListEditor":
                request.setAttribute("editors", UsersService.findAllByRole(3));
                ServletUtils.forward("/views/vwAdmin/EditorsAdminList.jsp",request,response);
                break;
            case "/AssignCategory":
                int editorId = 0;
                try {
                    editorId = Integer.parseInt(request.getParameter("editorId"));
                } catch (NumberFormatException e) {
                }
                Users editor = UsersService.findById(editorId);
                if (editor!=null) {
                    request.setAttribute("editor", editor);
                    request.setAttribute("cates", CategoriesService.findAllByEditorId(editor.getId()));
                    ServletUtils.forward("/views/vwAdmin/CateAdminAssign.jsp",request,response);
                }else  {
                    ServletUtils.forward("/views/204.jsp",request,response);
                }
                break;
            case "/Add":
                ServletUtils.forward("/views/vwAdmin/UserAdminAdd.jsp", request, response);
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
            case "/Profile":
                int id = 0;
                try {
                    id = Integer.parseInt(request.getParameter("id"));
                } catch (NumberFormatException e) {
                }
                Users user = UsersService.findById(id);
                request.setAttribute("user",user);
                ServletUtils.forward("/views/vwAdmin/ProfileAdmin.jsp",request,response);
            case "/AssignCategory":
                int editorId = 0;
                try {
                    editorId = Integer.parseInt(request.getParameter("editorId"));
                } catch (NumberFormatException e) {
                }
                Users editor = UsersService.findById(editorId);
                if (editor!=null) {
                    List<Integer> catesId = (List<Integer>) request.getAttribute("catesId");
                    UsersService.assignCategories(editorId,catesId);
                    ServletUtils.redirect("/Admin/Users/Profile?id="+editorId, request, response);
                }else  {
                    ServletUtils.forward("/views/204.jsp",request,response);
                }
                break;
            case "/Add":
                ServletUtils.forward("/views/vwAdmin/UserAdminAdd.jsp", request, response);
                break;
            default:
                ServletUtils.forward("/views/404.jsp",request,response);
                break;
        }
    }
}
