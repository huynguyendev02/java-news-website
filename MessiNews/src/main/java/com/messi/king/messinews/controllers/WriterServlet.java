package com.messi.king.messinews.controllers;

import com.messi.king.messinews.models.Articles;
import com.messi.king.messinews.models.Tags;
import com.messi.king.messinews.models.Users;
import com.messi.king.messinews.services.ArticlesService;
import com.messi.king.messinews.services.TagsService;
import com.messi.king.messinews.utils.ServletUtils;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.awt.*;
import java.io.File;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;

@WebServlet(name = "WriterServlet", value = "/Writer/*")
@MultipartConfig(
        fileSizeThreshold = 2 * 1024 *1024,
        maxFileSize = 50*1024*1024,
        maxRequestSize = 50*1024*1024
)
public class WriterServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String url = request.getPathInfo();
        HttpSession session = request.getSession();
        switch (url) {
            case "/List":
                Users user = (Users) session.getAttribute("authUser");
                System.out.println(user.getId());
                List<Articles> articlesList = ArticlesService.findByWriterId(user.getId());
                request.setAttribute("articlesList", articlesList);

                ServletUtils.forward("/views/vwWriter/List.jsp",request,response);
                break;
            case "/Upload":
                List<Tags> tagsList = TagsService.findAll();
                request.setAttribute("tags", tagsList);
                ServletUtils.forward("/views/vwWriter/Upload.jsp",request,response);
                break;
            case "/Edit":
                int id = 0;
                try {
                    id = Integer.parseInt(request.getParameter("id"));
                } catch (NumberFormatException e) {
                }
                Articles art = ArticlesService.findById(id);
                request.setAttribute("art", art);
                ServletUtils.forward("/views/vwWriter/Edit.jsp",request,response);
                break;
            default:
                ServletUtils.forward("/views/404.jsp",request,response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String url = request.getPathInfo();
        HttpSession session = request.getSession();
        switch (url) {
            case "/Upload":
                upload(request,response);
                break;
            case "/Edit":
                edit(request,response);
                break;
            case "/EditBackground":
                editImage("backgroundMain",request,response);
                break;
            case "/EditMain":
                editImage("imgMain",request,response);
                break;
            case "/Delete":
                delete(request,response);
                break;
            default:
                ServletUtils.forward("/views/404.jsp",request,response);
        }
    }

    private void editImage(String type, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = 0;
        try {
            id = Integer.parseInt(request.getParameter("id"));
        } catch (NumberFormatException e) {
        }
        Articles art = ArticlesService.findById(id);
        if (art!=null) {
            String targetDir = this.getServletContext().getRealPath("photos/articles/"+id);
            String destination = "";
            for (Part part: request.getParts()) {
                if (part.getName().equals(type)) {
                    destination = targetDir + "/" + (type.equals("imgMain") ? "a.png" : "b.png");
                    part.write(destination);
                }
            }
            ServletUtils.redirect("/Writer/List", request, response);
        } else
            ServletUtils.forward("/views/204.jsp",request,response);
    }



    private void delete(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        int id = 0;
        Articles art = ArticlesService.findById(id);
        if (art!=null) {
            ArticlesService.delete(art);
            ServletUtils.redirect("/Writer/List", request, response);
        } else
            ServletUtils.forward("/views/204.jsp",request,response);

    }

    private void edit(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        int id = 0;

        String title = request.getParameter("title");
        String abstractContent = request.getParameter("abstract");
        String content = request.getParameter("content");
        String[] listTagsID = request.getParameter("listTagId").split(",");;

        int[] tagsId = Arrays
                .stream(listTagsID)
                .mapToInt(Integer::parseInt)
                .toArray();
        int cateId = 0;
        try {
            cateId = Integer.parseInt(request.getParameter("cateId"));
            id = Integer.parseInt(request.getParameter("id"));
        } catch (NumberFormatException e) {
        }
        Articles art = ArticlesService.findById(id);
        if (art!=null) {
            ArticlesService.edit(id, title, abstractContent, content, cateId);
            TagsService.editTagsByArticle(id, tagsId);
            ServletUtils.redirect("/Writer/List", request, response);
        } else
            ServletUtils.forward("/views/204.jsp",request,response);
    }

    private void upload(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


        String title = request.getParameter("title");
        String abstractContent = request.getParameter("abstract");
        String content = request.getParameter("content");

        String[] listTagsID = request.getParameter("listTagId").split(",");;

        int[] tagsId = Arrays
                .stream(listTagsID)
                .mapToInt(Integer::parseInt)
                .toArray();

        int cateId = 0;
        try {
            cateId = Integer.parseInt(request.getParameter("cateId"));
        } catch (NumberFormatException e) {
        }

        int artId = ArticlesService.add(new Articles(0,title,null,0,abstractContent,content,cateId,0,((Users)request.getSession().getAttribute("authUser")).getId(),-1, null));

        TagsService.addTagsByArticle(artId, tagsId);

        String targetDir = this.getServletContext().getRealPath("photos/articles/"+artId);
        File dir = new File(targetDir);
        if (!dir.exists()) {
            dir.mkdir();
        }
        String destination = "";
        for (Part part: request.getParts()) {
            if (part.getName().equals("imgMain")) {
                destination = targetDir + "/" + "a.png";
                part.write(destination);
            }
            if (part.getName().equals("backgroundMain")) {
                destination = targetDir + "/" + "b.png";
                part.write(destination);
            }
        }
        ServletUtils.redirect("/Writer/List", request, response);
    }
}
