package com.messi.king.messinews.controllers;

import com.messi.king.messinews.models.Tags;
import com.messi.king.messinews.services.TagsService;
import com.messi.king.messinews.utils.ServletUtils;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "AdminTagsServlet", value = "/Admin/Tags/*")
public class AdminTagsServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String url = request.getPathInfo();
        switch (url){
            case "/List":
                List<Tags> tags = TagsService.findAll();
                request.setAttribute("tags",tags);
                ServletUtils.forward("/views/vwAdmin/TagsAdminList.jsp",request,response);
                break;
            case "/Edit":
                int id = 0;
                try {
                    id = Integer.parseInt(request.getParameter("id"));
                } catch (NumberFormatException e) {
                }
                Tags tag = TagsService.findById(id);
                if (tag!=null) {
                    request.setAttribute("tag",tag);
                    ServletUtils.forward("/views/vwAdmin/TagsAdminEdit.jsp",request,response);
                } else {
                    ServletUtils.forward("/views/204.jsp",request,response);
                }
                break;
            case "/Add":
                ServletUtils.forward("/views/vwAdmin/TagsAdminAdd.jsp",request,response);
                break;
            default:
                ServletUtils.forward("/views/404.jsp",request,response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String url = request.getPathInfo();
        switch (url){
            case "/Add":
                String nameTag = request.getParameter("nameTag");
                TagsService.add(nameTag);
                ServletUtils.redirect("/Admin/Tags/List", request, response);
                break;
            case "/Edit":
                editTag(request,response);
                break;
            case "/Delete":
                deleteTag(request,response);
                break;
            default:
                ServletUtils.forward("/views/404.jsp",request,response);
                break;
        }
    }

    private void deleteTag(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = 0;
        try {
            id = Integer.parseInt(request.getParameter("id"));
        } catch (NumberFormatException e) {
        }
        Tags tag = TagsService.findById(id);
        if (tag!=null) {
            TagsService.delete(tag);
            ServletUtils.redirect("/Admin/Tags/List",request,response);
        } else {
            ServletUtils.forward("/views/204.jsp",request,response);
        }
    }

    private void editTag(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = 0;
        try {
            id = Integer.parseInt(request.getParameter("id"));
        } catch (NumberFormatException e) {
        }
        Tags tag = TagsService.findById(id);
        if (tag!=null) {
            String nameTag = request.getParameter("nameTag");
            TagsService.edit(nameTag, tag);
            ServletUtils.redirect("/Admin/Tags/List",request,response);
        } else {
            ServletUtils.forward("/views/204.jsp",request,response);
        }
    }
}
